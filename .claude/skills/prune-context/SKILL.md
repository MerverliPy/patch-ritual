---
name: prune-context
description: Reduce token waste by pruning stale docs, duplicate guidance, and dead workflow artifacts.
disable-model-invocation: true
allowed-tools: Read, Write, Edit, Grep, Glob
---

Use this skill when the repo starts accumulating planning debt.

Check for:
- duplicate guidance across root docs, skills, agents, and phase files
- stale plans
- dead commands or unused skills
- outdated handoff notes
- root file bloat
- memory files that no workflow actually uses

Output:
- what should be pruned now
- what should be archived later
- what root docs should be shortened
