# Verification: Phase 1 — Auth, Repository Selection, Release Import

## Status: in progress

## Acceptance Criteria

| # | Criterion | Status |
|---|-----------|--------|
| 1 | Creator can sign in with GitHub | wired — pending smoke test |
| 2 | Creator can select one repository | not started |
| 3 | Available releases shown with core metadata | not started |
| 4 | Selecting a release creates a draft | not started |
| 5 | Partial source data does not block draft creation | type-level only |

## Slice Verification Log

### Slice 2 — GitHub auth wiring (2026-03-20)
- Files: `apps/web/auth.ts`, `apps/web/src/app/api/auth/[...nextauth]/route.ts`, `apps/web/middleware.ts`
- Packages: `next-auth@5.0.0-beta.30` (Auth.js v5)
- Config: GitHub OAuth provider only; JWT session strategy; `/dashboard/*` protected
- Env: `.env.example` at repo root (AUTH_SECRET, GITHUB_CLIENT_ID, GITHUB_CLIENT_SECRET)
- Check: `pnpm typecheck` — passed clean; `pnpm --filter @patch-ritual/web build` — passed clean
- Notes: GitHub access token not yet threaded into JWT callback — required before Slice 3 can call GitHub API on behalf of user.

### Slice 1 — Domain types (2026-03-20)
- File: `packages/domain/src/index.ts`
- Exports: Creator, Project, Release, SourceItem
- Check: `pnpm -r typecheck` — passed clean (7 packages)
- Notes: SourceItem.title and .body are nullable, satisfying criterion 5 at the type level. Runtime normalization pending Slice 7.

## Remaining Slices
3. GitHub adapter — list repos, list releases, fetch one release
4. DB schema + draft persistence
5. Next.js GitHub OAuth sign-in + session provider
6. Repo selection + release list UI
7. Release import: normalize → persist draft
8. Empty/error states + manual verification
