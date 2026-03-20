#!/usr/bin/env bash
set -euo pipefail

cat > CLAUDE.md <<'OUT'
# CLAUDE.md

## Scope
Stay inside the MVP defined in `REQUIREMENTS.md` and `ROADMAP.md`.

## Read Order
Read these first unless the task is extremely local:
1. `STATE.md`
2. active `phases/*/PLAN.md`
3. `PHASE_HANDOFF.md` when resuming an in-flight slice
4. affected app/package docs

## File Contracts
- `REQUIREMENTS.md` = canonical product and scope truth
- `ROADMAP.md` = phase order and intended outcomes
- `STATE.md` = canonical live project status
- `PHASE_HANDOFF.md` = exact next-session resume packet
- `phases/*/PLAN.md` = execution plan for one phase
- `docs/verification/*` = acceptance evidence only
- `docs/decisions/decision-log.md` = durable architecture decisions
- `docs/ops/known-issues.md` = durable technical constraints
- `.claude/agents/*` = specialist subagents
- `.claude/skills/*` = repeatable Claude Code workflows

## Execution Rules
- Work one phase at a time unless the active phase explicitly allows safe parallel waves.
- Build the smallest slice that creates meaningful end-to-end progress.
- Prefer editing existing files over creating new ones.
- Keep the ritual format fixed in MVP:
  - opening hook
  - key changes
  - closing prompt
- Keep creator review mandatory before publish.
- Prefer simple server-side implementations before adding async systems.
- Do not add extra integrations, workers, queues, or MCP servers unless the active phase requires them.

## Verification Rules
- Define acceptance criteria before implementation.
- Treat implemented and verified as different states.
- Run the narrowest useful checks first.
- Record proof in `docs/verification/`.
- Refresh `STATE.md` and `PHASE_HANDOFF.md` after meaningful progress.

## Documentation Rules
- Keep root docs compact.
- Push volatile detail into phase files.
- Summarize decisions; do not preserve long transcripts.
- Prune stale plans, dead workflow artifacts, and duplicate guidance.
OUT

echo "Rewrote CLAUDE.md"
