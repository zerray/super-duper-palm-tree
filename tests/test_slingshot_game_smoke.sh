#!/usr/bin/env bash

set -euo pipefail

root_dir="$(cd "$(dirname "$0")/.." && pwd)"
app_file="$root_dir/slingshot-game/index.html"

fail() {
  printf 'FAIL: %s\n' "$1" >&2
  exit 1
}

[ -f "$app_file" ] || fail "slingshot-game/index.html is missing"

grep -q '<canvas id="game-canvas"' "$app_file" || fail "canvas element missing"
grep -q 'function generateLevel(levelNumber)' "$app_file" || fail "level generation missing"
grep -q 'const bodyCount = Math.min(5, 2 + levelNumber);' "$app_file" || fail "planet count scaling missing"
grep -q 'function computeGravityAcceleration(position)' "$app_file" || fail "gravity simulation missing"
grep -q 'const G = 240000;' "$app_file" || fail "gravity constant missing"
grep -q 'function buildGhostTrajectory()' "$app_file" || fail "trajectory preview missing"
grep -q 'function drawGravityWells(planet)' "$app_file" || fail "gravity wells missing"
grep -q 'function drawTrailRendering()' "$app_file" || fail "trail rendering missing"
grep -q 'function hasProjectileReachedTarget(projectile)' "$app_file" || fail "target collision missing"
grep -q 'state.level += 1;' "$app_file" || fail "level advance missing"
grep -q 'requestAnimationFrame(gameLoop);' "$app_file" || fail "animation loop missing"

printf 'slingshot game smoke test passed\n'
