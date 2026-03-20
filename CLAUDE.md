# CLAUDE.md

## Project Purpose
Build Patch Ritual as a GitHub-connected release publishing tool for solo indie creators. MVP transforms one shipped release into one short branded ritual page that fans can explore and react to.

## Working Rules
- Stay inside the MVP defined in `PRD.md` and `REQUIREMENTS.md`.
- Optimize for the shortest path to the core loop:
  sign in -> select repo -> import release -> shape ritual -> publish -> react -> review analytics
- Prefer TypeScript-first implementation.
- Prefer editing existing files over creating new files.
- Keep ceremony low. Do not introduce team-scale process for solo-builder work.
- Do not add extra integrations, live launch rooms, or marketplace features in MVP phases.

## Repo Priorities
1. Working creator-to-audience MVP loop
2. Fast publish workflow under 5 minutes
3. Clear file boundaries and resumable phase execution
4. Strong verification before moving phases
5. Minimal context load and minimal duplicate instructions

## File Boundaries
- `PRD.md` = product truth
- `REQUIREMENTS.md` = scope, acceptance mapping, non-goals
- `ROADMAP.md` = phase order and outcomes
- `STATE.md` = current position, blockers, next steps
- `PHASE_HANDOFF.md` = resume notes after each meaningful session
- `phases/*/PLAN.md` = execution plan for one phase
- `docs/verification/*` = proof that a phase actually works
- `docs/decisions/decision-log.md` = architectural decisions
- `.claude/agents/*` = specialist subagents
- `.claude/skills/*` = repeatable Claude Code workflows

## Implementation Rules
- Work one phase at a time unless the active phase explicitly allows safe parallel waves.
- Keep the ritual format constrained in MVP:
  - opening hook
  - key changes
  - closing prompt
- Keep the audience experience short: 60 to 120 seconds.
- Keep creator review mandatory before publish.
- Add packages only when they pay for themselves within the active phase.
- Default to server-side simplicity before introducing workers or queues.
- Do not introduce MCP servers unless a concrete workflow requires one.

## Verification Rules
- Define acceptance criteria before implementation.
- Treat "implemented" and "verified" as different states.
- Run the narrowest useful checks first.
- Record verification outcomes in `docs/verification/`.
- Update `STATE.md` and `PHASE_HANDOFF.md` after meaningful progress.

## Documentation Rules
- Keep root docs compact.
- Push volatile detail into phase files.
- Prune stale plans, dead commands, and duplicate notes.
- Summarize decisions; do not preserve long chat transcripts in repo files.
