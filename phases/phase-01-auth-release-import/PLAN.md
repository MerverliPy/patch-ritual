# Claude Code Phase Plan

## Objective
Enable one creator to sign in with GitHub, select one repository, view releases, and import one release into a normalized draft.

## Scope
- GitHub auth
- repository selection
- release list
- release import
- release normalization
- draft persistence

## Non-Goals
- ritual generation
- public publish flow
- reactions or analytics
- extra integrations

## Inputs
- `REQUIREMENTS.md`
- `packages/github`
- `packages/domain`
- `packages/db`

## Deliverables
- auth flow
- repository selection UI
- release selection UI
- normalized release entity + storage
- draft creation from imported release data
- partial import handling

## Dependencies
Phase 0

## Execution Waves
### Wave 1
- domain model for creator, project, release, source items
- auth and session boundary decisions

### Wave 2
- GitHub integration adapter
- repository and release list fetch
- release import and normalization

### Wave 3
- creator workspace UI
- empty and failure states
- verification

## Acceptance Criteria
- creator can sign in with GitHub
- creator can select one repository
- available releases are shown with core metadata
- selecting a release creates a draft
- partial source data does not block draft creation

## Verification
- manual auth smoke test
- import test with a repo that has releases
- empty-state test with a repo lacking releases
- inspect normalized release object for required fields
