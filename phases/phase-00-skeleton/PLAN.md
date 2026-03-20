# Claude Code Phase Plan

## Objective
Create the repo operating system, technical skeleton, and Claude Code artifact pack required to execute Patch Ritual with low context waste.

## Scope
- root docs
- `.claude/` settings
- skills and subagents
- workspace/package skeleton
- verification and handoff structure
- root toolchain scaffolding

## Non-Goals
- actual feature implementation
- OAuth integration
- database schema completion
- ritual generation logic
- audience pages

## Inputs
- `PRD.md`
- `REQUIREMENTS.md`
- `ROADMAP.md`

## Deliverables
- root docs committed
- `.claude/settings.json`
- `.claude/settings.local.example.json`
- `.claude/agents/*`
- `.claude/skills/*`
- `apps/web` placeholder structure
- `packages/*` placeholder structure
- initial `docs/verification/` pattern
- root package and tsconfig scaffolding

## Dependencies
None

## Execution Waves
### Wave 1
- root docs
- memory files
- phase plans

### Wave 2
- `.claude/` settings, agents, skills
- root package/workspace files

### Wave 3
- app/package skeleton
- verification and handoff sanity check

## Acceptance Criteria
- repo has a compact root operating system
- repo has clear package boundaries
- repo has a usable phase plan structure
- repo has at least one planning, one implementation, one verification, and one state-refresh workflow
- no duplicate mega-docs exist
- Phase 1 can begin without re-explaining the product in chat

## Verification
- inspect root docs for non-overlap
- inspect `.claude/` artifacts for clear responsibilities
- inspect repo tree for discoverability
- confirm `STATE.md` and `PHASE_HANDOFF.md` are ready for session continuity
