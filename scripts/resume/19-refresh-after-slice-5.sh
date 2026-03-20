#!/usr/bin/env bash
set -euo pipefail

cat > STATE.md <<'OUT'
# STATE.md

## Current Phase
Phase 1 — Auth, Repository Selection, Release Import

## Current Status
Phase 1 in progress — Slice 5 (repository selection and release list UI) complete.

## Last Completed
- Phase 0: repo skeleton, typecheck clean
- Phase 1 Slice 1: `packages/domain/src/index.ts` exports Creator, Project, Release, SourceItem — workspace typecheck passes
- Phase 1 Slice 2: next-auth@beta installed, GitHub OAuth configured, route handler and middleware created, typecheck and build clean
- Phase 1 Slice 3: GitHub access token threaded through Auth.js callbacks; authenticated GitHub adapter added in `packages/github`
- Phase 1 Slice 4: `packages/db` now provides SQLite-backed draft persistence via Drizzle with a `drafts` table and typed `insertDraft(...)` helper
- Phase 1 Slice 5: `/dashboard` now shows repository selection and release listing via authenticated API routes and workspace UI; workspace typecheck passes

## Next High-Leverage Actions
1. Slice 6: normalize selected GitHub release and persist draft via `insertDraft(...)`
2. Slice 7: complete empty/error states and manual verification for Phase 1

## Open Decisions
- storage provider for cover media
- completion metric definition for analytics

## Blockers
- selected release is not yet normalized into a persisted draft
- Phase 1 acceptance criterion for draft creation is not yet complete

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
Phase 1 Slice 5 complete. The signed-in creator can now load repositories and releases in `/dashboard` through authenticated API routes backed by the existing GitHub adapter. Workspace typechecks pass.

## What Was Done
- `packages/github/src/index.ts`
  - existing adapter used for `listRepos(...)` and `listReleases(...)`
- `apps/web/auth.ts`
  - session and JWT callbacks expose `accessToken`
- Added API routes:
  - `GET /api/github/repos`
  - `GET /api/github/releases?repo=owner/repo`
- Added `/dashboard`
  - server-side auth gate
  - client workspace component
  - repo fetch on mount
  - release fetch on repo selection
  - empty/error states
- Fixed `apps/web/tsconfig.json`
  - explicit path mappings added for workspace package imports

## Resume From
Phase 1 Slice 6 — normalize selected release and persist draft

## Exact Next Step
When the creator selects a release, normalize the GitHub release data into the minimum draft shape required for Phase 1 and persist it using `insertDraft(...)` from `packages/db`.

## Watchouts
- Keep normalization minimal and Phase 1-scoped
- Persist only what the current draft boundary supports
- Do not add ritual generation, publishing, analytics, or background jobs
- Do not bypass `insertDraft(...)`
- Keep GitHub OAuth as the only auth provider in MVP

## Files To Read First
1. `CLAUDE.md`
2. `STATE.md`
3. `phases/phase-01-auth-release-import/PLAN.md`
4. `packages/github/src/index.ts`
5. `packages/db/src/index.ts`
6. `/dashboard` implementation files
OUT

cat > docs/verification/phase-01-auth-release-import.md <<'OUT'
# Verification: Phase 1 — Auth, Repository Selection, Release Import

## Status: in progress

## Acceptance Criteria

| # | Criterion | Status |
|---|-----------|--------|
| 1 | Creator can sign in with GitHub | wired — pending manual smoke test |
| 2 | Creator can select one repository | complete at UI level |
| 3 | Available releases shown with core metadata | complete at UI level |
| 4 | Selecting a release creates a draft | not started |
| 5 | Partial source data does not block draft creation | persistence boundary in place; import path not wired |

## Slice Verification Log

### Slice 5 — Repository selection + release list UI (2026-03-20)
- Files:
  - `packages/github/src/index.ts`
  - `apps/web/auth.ts`
  - dashboard UI files
  - GitHub API route files
  - `apps/web/tsconfig.json`
- Added:
  - authenticated repo listing endpoint
  - authenticated release listing endpoint
  - dashboard workspace UI for repo and release selection
  - empty/error states
- Checks:
  - workspace typecheck — passed clean
- Notes:
  - creator can now browse repos and releases
  - selecting a release does not yet create a persisted draft

### Slice 4 — DB schema + draft persistence boundary (2026-03-20)
- Files: `packages/db/package.json`, `packages/db/src/schema.ts`, `packages/db/src/client.ts`, `packages/db/src/index.ts`, root `package.json`
- Persistence:
  - Drizzle ORM
  - SQLite via `better-sqlite3`
  - one `drafts` table
  - typed `insertDraft(...)` helper
- Checks:
  - `pnpm -r typecheck` — passed clean
- Notes:
  - persistence boundary is ready

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

### Slice 2 — GitHub auth wiring (2026-03-20)
- Files: `apps/web/auth.ts`, `apps/web/src/app/api/auth/[...nextauth]/route.ts`, `apps/web/middleware.ts`
- Packages: `next-auth@5.0.0-beta.30` (Auth.js v5)
- Config: GitHub OAuth provider only; JWT session strategy; `/dashboard/*` protected
- Env: `.env.example` at repo root
- Check: `pnpm typecheck` — passed clean; `pnpm --filter @patch-ritual/web build` — passed clean

### Slice 1 — Domain types (2026-03-20)
- File: `packages/domain/src/index.ts`
- Exports: Creator, Project, Release, SourceItem
- Check: `pnpm -r typecheck` — passed clean

## Remaining Slices
6. Release import: normalize → persist draft
7. Empty/error states + manual verification
OUT

echo "Updated STATE.md, PHASE_HANDOFF.md, and docs/verification/phase-01-auth-release-import.md"
