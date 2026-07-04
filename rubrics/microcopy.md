# Rubric — UX writing / microcopy

Score each criterion **PASS / WARN / FAIL**. Polished copy that's subtly wrong for the user's
emotional moment is the failure mode to catch.

## Criteria

1. **Job clarity** — The copy does the one job it was assigned: **inform**, **influence**, or
   **support**. `FAIL` if it drifts (e.g., an error message that tries to upsell).

2. **Emotional fit** — Read back through the actual scenario and the user's likely emotional state.
   The tone fits that moment. `FAIL` if cheerful copy lands on a frustrating failure.

3. **Tells the user what to do next** — Action is unambiguous. `WARN` if the next step is implied
   but not stated.

4. **Constraint compliance** — Respects character limit, voice/tone, and accessibility (no
   direction-only or color-only instructions). `FAIL` on violations.

5. **No dark patterns** — No manipulation, false urgency, or confusing opt-outs. `FAIL` on any.

## Output format
```
VERDICT: PASS | NEEDS-WORK | FAIL
SCORE: X/5 criteria passing
- [criterion]: PASS/WARN/FAIL — justification
  FIX: ...
```
