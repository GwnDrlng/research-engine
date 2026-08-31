# Rubric — Synthesis

Score each criterion **PASS / WARN / FAIL**. Human coders agree with a first AI pass only ~80–85%
of the time — assume ~15–20% of the draft is wrong and hunt for it.

## Criteria

1. **Quote-to-claim match** — Every theme's supporting quotes actually support that theme. Spot the
   quote that's been stretched to fit. `FAIL` on any claim whose quotes don't back it.

2. **Participant breadth honesty** — Themes are labeled with participant counts. Work the whole
   checklist below on **every** theme. See "Required procedure" — depth here is not optional.

   - **Thin-theme rule.** A theme from <3 participants is flagged as a *hypothesis*, not a finding.
     `FAIL` if a thin theme is presented as settled.
   - **Displayed-evidence rule.** **Every counted participant needs a displayed quote in that theme, or
     an explicit adjacency note stating why they are counted on weaker evidence.** Where a full quote
     would bloat the artifact, a per-participant citation to a code ID in the coding files
     (e.g. `P05 → 05-12`) is the minimum acceptable substitute. A bare participant list with no
     per-participant trace `FAIL`s: **a count that exists only in the coder's private notes is
     indistinguishable, to a reader, from one that was invented.**
   - **Sub-theme double-count.** No participant may appear in both a theme's and its sub-theme's
     headline count for the same incident.
   - **Compound-claim.** If the theme name or description joins two claims with "and", test each clause
     separately and require a count per clause. `FAIL` if the weaker clause inherits the stronger
     clause's N.
   - **Declared-exclusion.** Anyone the coding files exclude from counts — a stakeholder's feature
     request, second-hand testimony — must not be counted here.
   - **Hedge.** A hedged statement ("I guess", "maybe", "I think") is not evidence of the thing being
     hedged about, especially where the same participant contradicts it elsewhere.

3. **Real disagreement surfaced** — Genuine divergence between participants is documented, not
   smoothed into false consensus. `WARN` if everything agrees suspiciously.

4. **Descriptive vs. inferential** — "What users did/said" is kept separate from "why they acted."
   Inferred motivation is labeled as inference. `FAIL` if inference masquerades as observation.

5. **Quote fidelity** — Spot-check quotes against source: verbatim, attributed, timestamped where
   available. `FAIL` on any paraphrase presented as a quote, or any quote lacking a source line.

## Required procedure — no sampling on criterion 2

Criterion 2 is the expensive check and the one where real errors concentrate. **Its depth is not at the
judge's discretion.** For every theme, re-derive the participant list **one participant at a time**
against the coding files, and against the verbatim transcript layer where the codes are unclear. Do not
check one participant per theme and generalize from it.

Why this is mandatory: on the first real study this rubric was used for, three successive judge passes
returned **2/5 → 4/5 → 3/5**. The score *fell* on the third pass — not because the artifact got worse,
but because pass 3 re-derived where pass 2 sampled. **If depth varies between passes, scores are not
comparable and the loop can terminate on a lucky shallow pass**, which defeats the gate entirely.

State in your output which themes you re-derived. If you could not re-derive all of them, say so
explicitly rather than letting silence imply full coverage.

## What counts as acceptable

Consumers of this rubric (the eval harness and the synthesis skill) treat **`PASS`, or `NEEDS-WORK`
carrying only `WARN` criteria and no `FAIL` criteria**, as an acceptable outcome. Anything with a
criterion at `FAIL` is not.

So be deliberate about `WARN` versus `FAIL` — that boundary is where the gate actually opens or closes.
Use `WARN` for something a reader should know about that does not make the artifact misleading. Use
`FAIL` where a reader acting on the artifact would be misled.

## Anti-fabrication checks (hard fails)
- No quote without a traceable source (`P#` + location).
- No theme invented beyond the provided transcripts.
- No synthetic/role-played participant data mixed in as real.
- **No participant counted without a displayed quote, a code-ID citation, or an adjacency note.**
- **No disclosure of incomplete verification paired with a confidence claim about the unverified
  region.** Either verify it, or state the gap without reassurance. A caveat that admits ignorance and
  then reassures the reader borrows credibility from the admission — this is worse than no caveat, and
  it has occurred in live use.

## Output format
```
VERDICT: PASS | NEEDS-WORK | FAIL
SCORE: X/5 criteria passing
- [criterion]: PASS/WARN/FAIL — justification
  FIX: ...
UNSOURCED-QUOTE COUNT: N
THIN-THEME (<3p) COUNT: N
UNTRACED-PARTICIPANT COUNT: N   # counted, but no quote / code-ID / adjacency note
THEMES RE-DERIVED: all | <list>  # per-participant, per the required procedure
TOP 3 FIXES (ranked):
1. ...
```

**Per-theme count table (required).** Fill one row per theme. Most counting errors become visible the
moment this table is filled in honestly — which is the point of requiring it rather than accepting prose.

```
| theme | claim in one sentence | participants | traced for each? | evidence type per participant |
|-------|----------------------|--------------|------------------|-------------------------------|
| 1     | ...                  | P02,P04,P07  | Y / Y / N        | observed / self-report / —     |
```

Evidence types: `observed` (demonstrated in session) · `self-report` · `second-hand` (about someone
else's experience) · `system-description` (explaining how a tool behaves, not a witnessed event).
