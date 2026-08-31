# Eval run log

Appended by `evals/run-evals.sh`. Every attempt is recorded, including retries, so that what
had to be redone stays visible. Newest run last.

Columns: `case | rubric | attempt | verdict | score | criterion FAILs | outcome`.
Outcomes are `accepted`, `accepted (warn-level)`, `retried`, or `**UNRESOLVED — escalated**`.

---

## Run 2026-08-12 (backfilled by hand — pre-dates the logging code)

This run happened before `run-evals.sh` wrote a log, and before the retry policy existed. Reconstructed
from the harness output so the history isn't lost. **No retries were attempted** — the harness had no
retry logic yet, and its acceptance rule demanded an exact `PASS`, so the warn-level result on
`guide-clean` was recorded as a hard failure. Criterion-FAIL counts were not captured at the time.

| case | rubric | attempt | verdict | score | criterion FAILs | outcome |
|---|---|---|---|---|---|---|
| guide-leading | discussion-guide | 1 | FAIL | not captured | not captured | accepted |
| guide-clean | discussion-guide | 1 | NEEDS-WORK | not captured | **not captured** | failed (no retry available) |
| synthesis-overclaimed | synthesis | 1 | FAIL | not captured | not captured | accepted |
| synthesis-sound | synthesis | 1 | PASS | not captured | not captured | accepted |
| synthesis-arithmetic | synthesis | 1 | FAIL | not captured | not captured | accepted — **new fixture, first run, fires as intended** |
| synthesis-arithmetic (consistency) | synthesis | 1 | FAIL vs FAIL | — | — | accepted under the *old* verdict-only comparator |

**Result: 5 passed, 1 failed.**

## Investigation 2026-08-12 — `guide-clean`, run manually to resolve the failure above

Single targeted judge run, not a harness run. Logged because it resolves an escalation and because the
result is evidence about the judge itself.

| case | rubric | attempt | verdict | score | criterion FAILs | outcome |
|---|---|---|---|---|---|---|
| guide-clean | discussion-guide | 1 (investigation) | **PASS** | 4/5 (1 WARN) | **0** | resolved — fixture is clean |

**Resolution: scenario (B). The fixture is not defective.** 0 criteria at `FAIL`; the single `WARN` is on
the bias screen, for line 12 — *"Tell me about a time a checkout didn't go the way you expected."* — which
presupposes a negative incident occurred without an escape hatch, and is inconsistent with line 10 in the
same fixture, which does hedge (*"What, if anything, made you pause?"*). Suggested fix, **not applied**:
*"Was there ever a time a checkout didn't go the way you expected? If so, walk me through it."*

**Two findings about the judge, which matter more than the fixture:**

1. **Non-determinism confirmed on identical input.** The harness run returned `NEEDS-WORK`; this run
   returned `PASS`. Same fixture, same rubric, no changes in between. This is direct empirical support
   for the bounded-retry policy: the earlier result was a wobble, and under the current rules it would
   have been accepted as warn-level or cleared on retry rather than recorded as a hard failure.
2. **The judge confabulated a rubric provision.** It stated that *"the rubric's own PASS threshold
   explicitly allows 'WARN on at most one non-anti-fabrication criterion'"*. **No rubric contained any
   acceptance threshold** — a `grep` across all four confirmed it. The judge's conclusion was sound and
   checkable, but its justification cited a rule it had invented. Mitigation applied: an explicit
   *"What counts as acceptable"* section was added to `discussion-guide.md`, `insights.md` and
   `microcopy.md` (synthesis.md already had one), each ending with an instruction not to infer a
   threshold that isn't written down.

### Notes carried forward

- `guide-clean` is the only failure, and it is **pre-existing** — `git status` confirms the changes made
  that day never touched `rubrics/discussion-guide.md` or `fixtures/guide-clean.md`. Under the retry
  policy added afterwards it would be **accepted if its NEEDS-WORK is warn-level**, i.e. carries no
  criterion at `FAIL`. That is under investigation; the number was not captured at the time, which is
  precisely why the harness now records it.
- The consistency case passed under the **verdict-only** comparator, which is too weak to prove
  anything: a fixture with several planted defects returns `FAIL` at almost any depth of inspection. The
  comparator has since been changed to `verdict|score|untraced`. **Judge-depth stability is therefore
  still unproven** and needs a run under the new comparator.
