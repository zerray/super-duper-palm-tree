#!/usr/bin/env bash

set -euo pipefail

root_dir="$(cd "$(dirname "$0")/.." && pwd)"
game_file="$root_dir/slingshot-game/index.html"

fail() {
  printf 'FAIL: %s\n' "$1" >&2
  exit 1
}

[ -f "$game_file" ] || fail "slingshot-game/index.html is missing"

grep -q '<canvas id="game-canvas"' "$game_file" || fail "canvas element missing"
grep -q 'const constants = {' "$game_file" || fail "physics constants missing"
grep -q 'gravityConstant: 2400' "$game_file" || fail "gravity constant missing"
grep -q 'function generateLevel(level)' "$game_file" || fail "level generation missing"
grep -q 'const planetCount = Math.min(2 + level, 5);' "$game_file" || fail "planet count scaling missing"
grep -q 'function updatePreview()' "$game_file" || fail "trajectory preview missing"
grep -q 'function simulateStep(body, dt)' "$game_file" || fail "physics step missing"
grep -q 'state.projectile.trail.push' "$game_file" || fail "trail rendering state missing"
grep -q 'Target reached. Generating a denser orbit field' "$game_file" || fail "level advancement status missing"

printf 'slingshot game smoke test passed\n'
