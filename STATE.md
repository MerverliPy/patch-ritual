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
