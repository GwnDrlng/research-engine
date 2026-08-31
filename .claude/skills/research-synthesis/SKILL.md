---
name: research-synthesis
description: Phase 3 of UX research — synthesize transcripts into themes. Use to normalize transcripts, code them one at a time, cluster into cross-transcript themes with participant counts and verbatim quotes, and run a quality self-audit. This is where AI saves the most time — and where ~15-20% of a first pass is wrong, so human review is non-negotiable.
---

# research-synthesis — Phase 3: synthesis

The biggest time compression in research — and the highest risk. AI agrees with expert human coders
only ~80–85% of the time, so **assume 15–20% of the first pass is wrong** and build in the audit.
Work through four steps, **one transcript at a time** for coding.

## Step 1 — Normalize
For each transcript: standardize speaker labels (`M`/`P`), remove filler while preserving
substance, bracket transcription errors/uncertain audio. Instruction to yourself:
**"Do not summarize. Do not interpret. Just clean."**

## Step 2 — First-pass coding (one transcript at a time)
Tag every distinct topic, observation, frustration, or stated need with:
- a **3–5 word theme tag**
- the **exact quote** (verbatim — never paraphrase)
- **timestamp** if present
- a **confidence note** (high / medium / low)

The confidence note is what separates observed statements from your inference. Use it honestly.

## Step 3 — Cross-transcript clustering
Consolidate tags into **6–10 higher-level themes**. For each, record in `templates/synthesis.md`:
- a clear descriptive name (what users did/said, not why)
- **participant numbers** contributing (and the count)
- 2–3 strongest supporting quotes, attributed
- **a trace for every participant you counted** — not just the ones you quoted. Each counted
  participant needs a displayed quote, a code-ID citation (`P05 → 05-12`), or an explicit adjacency note
  saying why they're counted on weaker evidence. **A bare participant list is the single most common
  real-world failure of this step**: the count is real in your notes and unverifiable to everyone else.
- **an evidence type per participant** — `observed` / `self-report` / `second-hand` /
  `system-description`. Never claim observational strength for a theme where only some evidence was
  observed.
- **one sentence stating the theme's claim.** Then test each participant's evidence against that exact
  sentence. If the sentence needs an "and", you have two themes with two different counts — split them.
- **contradicting evidence** (don't hide it)
- a **"limited evidence" flag** for any theme under 3 participants — it's a hypothesis, not a finding

## Step 4 — Quality self-audit
Critique your own synthesis:
- the weakest supporting quote per cluster
- alternative interpretations a skeptic would propose
- anywhere you inferred motivation beyond what was said
- candidate theme merges/splits

## Step 5 — Judge it
Invoke **`ux-research-judge`** with rubric `synthesis`. It checks quote fidelity, participant breadth,
over-consensus, and descriptive-vs-inferential framing.

**Bounded retry — the same policy the eval harness uses (`evals/README.md`):**

- **Acceptable:** `PASS`, or `NEEDS-WORK` carrying only `WARN` criteria and **no** `FAIL` criteria.
- **Not acceptable:** `FAIL`, or any criterion at `FAIL` → revise and re-judge.
- **At most 2 re-judges** (3 passes total). Then stop.
- **Log every pass**, including the ones you revised away — put the judge history in the artifact itself
  so a reader can see what had to be corrected and what forced each correction.
- **If it is still not acceptable after the third pass, escalate to the user and say so plainly in the
  artifact.** State what each pass returned and what you believe the candidate causes are. Do not keep
  looping: against a non-deterministic grader an unbounded loop eventually passes by luck rather than by
  improvement.

Acceptance of the artifact is **the human's**, not the judge's — a warn-level verdict means the gate is
satisfied, not that the work is right.

**Re-judge after every revision, without exception.** A fix is a new draft, not a patch. Two things
observed in live use make this non-negotiable:

- **Remediation text is itself unverified content, and it can regress.** In one study, the fix for an
  incomplete-audit problem *introduced* a new defect: a disclaimer that admitted the audit was
  incomplete and then asserted, in the same paragraph, that the unchecked themes were safe. The
  assertion was false. The original draft did not contain that error; the fix created it.
- **Judge scores are not comparable unless depth is held constant.** The same study scored
  2/5 → 4/5 → **3/5**; the score fell on the pass that re-derived participant counts where the previous
  pass had sampled. A rising score is not proof of improving work. If a pass returns a better score
  without having done the full per-participant re-derivation the rubric now mandates, treat the result
  as unverified rather than as progress.

## Guardrails (hard rules)
- **No quote without a verbatim source** (`P#` + location).
- **No theme invented** beyond the transcripts.
- **Themes from <3 participants are hypotheses**, labeled as such.
- Keep **observations separate from interpretations**. The human owns interpretation.
