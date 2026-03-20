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
