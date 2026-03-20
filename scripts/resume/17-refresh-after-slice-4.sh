#!/usr/bin/env bash
set -euo pipefail

cat > STATE.md <<'OUT'
# STATE.md

## Current Phase
Phase 1 — Auth, Repository Selection, Release Import

## Current Status
Phase 1 in progress — Slice 4 (DB schema and draft persistence boundary) complete.

## Last Completed
- Phase 0: repo skeleton, typecheck clean
- Phase 1 Slice 1: `packages/domain/src/index.ts` exports Creator, Project, Release, SourceItem — workspace typecheck passes
- Phase 1 Slice 2: next-auth@beta installed, GitHub OAuth configured, route handler and middleware created, typecheck and build clean
- Phase 1 Slice 3: GitHub access token threaded through Auth.js callbacks; authenticated GitHub adapter added in `packages/github` with repo and release listing — typecheck and web build clean
- Phase 1 Slice 4: `packages/db` now provides SQLite-backed draft persistence via Drizzle with a `drafts` table and typed `insertDraft(...)` helper — workspace typecheck clean

## Next High-Leverage Actions
1. Slice 5: wire repository selection and release list into creator workspace UI
2. Slice 6: normalize selected GitHub release and persist draft via `insertDraft(...)`

## Open Decisions
- storage provider for cover media
- completion metric definition for analytics

## Blockers
- repository selection UI not yet wired
- release import flow not yet connected to persistence

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
Phase 1 Slice 4 complete. `packages/db` now contains the minimum draft persistence boundary: Drizzle + SQLite, one `drafts` table, and typed `insertDraft(...)`. Workspace typecheck passes.

## What Was Done
- Updated root `package.json`
  - pinned exact `packageManager`
  - allowed `better-sqlite3` native build via `pnpm.onlyBuiltDependencies`
- Updated `packages/db/package.json`
  - added `drizzle-orm`
  - added `better-sqlite3`
  - added `drizzle-kit`
  - added `@types/better-sqlite3`
- Created `packages/db/src/schema.ts`
  - defines `drafts` table
- Created `packages/db/src/client.ts`
  - opens SQLite DB
  - ensures table exists
- Updated `packages/db/src/index.ts`
  - exports `db`
  - exports `drafts`
  - exports typed `insertDraft(...)`

## Resume From
Phase 1 Slice 5 — repository selection and release list UI wiring

## Exact Next Step
Use the authenticated GitHub adapter from `packages/github` to show the signed-in creator their repositories and releases in the workspace UI, without implementing full draft import yet.

## Watchouts
- Keep UI thin and Phase 1-scoped
- Do not add publishing, ritual generation, or analytics work
- Do not bypass `insertDraft(...)` when Slice 6 connects import to persistence
- Keep GitHub OAuth as the only auth provider in MVP

## Files To Read First
1. `CLAUDE.md`
2. `STATE.md`
3. `phases/phase-01-auth-release-import/PLAN.md`
4. `apps/web/auth.ts`
5. `packages/github/src/index.ts`
6. `packages/db/src/index.ts`
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
| 4 | Selecting a release creates a draft | persistence boundary complete — flow not wired |
| 5 | Partial source data does not block draft creation | type-level and persistence boundary in place |

## Slice Verification Log

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
  - UI wiring and release import flow are still pending

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
  - persistence boundary is complete after Slice 4

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
- Notes: SourceItem.title and .body are nullable, satisfying criterion 5 at the type level.

## Remaining Slices
5. Repository selection + release list UI
6. Release import: normalize → persist draft
7. Empty/error states + manual verification
OUT

echo "Updated STATE.md, PHASE_HANDOFF.md, and docs/verification/phase-01-auth-release-import.md"
