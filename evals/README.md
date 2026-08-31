# Evals — meta-evaluating the judge

Research Engine's quality gate is the `ux-research-judge` subagent. These evals check **the judge
itself**: does it flag planted defects and pass clean work? Run them after changing any rubric or
the judge prompt.

## Run

```bash
bash evals/run-evals.sh
```

## Retry policy

The judge is non-deterministic, so the harness retries — but on a leash.

| Rule | |
|---|---|
| **Acceptable** | `PASS`, **or** `NEEDS-WORK` carrying only `WARN` criteria and **no** `FAIL` criteria ("warn-level") |
| **Not acceptable** | `FAIL`, or any result with a criterion at `FAIL` |
| **Retries** | **At most 2** (3 attempts total) |
| **Logging** | **Every attempt** is appended to [`run-log.md`](./run-log.md), including ones retried away |
| **After 2 retries** | Stop. Escalate to the user in the summary and log the case as `UNRESOLVED` |

Expected-`FAIL` cases stay strict — the judge must actually return `FAIL`. Loosening that would weaken
the guard that proves planted defects get caught.

**Why bounded rather than "retry until green":** against a non-deterministic grader, an unbounded loop
eventually passes by luck rather than by improvement, and a silent retry destroys the evidence that
anything needed fixing. An escalation carries the two candidate causes — usually *the fixture is wrong*
versus *the rubric or expected verdict is wrong* — because those need opposite fixes and guessing between
them produces the wrong one.

Requires the Claude Code CLI (`claude`) on PATH and authenticated. Without it, the script prints
the manual procedure and exits.

## What's covered

| Fixture | Rubric | Expected | Why |
|---|---|---|---|
| `guide-leading` | discussion-guide | **FAIL** | leading / double-barreled / future-prediction questions |
| `guide-clean` | discussion-guide | **PASS** | well-formed, non-leading |
| `synthesis-overclaimed` | synthesis | **FAIL** | thin theme as finding, unsourced quote, inference-as-observation |
| `synthesis-sound` | synthesis | **PASS** | sourced quotes, honest counts, thin theme flagged, **every counted participant traced** |
| `synthesis-arithmetic` | synthesis | **FAIL** | **the counting family** — untraced participants, sub-theme double-count, compound claim, hedge-as-evidence, violated exclusion, laundered disclaimer. Quote fidelity is deliberately clean, so a judge that passes this is not doing the per-participant re-derivation |

Plus a **consistency case**: `synthesis-arithmetic` is judged twice and the two runs must return the same
**verdict, score, and untraced-participant count**. Divergence on identical input means judge depth is
varying, so scores across revisions can't be compared and the revise/re-judge loop can exit on a lucky
shallow pass. See `CONSISTENCY_CASES` in `run-evals.sh`.

> Comparing the verdict alone is **too weak** to detect this. A fixture with several planted defects
> returns `FAIL` at almost any depth of inspection, so `FAIL == FAIL` proves nothing. In the live case
> that motivated this check, the coarse verdict stayed `NEEDS-WORK` across all three passes while the
> score moved 2/5 → 4/5 → 3/5. The score and the untraced count are what actually move when the judge
> samples instead of re-deriving.

> `synthesis-sound` was updated when the displayed-evidence rule landed in `rubrics/synthesis.md` — it
> previously claimed 4 participants on a theme while showing only 2 quotes, which the new rule correctly
> fails. It now traces every counted participant and labels an evidence type for each.

`expected/<fixture>.txt` holds the expected verdict. The harness maps `PASS` = judge returns PASS;
`FAIL` = judge returns FAIL.

## Adding a case
1. Drop a fixture in `fixtures/` (fully synthetic — no real PII).
2. Add `expected/<name>.txt` with `PASS` or `FAIL`.
3. Add a `"<name>:<rubric>"` entry to the `CASES` array in `run-evals.sh`.

## Observed failure modes (from live use)

[`observed-failure-modes.md`](./observed-failure-modes.md) records the failure modes that actually
occurred on the first real study — 11 participants, 3 judge passes — with proposed rubric, skill and
governance changes, and 9 proposed fixtures.

Two findings there bear on this suite directly:

- **Quote fidelity was never the failure.** Zero fabrications or misattributions across ~40 checked
  quotes. **Every** correction concerned participant counting and claim scoping. The current fixtures
  test the failures that didn't happen and miss the ones that did.
- **Judge scores were not comparable across passes** (2/5 → 4/5 → 3/5). The score fell on the pass that
  audited rather than sampled. If depth is left to the judge's discretion, the loop can terminate on a
  lucky shallow pass — which defeats the gate. Worth an eval of its own: run the same fixture twice and
  check the verdicts match.
