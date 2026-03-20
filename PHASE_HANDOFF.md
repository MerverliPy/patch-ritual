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
