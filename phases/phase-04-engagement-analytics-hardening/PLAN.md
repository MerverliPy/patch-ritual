# Claude Code Phase Plan

## Objective
Complete the MVP loop with audience response, creator analytics, and speed validation.

## Scope
- reactions
- comments / guestbook
- views
- basic engagement signal
- workflow speed tuning
- end-to-end verification

## Non-Goals
- threaded discussion
- community systems
- advanced segmentation
- post-MVP differentiation

## Inputs
- published ritual flow
- `packages/db`
- `packages/domain`
- public ritual UI

## Deliverables
- reaction UI + persistence
- simple comments
- creator metrics view
- one completion / reach signal
- time-to-publish validation
- phase verification dossier

## Dependencies
Phase 3

## Execution Waves
### Wave 1
- reaction and comment models
- analytics event model

### Wave 2
- public engagement UI
- creator analytics UI

### Wave 3
- workflow timing review
- polish failure and empty states
- verification

## Acceptance Criteria
- audience can react without complex account flow
- audience can leave a simple comment
- creator sees views, reactions, comments, and one engagement signal
- typical release-selection to publish workflow can be completed in under 5 minutes

## Verification
- end-to-end MVP run-through
- comments/reactions persistence checks
- analytics display checks
- timed creator workflow exercise
