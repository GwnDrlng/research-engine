#!/usr/bin/env bash
# Research Engine — meta-eval harness.
#
# Purpose: prove the LLM-as-judge catches planted defects and passes clean work. For each fixture
# it invokes the `ux-research-judge` subagent (via headless `claude -p`) and asserts the returned
# VERDICT matches evals/expected/<fixture>.txt.
#
# This is a regression guard: when you tune rubrics or the judge, re-run this to confirm the judge
# still flags the bad fixtures and passes the good ones.
#
# RETRY POLICY (project rule):
#   - Acceptable for an expected-PASS case: VERDICT PASS, **or** NEEDS-WORK carrying only WARN
#     criteria and no FAIL criteria ("warn-level"). The judge is non-deterministic; warn-level is a
#     pass for our purposes.
#   - If a case is not acceptable, retry it. **At most 2 retries** (3 attempts total).
#   - **Every attempt is logged** to evals/run-log.md, including the ones that were retried away. The
#     record of what had to be redone is the point.
#   - After 2 retries, stop retrying, **escalate to the user** in the summary, and log it as
#     UNRESOLVED. Do not loop hoping for a luckier roll — against a non-deterministic grader an
#     unbounded loop eventually passes by chance rather than by improvement.
#
# Requires the Claude Code CLI (`claude`) on PATH and authenticated. If absent, it explains how to
# run the checks manually and exits 0 (nothing to assert).

set -uo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

MAX_RETRIES=2
LOG="evals/run-log.md"
RUN_ID="$(date -u +%Y-%m-%dT%H:%M:%SZ)"

# fixture -> rubric mapping
declare -a CASES=(
  "guide-leading:discussion-guide"
  "guide-clean:discussion-guide"
  "synthesis-overclaimed:synthesis"
  "synthesis-sound:synthesis"
  "synthesis-arithmetic:synthesis"
)

# Consistency cases: run the SAME fixture twice and require the two runs to agree.
#
# Why this exists: on the first real study, three judge passes over successively-improved drafts
# returned 2/5 -> 4/5 -> 3/5. The score fell on the pass that re-derived participant counts where the
# previous pass had only sampled. If the judge's depth varies between invocations, verdicts are not
# comparable and a revise-and-re-judge loop can terminate on a lucky shallow pass — which defeats the
# gate. This case guards the property the gate depends on: same input, same result.
#
# `synthesis-arithmetic` is the right fixture for it because catching its defects REQUIRES the
# expensive per-participant re-derivation that rubrics/synthesis.md now mandates.
declare -a CONSISTENCY_CASES=(
  "synthesis-arithmetic:synthesis"
)

if ! command -v claude >/dev/null 2>&1; then
  cat <<'EOF'
[skip] `claude` CLI not found. Run each check manually inside a Claude Code session:

  For each fixture in evals/fixtures/, invoke the ux-research-judge subagent with the mapped
  rubric and confirm the VERDICT matches evals/expected/<fixture>.txt:
    - guide-leading         -> discussion-guide  -> expect FAIL
    - guide-clean           -> discussion-guide  -> expect PASS (warn-level accepted)
    - synthesis-overclaimed -> synthesis         -> expect FAIL
    - synthesis-sound       -> synthesis         -> expect PASS (warn-level accepted)
    - synthesis-arithmetic  -> synthesis         -> expect FAIL
                               (counting/scoping defects only; quote fidelity is clean, so a judge
                                that passes this one is not doing the per-participant re-derivation)

  Retry an unacceptable result at most twice, log every attempt in evals/run-log.md, and escalate
  anything still failing after the third attempt instead of retrying further.

  Then the consistency check: judge synthesis-arithmetic TWICE in separate sessions and confirm the
  VERDICT, SCORE and UNTRACED-PARTICIPANT COUNT all match. Divergence on identical input means judge
  depth is varying, and scores across revisions cannot be compared.
EOF
  exit 0
fi

pass=0
fail=0
declare -a ESCALATIONS=()

log() { printf '%s\n' "$*" >>"$LOG"; }

if [ ! -f "$LOG" ]; then
  log "# Eval run log"
  log ""
  log "Appended by \`evals/run-evals.sh\`. Every attempt is recorded, including retries, so that what"
  log "had to be redone stays visible. Newest run last."
  log ""
