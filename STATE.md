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
