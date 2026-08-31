# Rubric — Discussion guide / research plan

Score each criterion **PASS / WARN / FAIL** with a one-line justification and, for WARN/FAIL, a
concrete fix. AI-written guides frequently contain leading or priming language — scrutinize hard.

## Criteria

1. **Specificity** — Questions are context-specific to this product/audience/decision, not generic
   templates that could apply to any study. `FAIL` if boilerplate.

2. **Methodological fit** — The questions match the stated method (attitudinal questions →
   interviews; behavioral questions → observation/analytics). Flag mismatches.

3. **Bias / leading-language screen** — Read every question as if aloud. Flag:
   - leading or priming phrasing ("How much do you love…")
   - double-barreled questions (two asks in one)
   - assumption-loaded phrasing ("When you got frustrated by X…")
   - closed questions where open would yield richer data
   - questions asking participants to predict future behavior
   `FAIL` if any leading/double-barreled/future-prediction question remains.

4. **Decision linkage** — Each core question connects to a stakeholder decision. `WARN` for
   questions that are merely "interesting."

5. **Structure & flow** — Warm-up before core, easy → hard, non-leading task framing, wrap-up that
   invites what was missed.

## What counts as acceptable

Consumers of this rubric (`evals/run-evals.sh` and the phase skills) treat **`PASS`, or `NEEDS-WORK`
carrying only `WARN` criteria and no `FAIL` criteria**, as acceptable. Anything with a criterion at
`FAIL` is not.

Be deliberate about `WARN` versus `FAIL` — that boundary is where the gate opens or closes. `WARN` is for
something a reader should know that does not make the artifact misleading. `FAIL` is for where a reader
acting on the artifact would be misled.

**Do not infer a threshold that is not written here.** If this section does not cover your case, say so
rather than supplying a rule. A judge has previously cited a non-existent *"WARN allowed on at most one
non-anti-fabrication criterion"* provision as though this file contained it, and reached a defensible
conclusion by way of a fabricated citation.

## Anti-fabrication checks (hard fails)
- No question presupposes a finding the research hasn't produced.

## Output format (the judge must return exactly this)
```
VERDICT: PASS | NEEDS-WORK | FAIL
SCORE: X/5 criteria passing
- [criterion]: PASS/WARN/FAIL — justification
  FIX: ... (for WARN/FAIL)
TOP 3 FIXES (ranked):
1. ...
```
