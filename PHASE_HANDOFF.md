# PHASE_HANDOFF.md

## Session Summary
Phase 1 Slice 3 complete. Auth.js session now exposes the GitHub access token, and `packages/github` contains the authenticated GitHub adapter for repository and release listing. Workspace typecheck and web build both pass clean.

## What Was Done
- Updated `apps/web/auth.ts`
  - added JWT callback
  - persisted `account.access_token` into `token.accessToken`
  - exposed access token via session callback as `session.accessToken`
  - augmented `next-auth` Session type for this access token
- Implemented `packages/github/src/index.ts`
  - added `GitHubRepo` and `GitHubRelease` types
  - added private `ghFetch<T>` helper
  - added `listRepos(accessToken)`
  - added `listReleases(accessToken, repoFullName)`
- Verified:
  - `pnpm typecheck`
  - `pnpm --filter @patch-ritual/web build`

## Resume From
Phase 1 Slice 4 — DB schema and draft persistence boundary in `packages/db`

## Exact Next Step
Choose the ORM for `packages/db`, define the minimum draft persistence shape for imported releases, and implement the smallest persistence boundary needed for Phase 1.

## Watchouts
- Keep persistence minimal: only what Phase 1 needs for imported release draft storage
- Do not start repository selection UI until the persistence shape is clear
- Do not introduce a worker or queue before Phase 4
- Keep GitHub OAuth as the only auth provider in MVP
- Avoid letting ORM setup become an architecture tax

## Files To Read First
1. `CLAUDE.md`
2. `STATE.md`
3. `phases/phase-01-auth-release-import/PLAN.md`
4. `packages/db/package.json`
5. `packages/db/src/index.ts`
6. `packages/domain/src/index.ts`
