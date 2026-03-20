# STATE.md

## Current Phase
Phase 1 — Auth, Repository Selection, Release Import

## Current Status
Phase 0 complete and verified. Ready to begin Phase 1 implementation.

## Last Completed
- Repo skeleton created and verified
- apps/web scaffolded as minimal Next.js 15 app
- All packages (db, domain, github, ritual-engine, ui, validation) have valid package.json + tsconfig + src/index.ts
- pnpm workspace valid; `pnpm -r typecheck` passes clean
- All Phase 0 acceptance criteria met

## Next High-Leverage Actions
1. Begin Phase 1: GitHub OAuth sign-in
2. Repository selection flow
3. Release list and import
4. Draft release object persisted in storage

## Open Decisions
- ORM choice inside `packages/db`
- auth provider implementation details for GitHub OAuth
- storage provider for cover media
- completion metric definition for analytics

## Blockers
- no runtime code scaffold yet
- infra provider decisions not yet locked

## Risks
- overbuilding beyond fixed ritual format
- adding background workers too early
- mixing planning detail into root files

## Update Rule
Refresh this file after any meaningful planning milestone, phase completion, or architecture decision.
