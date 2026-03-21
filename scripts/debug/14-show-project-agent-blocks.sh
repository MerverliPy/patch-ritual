#!/usr/bin/env bash
set -euo pipefail

echo "## Project local settings"
cat .claude/settings.local.json
echo
echo "## Installed agents"
claude agents
