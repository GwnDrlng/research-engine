---
name: research-interview
description: Phase 2 of UX research — interview preparation and capture. Use to audit a discussion guide before sessions, set up de-identified transcription capture, and prepare (never moderate) interviews. AI does prep and post-capture work; it does not conduct semi-structured interviews.
---

# research-interview — Phase 2: prepare & capture

**Boundary:** AI does **not** moderate. Semi-structured interviews need rapport, probing, and
in-the-moment judgment about which threads to follow — that's the human's job. AI's role here is
**preparation and capture**, not being in the room.

## Before the interview — audit the guide
Run a structured audit of the discussion guide, targeting:
- leading / priming language
- double-barreled questions
- assumption-loaded phrasing
- closed questions where open would yield richer data
- questions asking participants to predict future behavior

A good first-draft audit surfaces 2–3 real issues. When you revise, make sure the fix **eliminates**
the bias rather than rephrasing it. Offer a skeptical-researcher reframe of any weak question.

## During the interview — capture, don't summarize
- Capture **everything** via transcription. Modern tools run ~95–98% accurate.
- **Do not auto-summarize in real time.** Real-time summaries flatten nuance and bias the
  listening that follows. Keep the raw transcript.
- Note where the moderator should probe live; the human reads the room (pauses, contradictions,
  facial expressions, unstated workarounds) — you can't.

## After capture — de-identify
- Map real identities → `P1..Pn` in `projects/<study>/_participant-key.md` (gitignored).
- Produce a clean working transcript from `templates/transcript.md`: normalize `M`/`P` labels,
  remove filler, mark `[inaudible]` / `[unclear: guess]`. **Do not summarize or interpret — just
  clean.**
- Confirm no raw PII remains in the working copy before it leaves `projects/`.

## Hand off
When transcripts are clean and de-identified, route to `research-synthesis`.

## Guardrails
- Never present an AI role-play of a participant as real data.
- Raw recordings/identities stay in gitignored `projects/`. See `governance/pii-handling.md`.
