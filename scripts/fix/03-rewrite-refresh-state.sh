#!/usr/bin/env bash
set -euo pipefail

cat > .claude/skills/refresh-state/SKILL.md <<'OUT'
---
name: refresh-state
description: Update durable memory files after meaningful progress.
disable-model-invocation: true
allowed-tools: Read, Write, Edit, Grep, Glob
---

Use this skill after a planning milestone, implementation slice, or verification pass.

Default update targets:
- `STATE.md`
- `PHASE_HANDOFF.md`

Optional update targets only if changed:
- `docs/decisions/decision-log.md`
- `docs/ops/known-issues.md`

Rules:
- summarize, do not dump logs
- keep updates short
- `STATE.md` is the canonical live project status
- `PHASE_HANDOFF.md` is the exact next-session resume packet
- do not maintain duplicate current-status text in multiple files
- record decisions only when architecture changed
- record issues only when a durable constraint changed
OUT

echo "Rewrote .claude/skills/refresh-state/SKILL.md"
