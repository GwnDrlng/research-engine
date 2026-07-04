---
name: ux-prototype
description: Prototyping with AI. Use to generate a clickable prototype for a flow, starting from the live product's design tokens rather than a blank canvas. Works in layers — scope the flow, load the design system, generate with assumptions surfaced, review for drift and fidelity — so the output is realistic research material, not accidental production code.
---

# ux-prototype — prototyping

AI prototype tools turn 3–5 days of manual work into 3–5 hours. The tradeoff: output **drifts from
the design system**, needs cleanup, and is **unsuitable for high-stakes domains** (fintech,
security, healthcare) without serious review. This skill front-loads constraints so the model makes
fewer "quiet decisions."

## Core principles
- **Start from the live product, not a blank canvas.** Paste real design tokens / components up front.
- A prototype's job is to be **realistic enough that people behave naturally** — it's throwaway
  research material, not production code, unless engineers explicitly adopt it.
- **Front-load constraints.** Anything you leave unspecified, the model will guess and present as
  output.

## Step 1 — Scope the flow
- Name the flow and the **primary task** the user is there to accomplish.
- List **screens in order**, and for each: what's on it and what the primary action does.
- Decide fidelity: which states must feel real (validation, error, empty, loading) for the research
  question to get a truthful answer.

## Step 2 — Load the design system
Gather and paste up front: design tokens (color, type scale, spacing, corner radius), the component
library or framework (e.g. Tailwind + shadcn/ui), and any real content samples. Drift is cheapest to
prevent here.

## Step 3 — Generate (the canonical prompt)
```
Build a clickable prototype for [flow name] in [product type]. Screens and behavior:
Screen 1: [what's on it; what the primary action does]. Screen 2: [...]. Use [framework and
styling, e.g., Tailwind + shadcn/ui]. Match this style: [paste design tokens or describe colors,
type scale, spacing, corner radius]. Use realistic placeholder content. When done, list every
assumption you made that I should verify.
```

## Step 4 — Review before anyone sees it
- Walk the **assumption list** first — that's where the model's quiet decisions surface.
- Check for **design-system drift** (off-token colors, wrong spacing, invented components).
- **High-stakes domains**: do a serious correctness/security review, or don't use the generated
  logic at all. Faked logic that *looks* real can mislead a test.
- Confirm it's realistic enough for natural behavior — not more, not less.

## Step 5 — Frame it as research material
Label it clearly as a throwaway prototype. It is **not** a handoff artifact and **not** production
code unless engineering explicitly adopts it. When testing with it, remember general LLMs can't
*use* a clickable prototype as a participant — real users do that.

## Guardrails
- Never present a prototype's faked logic as validated behavior.
- Synthetic/AI "users" do not test a prototype — see `research-interview` on real participants.
- Keep any real content/data used for realism de-identified and in `projects/`.
