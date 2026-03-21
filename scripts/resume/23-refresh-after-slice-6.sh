#!/usr/bin/env bash
set -euo pipefail

cat > STATE.md <<'OUT'
# STATE.md

## Current Phase
Phase 1 — Auth, Repository Selection, Release Import

## Current Status
Phase 1 in progress — Slice 6 (release import → normalize → persist draft) complete.

## Last Completed
- Phase 0: repo skeleton, typecheck clean
- Phase 1 Slice 1: `packages/domain/src/index.ts` exports Creator, Project, Release, SourceItem — workspace typecheck passes
- Phase 1 Slice 2: next-auth@beta installed, GitHub OAuth configured, route handler and middleware created, typecheck and build clean
- Phase 1 Slice 3: GitHub access token threaded through Auth.js callbacks; authenticated GitHub adapter added in `packages/github`
- Phase 1 Slice 4: `packages/db` now provides SQLite-backed draft persistence via Drizzle with a `drafts` table and typed `insertDraft(...)` helper
- Phase 1 Slice 5: `/dashboard` shows repository selection and release listing via authenticated API routes and workspace UI
- Phase 1 Slice 6: selected release can now be normalized and persisted as a draft through `/api/github/import-draft`

## Next High-Leverage Actions
1. Slice 7: run manual verification and edge-state checks for full Phase 1 closeout
2. Decide whether Phase 1 is complete and ready to hand off to Phase 2

## Open Decisions
- storage provider for cover media
- completion metric definition for analytics

## Blockers
- Phase 1 still needs manual verification and edge-state confirmation
- GitHub sign-in and draft creation flow should be smoke tested end-to-end

## Risks
- assuming Phase 1 is done without manual proof
- mixing Phase 2 work into Phase 1 verification
- overbuilding beyond fixed ritual format

## Update Rule
Refresh this file after any meaningful planning milestone, phase completion, or architecture decision.
OUT

cat > PHASE_HANDOFF.md <<'OUT'
# PHASE_HANDOFF.md

## Session Summary
Phase 1 Slice 6 complete. Selecting a release can now create a persisted draft through the authenticated import route. The Phase 1 core loop is functionally in place; the next step is manual verification and edge-state hardening.

## What Was Done
- Added `apps/web/src/app/api/github/import-draft/route.ts`
  - POST route
  - auth-gates on session access token and creator identity
  - validates `repoFullName`, `tagName`, and `title`
  - persists draft via `insertDraft(...)`
  - returns persisted draft JSON with `201`
- Updated dashboard workspace UI
  - added import state handling
  - added release import action
  - normalizes title as `release.name ?? release.tag_name`
  - shows import success with returned draft id
- Updated `apps/web/tsconfig.json`
  - added `@patch-ritual/db` path mappings
- Updated `apps/web/next.config.ts`
  - added `@patch-ritual/db` to `transpilePackages`

## Resume From
Phase 1 Slice 7 — manual verification and edge-state closeout

## Exact Next Step
Run the Phase 1 verification pass: GitHub auth smoke test, repo list check, release list check, draft import check, empty/error-state checks, and partial-data verification.

## Watchouts
- Do not start Phase 2 work until Phase 1 has real verification evidence
- Keep verification focused on current acceptance criteria
- Validate fallback behavior for incomplete release data
- Avoid adding new product scope during verification

## Files To Read First
1. `CLAUDE.md`
2. `STATE.md`
3. `phases/phase-01-auth-release-import/PLAN.md`
4. `docs/verification/phase-01-auth-release-import.md`
5. dashboard UI files
6. `apps/web/src/app/api/github/import-draft/route.ts`
OUT

cat > docs/verification/phase-01-auth-release-import.md <<'OUT'
# Verification: Phase 1 — Auth, Repository Selection, Release Import

## Status: in progress

## Acceptance Criteria

| # | Criterion | Status |
|---|-----------|--------|
| 1 | Creator can sign in with GitHub | wired — pending manual smoke test |
| 2 | Creator can select one repository | complete |
| 3 | Available releases shown with core metadata | complete |
| 4 | Selecting a release creates a draft | complete |
| 5 | Partial source data does not block draft creation | pending manual edge verification |

## Slice Verification Log

### Slice 6 — Release import: normalize → persist draft (2026-03-20)
- Files:
  - `apps/web/src/app/api/github/import-draft/route.ts`
  - `apps/web/src/app/dashboard/workspace.tsx`
  - `apps/web/tsconfig.json`
  - `apps/web/next.config.ts`
- Added:
  - authenticated draft import route
  - minimal normalization using `release.name ?? release.tag_name`
  - persisted draft creation via `insertDraft(...)`
  - UI feedback for import-in-progress and import success
- Checks:
  - workspace typecheck — passed clean
- Notes:
  - creator can now import a selected release into persisted draft storage
  - manual smoke test and edge verification still needed

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

### Slice 4 — DB schema + draft persistence boundary (2026-03-20)
- Files: `packages/db/package.json`, `packages/db/src/schema.ts`, `packages/db/src/client.ts`, `packages/db/src/index.ts`, root `package.json`
- Persistence:
  - Drizzle ORM
  - SQLite via `better-sqlite3`
  - one `drafts` table
  - typed `insertDraft(...)` helper
- Checks:
  - `pnpm -r typecheck` — passed clean

### Slice 3 — GitHub integration adapter (2026-03-20)
- Files: `apps/web/auth.ts`, `packages/github/src/index.ts`
- GitHub adapter:
  - `listRepos(accessToken)`
  - `listReleases(accessToken, repoFullName)`
- Checks:
  - `pnpm typecheck` — passed clean
  - `pnpm --filter @patch-ritual/web build` — passed clean

### Slice 2 — GitHub auth wiring (2026-03-20)
- Files: `apps/web/auth.ts`, `apps/web/src/app/api/auth/[...nextauth]/route.ts`, `apps/web/middleware.ts`
- Config: GitHub OAuth provider only; JWT session strategy; `/dashboard/*` protected
- Checks:
  - `pnpm typecheck` — passed clean
  - `pnpm --filter @patch-ritual/web build` — passed clean

### Slice 1 — Domain types (2026-03-20)
- File: `packages/domain/src/index.ts`
- Exports: Creator, Project, Release, SourceItem
- Check: `pnpm -r typecheck` — passed clean

## Remaining Slices
7. Empty/error states + manual verification
OUT

echo "Updated STATE.md, PHASE_HANDOFF.md, and docs/verification/phase-01-auth-release-import.md"
