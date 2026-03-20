# Verification: Phase 1 — Auth, Repository Selection, Release Import

## Status: in progress

## Acceptance Criteria

| # | Criterion | Status |
|---|-----------|--------|
| 1 | Creator can sign in with GitHub | not started |
| 2 | Creator can select one repository | not started |
| 3 | Available releases shown with core metadata | not started |
| 4 | Selecting a release creates a draft | not started |
| 5 | Partial source data does not block draft creation | type-level only |

## Slice Verification Log

### Slice 1 — Domain types (2026-03-20)
- File: `packages/domain/src/index.ts`
- Exports: Creator, Project, Release, SourceItem
- Check: `pnpm -r typecheck` — passed clean (7 packages)
- Notes: SourceItem.title and .body are nullable, satisfying criterion 5 at the type level. Runtime normalization pending Slice 7.

## Remaining Slices
2. Auth provider + ORM decision — lock choices, install packages
3. GitHub adapter — list repos, list releases, fetch one release
4. DB schema + draft persistence
5. Next.js GitHub OAuth sign-in + session provider
6. Repo selection + release list UI
7. Release import: normalize → persist draft
8. Empty/error states + manual verification
