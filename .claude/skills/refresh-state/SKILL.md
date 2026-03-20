---
name: refresh-state
description: Update durable memory files after meaningful progress.
disable-model-invocation: true
allowed-tools: Read, Write, Edit, Grep, Glob
---

Use this skill after a planning milestone, implementation slice, or verification pass.

Update only the files that need it:
- `STATE.md`
- `PHASE_HANDOFF.md`
- `docs/ops/phase-progress.md`
- `docs/decisions/decision-log.md`
- `docs/ops/known-issues.md`

Rules:
- summarize, do not dump logs
- keep updates short
- record next exact step
- record blockers and decisions only if they changed
