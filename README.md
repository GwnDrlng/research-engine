# Research Engine

**A Claude Code–native framework that makes UX & Product research repeatable, efficient, and
governed.** Open Claude Code at this repo's root, say what you need — *"I need to do user research
on checkout drop-off"* — and Research Engine walks you through the workflow: planning, interview
prep, synthesis, and stakeholder-ready insights. Every artifact is checked by a separate
LLM-as-judge before it counts, and guardrails keep participant data and company policy safe.

Built on the "AI for UX" workflow described by LadyCarni / Design Bootcamp. Its guiding rule:

> **The value isn't in generating faster; it's in evaluating better.**
> AI drafts and organizes. **Human judgment is the product.**

## Visual overview

- 🗺️ **System architecture** — how the pieces fit together
  · [local](docs/architecture.html) · [shareable](https://claude.ai/code/artifact/08308535-f307-4945-b96e-f97ef68d42e6)
- 🚶 **User journey** — the end-to-end experience, step by step
  · [local](docs/user-journey.html) · [shareable](https://claude.ai/code/artifact/7cca1fe2-98fb-4377-af5f-d5014629d9b1)

## Quickstart

1. **Get the repo** and open it in Claude Code:
   ```bash
   git clone <your-fork-url> research-engine && cd research-engine
   claude
   ```
2. **Say what you need.** e.g. *"I need to do user research on onboarding drop-off."*
   The `CLAUDE.md` router starts the `/research` orchestrator, pressure-tests your brief with
   5–7 clarifying questions, and scaffolds a study folder under `projects/`.
3. **Work through the phases.** The orchestrator routes you to the right skill; each builds the
   deliverable in layers and then runs the judge.

## The workflow

| Phase | Skill | Produces |
|---|---|---|
| 1 · Plan | `research-plan` | research questions → method → screener → discussion guide |
| 2 · Interview | `research-interview` | audited guide, de-identified clean transcripts |
| 3 · Synthesize | `research-synthesis` | coded themes with counts + verbatim quotes |
| 4 · Insights | `research-insights` | 6-part insights, format-shifted for any audience |
| + Writing | `ux-writing` | voice/tone → per-element variants → judge |
| + Prototyping | `ux-prototype` | scope → load design system → generate with assumptions surfaced |
| + Handoff | `ux-handoff` | inventory → states/logic/a11y → completeness pass |

## The quality gate — LLM as judge

Every substantive artifact is scored by the **`ux-research-judge`** subagent
(`.claude/agents/ux-research-judge.md`) against a rubric in [`rubrics/`](rubrics/). It runs
*separately* from the drafting context so it's a genuinely independent reviewer, returning
per-criterion PASS/WARN/FAIL and ranked fixes. The rubrics encode the articles' evaluation
checklists (bias screening, quote fidelity, participant-breadth honesty, evidence proportionality…).

Meta-evals in [`evals/`](evals/) prove the judge catches planted defects — run `bash evals/run-evals.sh`.

## Governance & guardrails

Everything in [`governance/`](governance/), enforced by `CLAUDE.md` and a `PreToolUse` hook
(`scripts/guardrail-check.sh`):

- **PII / participant data** — deliverables use `P1..Pn`; raw identities live only in gitignored
  `projects/`. ([pii-handling.md](governance/pii-handling.md))
- **Company approval gate** — warn before ingesting external material; scaffolded and *bypassable*
  (`GATE_MODE: warn`) until you populate the allowlist. ([policy.md](governance/policy.md))
- **Anti-fabrication** — no invented insights, no synthetic users as real data, no quote without a
  verbatim source, thin themes labeled as hypotheses.
- **No external sending** — nothing is emailed, uploaded, or posted without explicit confirmation.

## Repo layout

```
CLAUDE.md              # the config/preferences layer + router + standing rules
.claude/
  agents/              # ux-research-judge — the LLM-as-judge subagent
  skills/              # /research orchestrator + phase skills
  settings.json        # permissions + guardrail hook
templates/             # deliverable scaffolds
rubrics/               # the judge's scoring checklists
governance/            # PII, approval gate, approved-tools allowlist
evals/                 # fixtures + harness that meta-evaluate the judge
docs/                  # designed HTML: architecture + user journey
projects/              # real studies live here — GITIGNORED, never committed
scripts/               # guardrail-check.sh
```

## A note on scope

This is a **generic, shareable template**. It ships with no organization-specific data — fill in
`governance/approved-tools.md` and `governance/policy.md` for your company before switching the
approval gate to `block`. Real study data never belongs in the template; it lives in `projects/`,
which git ignores.

## License

MIT — see [LICENSE](LICENSE).
