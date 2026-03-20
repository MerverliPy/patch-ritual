#!/usr/bin/env bash
set -euo pipefail

git switch prune-speculative-surfaces
git pull --ff-only || true
git switch -c phase-01-slice-04-draft-persistence 2>/dev/null || git switch phase-01-slice-04-draft-persistence

echo "## Current branch"
git branch --show-current
