#!/usr/bin/env bash
set -euo pipefail

git switch -c phase-01-slice-07-verification 2>/dev/null || git switch phase-01-slice-07-verification
git branch --show-current
