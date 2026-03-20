#!/usr/bin/env bash
set -euo pipefail

node <<'NODE'
const fs = require("fs");
const path = "package.json";
const pkg = JSON.parse(fs.readFileSync(path, "utf8"));
pkg.packageManager = "pnpm@10.32.1";
pkg.pnpm = pkg.pnpm || {};
pkg.pnpm.onlyBuiltDependencies = ["better-sqlite3"];
fs.writeFileSync(path, JSON.stringify(pkg, null, 2) + "\n");
console.log("Updated root package.json:");
console.log("- packageManager: pnpm@10.32.1");
console.log('- pnpm.onlyBuiltDependencies: ["better-sqlite3"]');
NODE

corepack enable || true
corepack prepare pnpm@10.32.1 --activate
pnpm --version