fi
log "## Run ${RUN_ID}"
log ""
log "| case | rubric | attempt | verdict | score | criterion FAILs | outcome |"
log "|---|---|---|---|---|---|---|"

extract_verdict() { # normalize judge output to PASS / NEEDS-WORK / FAIL
  grep -ioE 'VERDICT:[[:space:]]*(PASS|NEEDS-WORK|FAIL)' | head -1 \
    | grep -ioE '(PASS|NEEDS-WORK|FAIL)' | tr '[:lower:]' '[:upper:]' | head -1
}
extract_score() {   # "SCORE: 3/5" -> "3"
  grep -ioE 'SCORE:[[:space:]]*[0-9]+[[:space:]]*/[[:space:]]*5' | head -1 \
    | grep -oE '[0-9]+' | head -1
}
extract_untraced() { # "UNTRACED-PARTICIPANT COUNT: 3" -> "3"
  grep -ioE 'UNTRACED-PARTICIPANT COUNT:[[:space:]]*[0-9]+' | head -1 \
    | grep -oE '[0-9]+' | head -1
}
count_criterion_fails() { # criterion lines look like: "- Quote fidelity: FAIL — ..."
  grep -cE '^[[:space:]]*-[[:space:]]*[^:]+:[[:space:]]*FAIL' || true
}

run_judge() { # $1=fixture $2=rubric -> full judge output on stdout
  local p
  p="Use the ux-research-judge subagent to evaluate the artifact at \
evals/fixtures/${1}.md against the rubric rubrics/${2}.md. \
Return the judge's full output including the 'VERDICT:', 'SCORE:' and \
'UNTRACED-PARTICIPANT COUNT:' lines."
  claude -p "$p" 2>/dev/null
}

# Acceptable? $1=expected $2=verdict $3=criterion-fail-count
is_acceptable() {
  local expected="$1" verdict="$2" cfails="$3"
  if [ "$expected" = "PASS" ]; then
    # PASS, or warn-level NEEDS-WORK (no criterion at FAIL)
    [ "$verdict" = "PASS" ] && return 0
    [ "$verdict" = "NEEDS-WORK" ] && [ "$cfails" -eq 0 ] && return 0
    return 1
  fi
  # expected FAIL: the judge must actually fail it. Deliberately strict — this is the guard that
  # proves planted defects get caught, and loosening it would weaken the assertion.
  [ "$verdict" = "FAIL" ] && return 0
  return 1
}

for case in "${CASES[@]}"; do
  fixture="${case%%:*}"
  rubric="${case##*:}"
  expected="$(tr -d '[:space:]' < "evals/expected/${fixture}.txt")"

  echo "── ${fixture} (rubric: ${rubric}, expect ${expected}) ──"

  attempt=1
  ok=0
  while [ "$attempt" -le $((MAX_RETRIES + 1)) ]; do
    out="$(run_judge "$fixture" "$rubric")"
    verdict="$(printf '%s' "$out" | extract_verdict)"; [ -z "$verdict" ] && verdict="(none)"
    score="$(printf '%s' "$out" | extract_score)";     [ -z "$score" ] && score="?"
    cfails="$(printf '%s' "$out" | count_criterion_fails)"
    cfails="${cfails:-0}"

    if is_acceptable "$expected" "$verdict" "$cfails"; then
      if [ "$verdict" = "NEEDS-WORK" ]; then
        echo "   ✓ attempt ${attempt}: ${verdict} (warn-level, 0 criterion FAILs) — accepted"
        outcome="accepted (warn-level)"
      else
        echo "   ✓ attempt ${attempt}: got ${verdict}"
        outcome="accepted"
      fi
      log "| ${fixture} | ${rubric} | ${attempt} | ${verdict} | ${score}/5 | ${cfails} | ${outcome} |"
      ok=1
      break
    fi

    if [ "$attempt" -le "$MAX_RETRIES" ]; then
      echo "   ↻ attempt ${attempt}: got ${verdict} (${cfails} criterion FAILs), expected ${expected} — retrying"
      log "| ${fixture} | ${rubric} | ${attempt} | ${verdict} | ${score}/5 | ${cfails} | retried |"
    else
      echo "   ✗ attempt ${attempt}: got ${verdict} (${cfails} criterion FAILs), expected ${expected}"
      echo "     retry limit reached (${MAX_RETRIES} retries) — ESCALATING"
      log "| ${fixture} | ${rubric} | ${attempt} | ${verdict} | ${score}/5 | ${cfails} | **UNRESOLVED — escalated** |"
      ESCALATIONS+=("${fixture} (${rubric}): expected ${expected}, got ${verdict} with ${cfails} criterion FAILs after $((MAX_RETRIES + 1)) attempts")
    fi
    attempt=$((attempt + 1))
  done

  if [ "$ok" = "1" ]; then pass=$((pass + 1)); else fail=$((fail + 1)); fi
