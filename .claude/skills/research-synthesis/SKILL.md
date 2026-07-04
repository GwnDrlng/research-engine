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
- **contradicting evidence** (don't hide it)
- a **"limited evidence" flag** for any theme under 3 participants — it's a hypothesis, not a finding

## Step 4 — Quality self-audit
Critique your own synthesis:
- the weakest supporting quote per cluster
- alternative interpretations a skeptic would propose
- anywhere you inferred motivation beyond what was said
- candidate theme merges/splits

## Step 5 — Judge it
Invoke **`ux-research-judge`** with rubric `synthesis`. It spot-checks quote fidelity, participant
breadth, over-consensus, and descriptive-vs-inferential framing. Revise and re-judge until accepted.

## Guardrails (hard rules)
- **No quote without a verbatim source** (`P#` + location).
- **No theme invented** beyond the transcripts.
- **Themes from <3 participants are hypotheses**, labeled as such.
- Keep **observations separate from interpretations**. The human owns interpretation.
