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
grep -q 'const GRAVITY_CONSTANT = 5800;' "$app_file" || fail "gravity constant missing"
grep -q 'function generateLevel(nextLevel)' "$app_file" || fail "level generator missing"
grep -q 'const bodyCount = clamp(2 + level, 3, 5);' "$app_file" || fail "planet count scaling missing"
grep -q 'function computePreviewTrajectory(pointer)' "$app_file" || fail "trajectory preview missing"
grep -q 'function updateFlight(dt)' "$app_file" || fail "flight integrator missing"
grep -q 'function drawGravityWell(planet)' "$app_file" || fail "gravity well rendering missing"
grep -q 'trail.push({ x: projectile.x, y: projectile.y });' "$app_file" || fail "trail recording missing"
grep -q 'generateLevel(level + 1);' "$app_file" || fail "level advancement missing"
grep -q 'canvas.addEventListener("pointerdown", beginAim);' "$app_file" || fail "aim controls missing"

printf 'slingshot game smoke test passed\n'
