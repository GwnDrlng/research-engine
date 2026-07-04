# Approved tools & sources (allowlist)

The approval gate (`policy.md`) checks incoming material and outgoing actions against this list.
**It ships empty on purpose** — this is a public template. Populate it with your organization's
approved tools before switching `GATE_MODE` to `block`.

Format: one row per tool, with the highest data classification it may handle.

| Tool / source | Purpose | Max data classification | Approved? | Notes |
|---|---|---|---|---|
| _e.g. Dovetail_ | Research repository | Confidential | ☐ | fill in |
| _e.g. Otter.ai_ | Transcription | Internal | ☐ | fill in |
| _e.g. Maze_ | Usability testing | Internal | ☐ | fill in |
| _e.g. Figma_ | Design / prototyping | Internal | ☐ | fill in |

## Data classifications (example scale — replace with your own)

- **Public** — safe to share externally.
- **Internal** — employees only; no customer PII.
- **Confidential** — restricted; may include de-identified research data.
- **Restricted** — raw PII, recordings, health/financial data. Usually **not** permitted in AI tools.

Until this list is populated, treat every external tool as **unverified** and warn before use.
