#!/usr/bin/env bash

set -euo pipefail

root_dir="$(cd "$(dirname "$0")/.." && pwd)"
app_file="$root_dir/slingshot-game/index.html"

fail() {
  printf 'FAIL: %s\n' "$1" >&2
  exit 1
}

[ -f "$app_file" ] || fail "slingshot-game/index.html is missing"

grep -q '<canvas id="game-canvas"' "$app_file" || fail "canvas missing"
grep -q 'const MIN_PLANETS = 3;' "$app_file" || fail "minimum planet count missing"
grep -q 'const MAX_PLANETS = 5;' "$app_file" || fail "maximum planet count missing"
grep -q 'const GRAVITY_CONSTANT = 2600;' "$app_file" || fail "gravity constant missing"
grep -q 'function computeTrajectoryPreview()' "$app_file" || fail "trajectory preview missing"
grep -q 'function generatePlanets(level)' "$app_file" || fail "procedural level generation missing"
grep -q 'function launchShip()' "$app_file" || fail "launch handler missing"
grep -q 'function completeLevel()' "$app_file" || fail "level progression missing"
grep -q 'Aim &amp; Launch' "$app_file" || fail "launch prompt missing"

printf 'slingshot game smoke test passed\n'
