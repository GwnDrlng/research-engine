---
name: ux-writing
description: UX writing and microcopy. Use to draft interface text tied to a specific UI element, user moment, and emotional state. Works in layers — establish voice/tone, draft per element with labeled variants, then judge — so copy is right for the moment, not just polished.
---

# ux-writing — UX writing & microcopy

Over three-quarters of practitioners already use AI for interface text. The failure mode isn't bad
grammar — it's **polished copy that's subtly wrong for the user's emotional moment**. This skill
keeps the emotional context in front of you at every step.

## Core principle — one job per string
Every interface text does exactly one job: **inform**, **influence**, or **support** interaction.
Name the job before writing. A string that tries to do two (an error that also upsells) does
neither well.

## Step 1 — Establish voice & tone (once per product)
If not already on file, capture in `projects/<study-or-product>/voice-tone.md`:
- Brand voice in 3–5 adjectives, with "we sound like / we never sound like" pairs.
- Tone shifts by moment: how the voice flexes for success vs. error vs. destructive-action moments.
- Reading level, person (you/we), and locale/inclusive-language rules.
This is the standing context every draft reacts to — the "material" element of the prompt.

## Step 2 — Map the moment (per string)
For the specific element, pin down:
- **Element & surface** (e.g. inline validation on the payment field).
- **What just happened** and **what the user likely feels** right now.
- **The one job** (inform / influence / support) and **the next action** the text must make obvious.
- **Constraints**: character/line limit, voice/tone, and accessibility (no color-only or
  direction-only instructions; screen-reader-sensible).

## Step 3 — Draft variants (the canonical prompt)
```
Write microcopy for [specific UI element] in [product]. Context: the user just [what happened],
and is likely feeling [emotional state]. The text's primary job is to [inform / influence /
support]. Constraints: [character limit], [voice and tone], and it must tell the user exactly what
to do next. Give me four variants ranging from most concise to most reassuring, and label the
tradeoff each one makes.
```
Produce **four labeled variants** (most concise → most reassuring) with the tradeoff each makes.

## Step 4 — Read it back through the moment
Out loud, in the user's shoes, in the actual emotional state. Cut anything cheerful that lands on a
failure, anything clever that obscures the next step, anything that reads as manipulation. **You own
whether it belongs there.**

## Step 5 — Judge it
Invoke the **`ux-research-judge`** subagent with rubric `microcopy` (job clarity, emotional fit,
next-action clarity, constraint compliance, no dark patterns). Revise and re-judge until accepted.

## Guardrails
- **No dark patterns** — no false urgency, confirm-shaming, or buried opt-outs. Ever.
- Accessibility is a constraint, not a nicety: text must make sense without color or spatial cues.
- Real user data pasted for context stays de-identified and in `projects/` (see
  `governance/pii-handling.md`).
