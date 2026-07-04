# Rubric — Insight report

Score each criterion **PASS / WARN / FAIL**. The test for every insight: could a skeptical PM act
on it Monday morning without being misled?

## Criteria

1. **Headline honesty** — The headline states an observation, not an opinion or recommendation
   dressed as a fact. `FAIL` if it overstates.

2. **Evidence proportionality** — Claim strength matches data strength. A strong claim on two
   participants is overreach. `FAIL` on any claim whose confidence exceeds its evidence.

3. **Uncertainty visibility** — "What we're still uncertain about" names substantive gaps, not
   boilerplate hedging. `WARN` if it's filler.

4. **Next-step actionability** — Provides one tactical/shippable and one strategic/alignment step,
   each concrete enough to execute. `WARN` if vague.

5. **Quote representativeness** — Supporting quotes are typical of the theme, not cherry-picked
   dramatic outliers. Every quote is verbatim and attributed. `FAIL` on unsourced quotes.

## Anti-fabrication checks (hard fails)
- No recommendation unsupported by a finding in the synthesis.
- No quote without a `P#` source.

## Output format
```
VERDICT: PASS | NEEDS-WORK | FAIL
SCORE: X/5 criteria passing
- [criterion]: PASS/WARN/FAIL — justification
  FIX: ...
OVERCLAIMED INSIGHTS: [list]
TOP 3 FIXES (ranked):
1. ...
```
