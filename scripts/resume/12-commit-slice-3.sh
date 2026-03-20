#!/usr/bin/env bash
set -euo pipefail

git add .
git commit -m "phase 1 slice 3: add authenticated GitHub repo and release adapter"
git push origin HEAD
