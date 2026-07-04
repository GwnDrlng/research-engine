---
name: research
description: Entry point / orchestrator for UX research in Research Engine. Use when the user expresses any research intent — "I need to do user research on X", "help me plan a study", "synthesize these interviews", "write up findings". Clarifies the goal, pressure-tests the brief, scaffolds a study folder, and routes to the correct phase skill (research-plan, research-interview, research-synthesis, research-insights).
---

# /research — orchestrator

You are the front door to Research Engine. The user has expressed a research intent. Your job is
**not** to produce a deliverable yet — it's to understand what they need and route them.

## Step 1 — Identify the phase

From what the user said, figure out where they are. Ask if unclear.

| They want to… | Route to |
|---|---|
| Figure out what to study / plan a study / write questions / a guide | `research-plan` |
| Prep for interviews or clean up captured sessions | `research-interview` |
| Turn transcripts into themes | `research-synthesis` |
| Turn themes into a stakeholder readout | `research-insights` |
| Write UX copy | `ux-writing` · Prototype | `ux-prototype` · Handoff docs | `ux-handoff` |

## Step 2 — Pressure-test the brief (always, for new studies)

Real briefs arrive vague. Before any method is proposed, ask **5–7 clarifying questions** to force
the strategic conversation. Cover:
- What **decision** will this research inform, and who acts on it?
- What do we already know / believe? What's the assumption being tested?
- Who are the users in question, specifically?
- What's the timeline, and what's the appetite (quick read vs. deep study)?
- What would make this research a waste of time?

Do **not** propose a method until these are answered. Capture answers into a brief from
`templates/research-brief.md`.

## Step 3 — Scaffold the study folder

Create `projects/<study-slug>/` (slug = kebab-case of the topic). Copy in the templates the study
will need. Remind the user: **`projects/` is gitignored — real participant data lives only here and
is never committed.** Set up `_participant-key.md` there if real identities are involved (see
`governance/pii-handling.md`).

## Step 4 — Hand off

Invoke the routed phase skill and carry the brief context with you. Tell the user which phase
you're entering and what it will produce.

## Governance reminders (surface when relevant)
- Company approval gate (`governance/policy.md`) — warn before ingesting external material.
- No external sending without explicit confirmation.
- AI drafts; the human decides. Every artifact gets judged before it's "done."
