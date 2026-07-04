#!/usr/bin/env bash
# Research Engine guardrail hook (PreToolUse).
#
# Non-blocking by default (GATE_MODE=warn). It reminds the assistant and user about:
#   1. External-send actions (email / Drive / Slack / push / curl) — nothing leaves this
#      machine without explicit confirmation.
#   2. Possible PII (emails, phone numbers, national IDs) in content being written or sent.
#   3. The company approval gate for ingesting external material.
#
# It prints reminders to stderr and exits 0 (warn). To make it BLOCK instead, set
# GATE_MODE=block in the environment and it will exit 2 on an external-send tool.
#
# Reads the standard PreToolUse JSON payload on stdin: { "tool_name", "tool_input", ... }

set -euo pipefail

GATE_MODE="${RESEARCH_ENGINE_GATE:-warn}"

# No python3? Fail open — never block real work on a missing interpreter.
command -v python3 >/dev/null 2>&1 || exit 0

payload="$(cat)"

result="$(RE_PAYLOAD="$payload" python3 <<'PY'
import json, re, os

try:
    data = json.loads(os.environ.get("RE_PAYLOAD", ""))
except Exception:
    raise SystemExit(0)

tool = data.get("tool_name", "")
ti = data.get("tool_input", {})
blob = json.dumps(ti)

warnings = []
external = False

# 1. External-send surfaces.
send_tools = ("Gmail", "Google_Drive", "Slack", "mail", "drive")
if any(s.lower() in tool.lower() for s in send_tools):
    external = True
    warnings.append(f"EXTERNAL-SEND: '{tool}' can transmit data off this machine. "
                    "Confirm with the user before sending; nothing leaves without an explicit OK.")
if tool == "Bash":
    cmd = str(ti.get("command", ""))
    if re.search(r"\b(git\s+push|curl|scp|rsync\s+.*::|wget)\b", cmd):
        external = True
        warnings.append("EXTERNAL-SEND: this shell command can transmit data off-machine. Confirm first.")

# 2. PII sniff on any content being written/edited/sent.
content = " ".join(str(v) for v in ti.values())
pii = []
if re.search(r"[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}", content):
    pii.append("email address")
if re.search(r"(?<!\d)(\+?\d[\d\-\.\s()]{8,}\d)(?!\d)", content):
    pii.append("phone number")
if re.search(r"\b\d{3}-\d{2}-\d{4}\b", content):
    pii.append("national ID / SSN")
if pii:
    warnings.append("POSSIBLE PII detected (" + ", ".join(sorted(set(pii))) + "). "
                    "Deliverables must use P1..Pn, not real identities. Keep raw PII in projects/ only.")

if warnings:
    print("EXTERNAL" if external else "WARN")
    for w in warnings:
        print("  ⚠ " + w)
PY
)"

[ -z "$result" ] && exit 0

status_line="$(printf '%s' "$result" | head -1)"
body="$(printf '%s' "$result" | tail -n +2)"

echo "── Research Engine guardrail ──" >&2
printf '%s\n' "$body" >&2
echo "Approval gate: GATE_MODE=$GATE_MODE. See governance/policy.md." >&2

if [ "$GATE_MODE" = "block" ] && [ "$status_line" = "EXTERNAL" ]; then
  echo "Blocked by GATE_MODE=block. Set RESEARCH_ENGINE_GATE=warn to allow with confirmation." >&2
  exit 2
fi

exit 0
