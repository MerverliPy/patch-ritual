# Claude Code Phase Plan

## Objective
Publish a ritual draft to a public URL and deliver the audience-facing ritual experience.

## Scope
- publish action
- public ritual route
- shareable URL
- republish behavior
- mobile-safe rendering

## Non-Goals
- reactions analytics hardening
- archive pages
- rich social cards beyond basics

## Inputs
- Phase 2 ritual draft
- `apps/web`
- `packages/ui`
- `packages/db`

## Deliverables
- publish flow
- public ritual page
- republish update flow
- success and failure states
- mobile-safe UI

## Dependencies
Phase 2

## Execution Waves
### Wave 1
- published ritual persistence model
- public route design

### Wave 2
- publish + republish flows
- audience page rendering

### Wave 3
- sharing UX
- responsive polish
- verification

## Acceptance Criteria
- creator can publish a ritual draft
- publish produces a public URL
- unauthenticated visitors can open the ritual
- creator can republish updates to the same URL
- failure states preserve the draft

## Verification
- publish smoke test
- public access test without auth
- republish test
- desktop + mobile manual review
