# Research Engine

**A Claude Code-native framework that makes UX and Product research repeatable, efficient, and
governed.** Open Claude Code at this repo's root and say what you need, like *"I need to do user
research on checkout drop-off."* Research Engine walks you through the workflow. It covers planning,
interview prep, synthesis, and stakeholder-ready insights. A separate LLM-as-judge checks every
artifact before it counts. Guardrails keep participant data and company policy safe.

Built on the "AI for UX" workflow described by LadyCarni and Design Bootcamp
([the guide](https://medium.com/design-bootcamp/ai-for-ux-the-guide-you-wish-someone-had-given-you-sooner-d1401c9f2e0b),
[prompts and configuration](https://medium.com/@LadyCarni/prompts-preferences-and-configuration-007cd743a89a),
[research and discovery](https://medium.com/@LadyCarni/ai-for-ux-ai-across-the-ux-workflow-research-and-discovery-499845f73a63),
[writing, prototyping, and handoff](https://medium.com/design-bootcamp/ai-for-ux-ai-across-the-ux-workflow-writing-prototyping-and-handoff-4076a991abe0)).
Its guiding rule:

> **The value isn't in generating faster. It's in evaluating better.**
> AI drafts and organizes. **Human judgment is the product.**

## Visual overview

Rendered pages open in a new browser tab.

- 🗺️ <a href="https://gwndrlng.github.io/research-engine/docs/architecture.html" target="_blank" rel="noopener"><strong>System architecture</strong></a>, how the pieces fit together
  · <a href="docs/architecture.html">source</a>
- 🚶 <a href="https://gwndrlng.github.io/research-engine/docs/user-journey.html" target="_blank" rel="noopener"><strong>User journey</strong></a>, the end-to-end experience step by step
  · <a href="docs/user-journey.html">source</a>

## Quickstart

1. **Get the repo** and open it in Claude Code:
   ```bash
   git clone <your-fork-url> research-engine && cd research-engine
   claude
   ```
2. **Say what you need.** For example, *"I need to do user research on onboarding drop-off."*
   The `CLAUDE.md` router starts the `/research` orchestrator, pressure-tests your brief with
   5 to 7 clarifying questions, and scaffolds a study folder under `projects/`.
3. **Work through the phases.** The orchestrator routes you to the right skill. Each one builds the
   deliverable in layers, then runs the judge.

## The workflow

| Phase | Skill | Produces |
|---|---|---|
| 1 · Plan | `research-plan` | research questions → method → screener → discussion guide |
| 2 · Interview | `research-interview` | audited guide, de-identified clean transcripts |
| 3 · Synthesize | `research-synthesis` | coded themes with counts and verbatim quotes |
| 4 · Insights | `research-insights` | 6-part insights, format-shifted for any audience |
| + Writing | `ux-writing` | voice/tone → per-element variants → judge |
| + Prototyping | `ux-prototype` | scope → load design system → generate with assumptions surfaced |
| + Handoff | `ux-handoff` | inventory → states/logic/a11y → completeness pass |

## The quality gate: LLM as judge

Every substantive artifact is scored by the **`ux-research-judge`** subagent
(`.claude/agents/ux-research-judge.md`) against a rubric in [`rubrics/`](rubrics/). It runs
*separately* from the drafting context, so it acts as a genuinely independent reviewer. It returns
per-criterion PASS/WARN/FAIL plus ranked fixes. The rubrics encode the articles' evaluation
checklists, covering bias screening, quote fidelity, participant-breadth honesty, and evidence
proportionality.

Meta-evals in [`evals/`](evals/) prove the judge catches planted defects. Run
`bash evals/run-evals.sh`.

## Governance and guardrails

Everything lives in [`governance/`](governance/), enforced by `CLAUDE.md` and a `PreToolUse` hook
(`scripts/guardrail-check.sh`).

- **PII and participant data.** Deliverables use `P1..Pn`. Raw identities live only in gitignored
  `projects/`. ([pii-handling.md](governance/pii-handling.md))
- **Company approval gate.** Warn before ingesting external material. Scaffolded and *bypassable*
  via `GATE_MODE` until you populate the allowlist. ([policy.md](governance/policy.md))
- **Anti-fabrication.** No invented insights, no synthetic users as real data, no quote without a
  verbatim source, and thin themes labeled as hypotheses.
- **No external sending.** Nothing is emailed, uploaded, or posted without explicit confirmation.

## Repo layout

```
CLAUDE.md              # the config/preferences layer, router, and standing rules
.claude/
  agents/              # ux-research-judge, the LLM-as-judge subagent
  skills/              # /research orchestrator plus phase skills
  settings.json        # permissions and guardrail hook
templates/             # deliverable scaffolds
rubrics/               # the judge's scoring checklists
governance/            # PII, approval gate, approved-tools allowlist
evals/                 # fixtures and harness that meta-evaluate the judge
docs/                  # designed HTML for architecture and user journey
projects/              # real studies live here. GITIGNORED, never committed
scripts/               # guardrail-check.sh
```

## A note on scope

This is a **generic, shareable template**. It ships with no organization-specific data. Fill in
`governance/approved-tools.md` and `governance/policy.md` for your company before switching the
approval gate to `block`. Real study data never belongs in the template. It lives in `projects/`,
which git ignores.

## License

MIT. See [LICENSE](LICENSE).
