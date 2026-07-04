# Rubric — Synthesis

Score each criterion **PASS / WARN / FAIL**. Human coders agree with a first AI pass only ~80–85%
of the time — assume ~15–20% of the draft is wrong and hunt for it.

## Criteria

1. **Quote-to-claim match** — Every theme's supporting quotes actually support that theme. Spot the
   quote that's been stretched to fit. `FAIL` on any claim whose quotes don't back it.

2. **Participant breadth honesty** — Themes are labeled with participant counts. A theme from <3
   participants is flagged as a *hypothesis*, not a finding. `FAIL` if a thin theme is presented as
   settled.

3. **Real disagreement surfaced** — Genuine divergence between participants is documented, not
   smoothed into false consensus. `WARN` if everything agrees suspiciously.

4. **Descriptive vs. inferential** — "What users did/said" is kept separate from "why they acted."
   Inferred motivation is labeled as inference. `FAIL` if inference masquerades as observation.

5. **Quote fidelity** — Spot-check quotes against source: verbatim, attributed, timestamped where
   available. `FAIL` on any paraphrase presented as a quote, or any quote lacking a source line.

## Anti-fabrication checks (hard fails)
- No quote without a traceable source (`P#` + location).
- No theme invented beyond the provided transcripts.
- No synthetic/role-played participant data mixed in as real.

## Output format
```
VERDICT: PASS | NEEDS-WORK | FAIL
SCORE: X/5 criteria passing
- [criterion]: PASS/WARN/FAIL — justification
  FIX: ...
UNSOURCED-QUOTE COUNT: N
THIN-THEME (<3p) COUNT: N
TOP 3 FIXES (ranked):
1. ...
```
