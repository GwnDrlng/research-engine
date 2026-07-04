---
name: ux-handoff
description: Engineering handoff documentation. Use to generate developer-facing notes covering states, conditional logic, validation, and accessibility — the things Figma Dev Mode doesn't capture. Works in layers — inventory interactive elements, document every state and rule, then run a completeness judge pass — so developers don't guess.
---

# ux-handoff — engineering handoff

Design quality leaks at handoff: designers rush documentation, so states, edge cases, and
conditional logic go undocumented and **developers guess**. Figma Dev Mode already covers spacing,
type, color, tokens, and code snippets via Code Connect. This skill documents what it can't.

## What you must write (Figma won't)
Interaction behavior · conditional logic · animation intent · content rules · and especially
**state documentation**: loading, error, empty, disabled, focus, success.

## Step 1 — Inventory the interactive elements
For the component or flow, list every interactive element (buttons, fields, toggles, menus, links).
Start from `templates/handoff-checklist.md`. Describe the **happy path** first — the main
interaction, plainly.

## Step 2 — Document each element (the canonical prompt)
```
I'm handing off [component or flow] to engineering. Here's what it does: [describe happy path and
main interaction]. Generate developer-facing handoff notes covering: every state each interactive
element needs (loading, error, empty, disabled, focus, success); conditional logic (when does each
element show versus hide); validation rules and error messages; and accessibility requirements
(focus order, labels, announcements). Format as a checklist. Mark anything you're inferring rather
than certain about.
```
Fill the states table and the logic/validation/accessibility sections. **Mark every inferred item**
distinctly from confirmed ones.

## Step 3 — Read it as the developer will
Walk it as an engineer with no context. Delete what's wrong, resolve every inferred item with the
designer, and confirm each state actually has documented behavior. **Goal is completeness, not
length.**

## Step 4 — Judge / completeness pass
Run a completeness review against the checklist: is any interactive element missing a state? any
conditional without its trigger? any error without a message? any element without focus/label/
announcement notes? Resolve gaps before marking **Ready for dev**.

## Guardrails
- Design-to-code output (Locofy et al.) is a **starting point, not a finished deliverable**.
- Never mark "Ready for dev" while inferred items remain unconfirmed by design.
- Accessibility (focus order, labels, live-region announcements) is required content, not optional.
