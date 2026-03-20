#!/usr/bin/env bash
set -euo pipefail

echo "## STEP 1: ensure corepack is available"
npm install --global corepack@latest
corepack enable

echo
echo "## STEP 2: resolve the latest exact pnpm 10.x version"
PNPM_VERSION="$(npm view pnpm@10 version --json | node -e '
const fs = require("fs");
const raw = fs.readFileSync(0, "utf8");
const data = JSON.parse(raw);
if (Array.isArray(data)) {
  console.log(data[data.length - 1]);
} else {
  console.log(data);
}
')"

echo "Resolved pnpm version: $PNPM_VERSION"

echo
echo "## STEP 3: write exact packageManager version into package.json"
node - "$PNPM_VERSION" <<'NODE'
const fs = require("fs");
const version = process.argv[2];
const path = "package.json";
const pkg = JSON.parse(fs.readFileSync(path, "utf8"));
pkg.packageManager = `pnpm@${version}`;
fs.writeFileSync(path, JSON.stringify(pkg, null, 2) + "\n");
console.log(`Updated ${path}: packageManager=${pkg.packageManager}`);
NODE

echo
echo "## STEP 4: activate that exact pnpm version"
corepack prepare "pnpm@$PNPM_VERSION" --activate

echo
echo "## STEP 5: verify toolchain"
pnpm --version

echo
echo "## STEP 6: install workspace deps"
pnpm install

echo
echo "Done."