done

# Compare VERDICT *and* SCORE *and* the untraced-participant count — not the verdict alone.
#
# Verdict-only matching is too weak to detect the pathology this case exists for. A fixture with
# several planted defects returns FAIL under almost any depth of inspection, so FAIL==FAIL proves
# little. What actually varied in live use was the SCORE (2/5 -> 4/5 -> 3/5) and *which* defects were
# found — the coarse verdict stayed NEEDS-WORK throughout. So the signature includes the score and the
# untraced count, which is the number that moves when the judge samples instead of re-deriving.
judge_signature() { # $1=fixture $2=rubric -> "VERDICT|SCORE|UNTRACED"
  local out v s u
  out="$(run_judge "$1" "$2")"
  v="$(printf '%s' "$out" | extract_verdict)";   [ -z "$v" ] && v="(none)"
  s="$(printf '%s' "$out" | extract_score)";     [ -z "$s" ] && s="?"
  u="$(printf '%s' "$out" | extract_untraced)";  [ -z "$u" ] && u="?"
  printf '%s|%s|%s' "$v" "$s" "$u"
}

echo
echo "── consistency: same fixture, two runs, verdict+score+untraced must match ──"
for case in "${CONSISTENCY_CASES[@]}"; do
  fixture="${case%%:*}"
  rubric="${case##*:}"

  attempt=1
  ok=0
  while [ "$attempt" -le $((MAX_RETRIES + 1)) ]; do
    sig1="$(judge_signature "$fixture" "$rubric")"
    sig2="$(judge_signature "$fixture" "$rubric")"
    echo "   attempt ${attempt}: run1=${sig1}  run2=${sig2}   (verdict|score|untraced)"

    if [ "$sig1" = "$sig2" ] && [ "${sig1%%|*}" != "(none)" ]; then
      echo "   ✓ signatures match"
      log "| ${fixture} (consistency) | ${rubric} | ${attempt} | ${sig1} vs ${sig2} | — | — | accepted |"
      ok=1
      break
    fi

    if [ "$attempt" -le "$MAX_RETRIES" ]; then
      echo "   ↻ diverged on identical input — retrying"
      log "| ${fixture} (consistency) | ${rubric} | ${attempt} | ${sig1} vs ${sig2} | — | — | retried |"
    else
      echo "   ✗ still diverging after $((MAX_RETRIES + 1)) attempts — ESCALATING"
      echo "     judge depth is varying, so scores across revisions are not comparable and the"
      echo "     revise/re-judge loop can exit on a lucky shallow pass"
      log "| ${fixture} (consistency) | ${rubric} | ${attempt} | ${sig1} vs ${sig2} | — | — | **UNRESOLVED — escalated** |"
      ESCALATIONS+=("${fixture} consistency: signatures diverged on identical input across $((MAX_RETRIES + 1)) attempts (${sig1} vs ${sig2}) — judge depth is unstable")
    fi
    attempt=$((attempt + 1))
  done

  if [ "$ok" = "1" ]; then pass=$((pass + 1)); else fail=$((fail + 1)); fi
done

echo
echo "Results: ${pass} passed, ${fail} failed."
log ""
log "**Result: ${pass} passed, ${fail} failed.**"

if [ "${#ESCALATIONS[@]}" -gt 0 ]; then
  echo
  echo "╔══════════════════════════════════════════════════════════════════════════════╗"
  echo "║  ESCALATION — unresolved after ${MAX_RETRIES} retries. Needs a human decision.        ║"
  echo "╚══════════════════════════════════════════════════════════════════════════════╝"
  log ""
  log "### Escalated to user"
  for e in "${ESCALATIONS[@]}"; do
    echo "  • ${e}"
    log "- ${e}"
  done
  echo
  echo "  These are not retryable failures. Read the judge output and decide whether the fixture,"
  echo "  the rubric, or the expected verdict is wrong. Logged in ${LOG}."
fi

log ""
[ "$fail" -eq 0 ]
