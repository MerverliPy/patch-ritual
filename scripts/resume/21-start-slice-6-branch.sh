#!/usr/bin/env bash
set -euo pipefail

git switch -c phase-01-slice-06-release-import 2>/dev/null || git switch phase-01-slice-06-release-import
git branch --show-current
