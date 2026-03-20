# Claude Code Build Pack

## Objective
Turn Patch Ritual into a Claude Code-native repo that is easy to build, resume, and verify.

## Mode
Build

## Recommended Design
Use a TypeScript-first monorepo with one real app at the center:

```text
patch-ritual/
├─ CLAUDE.md
├─ PROJECT.md
├─ PRD.md
├─ REQUIREMENTS.md
├─ ROADMAP.md
├─ STATE.md
├─ COMPACT_CONTEXT.md
├─ PHASE_HANDOFF.md
├─ package.json
├─ pnpm-workspace.yaml
├─ tsconfig.base.json
├─ apps/
│  └─ web/
├─ packages/
│  ├─ db/
│  ├─ domain/
│  ├─ github/
│  ├─ ritual-engine/
│  ├─ ui/
│  └─ validation/
├─ infra/
│  ├─ db/
│  └─ storage/
├─ docs/
│  ├─ decisions/
│  ├─ ops/
│  └─ verification/
├─ phases/
│  ├─ phase-00-skeleton/
│  ├─ phase-01-auth-release-import/
│  ├─ phase-02-creator-draft-and-ritual-generation/
│  ├─ phase-03-public-publishing-loop/
│  ├─ phase-04-engagement-analytics-hardening/
│  └─ phase-05-post-mvp-differentiation/
└─ .claude/
   ├─ settings.json
   ├─ settings.local.example.json
   ├─ agents/
   └─ skills/
```

## Why This Fits Claude Code
- compact root instructions
- file-based state
- fresh-context phase execution
- minimal but useful specialist agents
- no MCP dependency in Phase 0
- no hook noise by default
- monorepo only where it creates clear boundaries

## Artifact Pack
- product: `PROJECT.md`, `PRD.md`, `REQUIREMENTS.md`
- execution: `ROADMAP.md`, `phases/*/PLAN.md`
- memory: `STATE.md`, `COMPACT_CONTEXT.md`, `PHASE_HANDOFF.md`
- decisions/ops: `docs/decisions/decision-log.md`, `docs/ops/*`
- Claude Code: `.claude/settings.json`, `.claude/agents/*`, `.claude/skills/*`

## Token-Efficiency Notes
- keep `CLAUDE.md` compact and durable
- do not repeat product rationale in every phase file
- use `refresh-state` instead of long chat summaries
- prune stale plans with `prune-context`
- keep the subagent set small

## Risks
- adding a worker too early
- turning packages into an architecture tax
- letting post-MVP ideas leak into MVP phases
- duplicating rules across docs and skills

## Simplest Acceptable Version
If you want the absolute smallest version:
- keep only `apps/web`
- keep docs and `.claude/` system exactly as-is
- postpone `packages/ui` and `packages/validation` until Phase 2
- postpone `packages/ritual-engine` extraction until generation logic becomes non-trivial
