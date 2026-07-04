---
name: research-insights
description: Phase 4 of UX research — communicate insights. Use to turn synthesized themes into stakeholder-ready insights with a consistent 6-part structure, format-shift them for different audiences (Slack, repo, leadership), and run a mandatory skeptical pass so claims never outrun the evidence.
---

# research-insights — Phase 4: communicate insights

Themes aren't insights until they're framed for a decision. Each insight follows the same shape so
claim strength always stays tied to evidence strength.

## Step 1 — Draft each insight (6-part structure)
Using `templates/insight-report.md`, for every insight write:
1. **Headline** — one sentence, plain language, an **observation not an opinion**.
2. **What we observed** — with participant counts.
3. **Why it matters** — tie to a research question **and** a business decision.
4. **Two verbatim supporting quotes**, attributed.
5. **What we're still uncertain about** — real gaps, not boilerplate.
6. **Two next steps** — one tactical/shippable, one strategic/alignment-requiring.

## Step 2 — Format-shift (same evidence, adjusted depth)
Generate parallel versions from the identical evidence:
- **Slack summary** — 3 sentences.
- **Repository TL;DR** — one line.
- **Leadership** — 5-slide outline.
Depth changes; the underlying evidence does not.

## Step 3 — Skeptic's pass (required)
Have yourself argue **against** each insight: which findings are overclaimed, which expensive
recommendations rest on thin support, where certainty is overstated. Fold the honest ones back in.

## Step 4 — Judge it
Invoke **`ux-research-judge`** with rubric `insights`: headline honesty, evidence proportionality,
uncertainty visibility, next-step actionability, quote representativeness. Revise and re-judge.

## Guardrails
- Every recommendation must trace to a finding in the synthesis.
- Every quote is verbatim and attributed (`P#`). No source, no quote.
- A PM should be able to act on a next step Monday morning without being misled.
