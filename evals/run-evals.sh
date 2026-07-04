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
# Requires the Claude Code CLI (`claude`) on PATH and authenticated. If absent, it explains how to
# run the checks manually and exits 0 (nothing to assert).

set -uo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

# fixture -> rubric mapping
declare -a CASES=(
  "guide-leading:discussion-guide"
  "guide-clean:discussion-guide"
  "synthesis-overclaimed:synthesis"
  "synthesis-sound:synthesis"
)

if ! command -v claude >/dev/null 2>&1; then
  cat <<'EOF'
[skip] `claude` CLI not found. Run each check manually inside a Claude Code session:

  For each fixture in evals/fixtures/, invoke the ux-research-judge subagent with the mapped
  rubric and confirm the VERDICT matches evals/expected/<fixture>.txt:
    - guide-leading         -> discussion-guide  -> expect FAIL
    - guide-clean           -> discussion-guide  -> expect PASS
    - synthesis-overclaimed -> synthesis         -> expect FAIL
    - synthesis-sound       -> synthesis         -> expect PASS
EOF
  exit 0
fi

pass=0
fail=0

extract_verdict() { # normalize judge output to PASS / NEEDS-WORK / FAIL
  grep -ioE 'VERDICT:[[:space:]]*(PASS|NEEDS-WORK|FAIL)' | head -1 \
    | grep -ioE '(PASS|NEEDS-WORK|FAIL)' | tr '[:lower:]' '[:upper:]' | head -1
}

for case in "${CASES[@]}"; do
  fixture="${case%%:*}"
  rubric="${case##*:}"
  expected="$(tr -d '[:space:]' < "evals/expected/${fixture}.txt")"

  prompt="Use the ux-research-judge subagent to evaluate the artifact at \
evals/fixtures/${fixture}.md against the rubric rubrics/${rubric}.md. \
Return the judge's full output including the 'VERDICT:' line."

  echo "── ${fixture} (rubric: ${rubric}, expect ${expected}) ──"
  out="$(claude -p "$prompt" 2>/dev/null)"
  verdict="$(printf '%s' "$out" | extract_verdict)"
  [ -z "$verdict" ] && verdict="(none)"

  # expected PASS: accept PASS. expected FAIL: require FAIL.
  ok=0
  if [ "$expected" = "PASS" ] && [ "$verdict" = "PASS" ]; then ok=1; fi
  if [ "$expected" = "FAIL" ] && [ "$verdict" = "FAIL" ]; then ok=1; fi

  if [ "$ok" = "1" ]; then
    echo "   ✓ got ${verdict}"
    pass=$((pass+1))
  else
    echo "   ✗ got ${verdict}, expected ${expected}"
    fail=$((fail+1))
  fi
done

echo
echo "Results: ${pass} passed, ${fail} failed."
[ "$fail" -eq 0 ]
