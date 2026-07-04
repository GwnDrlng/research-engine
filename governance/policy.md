# Governance policy — approval gate

This file defines the **company approval gate**: the rule that you must know what your organization
has explicitly approved before putting work material into an AI tool. Adapt the placeholders below
to your organization before relying on this in production.

## Gate mode

```
GATE_MODE: warn
```

- `warn` (default, shipped): the guardrail hook and the assistant **warn** but do not block when
  external material is ingested or an external-send action is attempted. Nothing is transmitted
  without explicit user confirmation regardless.
- `block`: the guardrail hook **blocks** external-send actions (exit 2). Set
  `RESEARCH_ENGINE_GATE=block` in the environment to activate.

> Shipped in `warn` for now, per project decision — the gate is scaffolded and bypassable while the
> approved-tools list is being populated. Flip to `block` once `approved-tools.md` is filled in.

## What the gate covers

Before **ingesting external work material** (a brief, transcript, recording, competitor data, or
customer data) into this system, confirm:

1. The **source tool** is on the allowlist in [`approved-tools.md`](./approved-tools.md).
2. The material's **data classification** is permitted for AI processing under company policy.
3. Any **PII** is handled per [`pii-handling.md`](./pii-handling.md).

If any of these is unknown, the assistant should **pause and ask** rather than proceed.

## What is never allowed

- Sending content to an external service (email, upload, chat) without explicit user confirmation.
- Committing real study data (participant PII, transcripts, recordings) to git — see `.gitignore`.
- Presenting AI-generated or synthetic-user content as real research findings.

## Placeholders to fill in per organization

- `[COMPANY]` approved-data-classification matrix: _link here_
- Data Protection / privacy contact: _name / channel here_
- Legal review threshold for external research: _describe here_
