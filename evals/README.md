# Evals — meta-evaluating the judge

Research Engine's quality gate is the `ux-research-judge` subagent. These evals check **the judge
itself**: does it flag planted defects and pass clean work? Run them after changing any rubric or
the judge prompt.

## Run

```bash
bash evals/run-evals.sh
```

Requires the Claude Code CLI (`claude`) on PATH and authenticated. Without it, the script prints
the manual procedure and exits.

## What's covered

| Fixture | Rubric | Expected | Why |
|---|---|---|---|
| `guide-leading` | discussion-guide | **FAIL** | leading / double-barreled / future-prediction questions |
| `guide-clean` | discussion-guide | **PASS** | well-formed, non-leading |
| `synthesis-overclaimed` | synthesis | **FAIL** | thin theme as finding, unsourced quote, inference-as-observation |
| `synthesis-sound` | synthesis | **PASS** | sourced quotes, honest counts, thin theme flagged |

`expected/<fixture>.txt` holds the expected verdict. The harness maps `PASS` = judge returns PASS;
`FAIL` = judge returns FAIL.

## Adding a case
1. Drop a fixture in `fixtures/` (fully synthetic — no real PII).
2. Add `expected/<name>.txt` with `PASS` or `FAIL`.
3. Add a `"<name>:<rubric>"` entry to the `CASES` array in `run-evals.sh`.
