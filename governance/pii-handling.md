# PII & participant-data handling

Research generates some of the most sensitive data an organization holds: real people's voices,
faces, opinions, and identities. These rules are non-negotiable in this repo.

## Golden rules

1. **Deliverables use pseudonyms only.** Refer to participants as `P1`, `P2`, … `Pn`. Never put a
   real name, email, phone number, employer, or face into a synthesis, insight report, or any
   shipped artifact.
2. **Raw data stays in `projects/`.** The `projects/` directory is gitignored. Real transcripts,
   recordings, screener responses, and contact details live there and **are never committed**.
3. **De-identify on intake.** When a transcript or brief arrives with real identities, the first
   step is to map identities to `Pn` in a **local, gitignored** key (`projects/<study>/_participant-key.md`)
   and strip identifiers from the working copy.
4. **Minimize.** Only ingest the data a question actually requires. Don't paste a whole CRM export
   to answer one question.
5. **No external send without confirmation.** See `policy.md`.

## What counts as PII here

Names, emails, phone numbers, national IDs (SSN etc.), physical/IP addresses, employer + role in
combination, faces/voices in recordings, and any free-text detail that could re-identify someone
(rare job titles, specific locations, health/financial specifics).

## Participant key format (`projects/<study>/_participant-key.md`, gitignored)

```
| Code | Real name  | Segment            | Recruited via |
|------|------------|--------------------|---------------|
| P1   | (real)     | Power user, 3+ yrs | Dovetail      |
| P2   | (real)     | New user, <30 days | Cold outreach |
```

The assistant should **never echo this key** into a shipped deliverable, a commit, or an external
message.

## The guardrail hook

`scripts/guardrail-check.sh` sniffs for emails, phone numbers, and national-ID patterns in content
being written or sent and warns. It is a backstop, **not** a substitute for the rules above.
