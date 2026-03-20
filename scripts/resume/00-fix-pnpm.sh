#!/usr/bin/env bash
set -euo pipefail

echo "## Fix packageManager version to exact pnpm 10.x"
PNPM_VERSION="$(npm view pnpm@10 version --json | node -e '
const fs = require("fs");
const raw = fs.readFileSync(0, "utf8");
const data = JSON.parse(raw);
console.log(Array.isArray(data) ? data[data.length - 1] : data);
')"

echo "Resolved pnpm version: $PNPM_VERSION"

node - "$PNPM_VERSION" <<'NODE'
const fs = require("fs");
const version = process.argv[2];
const path = "package.json";
const pkg = JSON.parse(fs.readFileSync(path, "utf8"));
pkg.packageManager = `pnpm@${version}`;
fs.writeFileSync(path, JSON.stringify(pkg, null, 2) + "\n");
console.log(`Updated ${path} -> ${pkg.packageManager}`);
NODE

corepack enable || true
corepack prepare "pnpm@$PNPM_VERSION" --activate
pnpm --version
pnpm install
