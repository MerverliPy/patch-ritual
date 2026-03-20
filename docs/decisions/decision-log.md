# decision-log.md

## ADR-001
### Decision
Use a TypeScript-first monorepo with `apps/web` as the center of gravity.

### Why
The MVP is primarily a web product with integration-heavy flows and a public audience surface.

### Consequence
Keep shared packages small. Delay separate workers until they are forced by latency or media processing needs.

## ADR-002
### Decision
Use a thin Claude Code orchestrator with a few specialists instead of many narrow subagents.

### Why
This reduces token overhead and coordination complexity for a solo-builder repo.

### Consequence
Only keep subagents that materially improve planning, implementation isolation, or verification.
