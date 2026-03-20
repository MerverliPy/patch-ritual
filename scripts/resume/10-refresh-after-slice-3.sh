#!/usr/bin/env bash
set -euo pipefail

cat > STATE.md <<'OUT'
# STATE.md

## Current Phase
Phase 1 — Auth, Repository Selection, Release Import

## Current Status
Phase 1 in progress — Slice 3 (GitHub integration adapter) complete.

## Last Completed
- Phase 0: repo skeleton, typecheck clean
- Phase 1 Slice 1: `packages/domain/src/index.ts` exports Creator, Project, Release, SourceItem — workspace typecheck passes
- Phase 1 Slice 2: next-auth@beta installed, GitHub OAuth configured, route handler and middleware created, typecheck and build clean
- Phase 1 Slice 3: GitHub access token threaded through Auth.js callbacks; authenticated GitHub adapter added in `packages/github` with repo and release listing — typecheck and web build clean

## Next High-Leverage Actions
1. Slice 4: lock ORM choice for `packages/db` and add draft persistence boundary
2. Slice 5: wire repository selection and release list into creator workspace UI

## Open Decisions
- ORM choice inside `packages/db`
- storage provider for cover media
- completion metric definition for analytics

## Blockers
- ORM choice for `packages/db` not yet locked
- infra provider decisions not yet locked

## Risks
- overbuilding beyond fixed ritual format
- adding background workers too early
- mixing planning detail into root files

## Update Rule
Refresh this file after any meaningful planning milestone, phase completion, or architecture decision.
OUT

cat > PHASE_HANDOFF.md <<'OUT'
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
OUT

cat > docs/verification/phase-01-auth-release-import.md <<'OUT'
# Verification: Phase 1 — Auth, Repository Selection, Release Import

## Status: in progress

## Acceptance Criteria

| # | Criterion | Status |
|---|-----------|--------|
| 1 | Creator can sign in with GitHub | wired — pending manual smoke test |
| 2 | Creator can select one repository | not started |
| 3 | Available releases shown with core metadata | adapter layer complete — UI not started |
| 4 | Selecting a release creates a draft | not started |
| 5 | Partial source data does not block draft creation | type-level only |

## Slice Verification Log

### Slice 3 — GitHub integration adapter (2026-03-20)
- Files: `apps/web/auth.ts`, `packages/github/src/index.ts`
- Auth.js:
  - JWT callback persists `account.access_token` into `token.accessToken`
  - session callback exposes `session.accessToken`
- GitHub adapter:
  - `listRepos(accessToken)`
  - `listReleases(accessToken, repoFullName)`
- Checks:
  - `pnpm typecheck` — passed clean
  - `pnpm --filter @patch-ritual/web build` — passed clean
- Notes:
  - adapter layer is complete
  - repository selection UI and release list UI are still pending
  - persistence boundary is the next blocker before draft creation

### Slice 2 — GitHub auth wiring (2026-03-20)
- Files: `apps/web/auth.ts`, `apps/web/src/app/api/auth/[...nextauth]/route.ts`, `apps/web/middleware.ts`
- Packages: `next-auth@5.0.0-beta.30` (Auth.js v5)
- Config: GitHub OAuth provider only; JWT session strategy; `/dashboard/*` protected
- Env: `.env.example` at repo root (AUTH_SECRET, GITHUB_CLIENT_ID, GITHUB_CLIENT_SECRET)
- Check: `pnpm typecheck` — passed clean; `pnpm --filter @patch-ritual/web build` — passed clean
- Notes: access token threading was completed in Slice 3.

### Slice 1 — Domain types (2026-03-20)
- File: `packages/domain/src/index.ts`
- Exports: Creator, Project, Release, SourceItem
- Check: `pnpm -r typecheck` — passed clean (7 packages)
- Notes: SourceItem.title and .body are nullable, satisfying criterion 5 at the type level. Runtime normalization pending later Phase 1 slices.

## Remaining Slices
4. DB schema + draft persistence
5. Repository selection + release list UI
6. Release import: normalize → persist draft
7. Empty/error states + manual verification
OUT

echo "Updated:"
echo "- STATE.md"
echo "- PHASE_HANDOFF.md"
echo "- docs/verification/phase-01-auth-release-import.md"
