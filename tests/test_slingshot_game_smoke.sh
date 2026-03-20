#!/usr/bin/env bash

set -euo pipefail

root_dir="$(cd "$(dirname "$0")/.." && pwd)"
app_file="$root_dir/slingshot-game/index.html"

fail() {
  printf 'FAIL: %s\n' "$1" >&2
  exit 1
}

[ -f "$app_file" ] || fail "slingshot-game/index.html is missing"

grep -q 'const minPlanetCount = 3;' "$app_file" || fail "minimum gravitational body count missing"
grep -q 'const previewSteps = 240;' "$app_file" || fail "trajectory preview configuration missing"
grep -q 'const G = 2400;' "$app_file" || fail "gravity constant missing"
grep -q 'function updateGhostTrajectory()' "$app_file" || fail "ghost trajectory simulation missing"
grep -q 'function computeGravity(position)' "$app_file" || fail "gravity calculation missing"
grep -q 'const asteroidCount = clamp(level - 1, 0, 3);' "$app_file" || fail "procedural asteroid hazards missing"
grep -q 'function collidesWithAsteroid(body)' "$app_file" || fail "asteroid collision logic missing"
grep -q 'function awardScore()' "$app_file" || fail "fuel efficiency scoring missing"
grep -q 'id="score"' "$app_file" || fail "score HUD missing"
grep -q 'function updateSimulation(dt)' "$app_file" || fail "real-time projectile simulation missing"
grep -q 'state.level = level;' "$app_file" || fail "level progression state missing"
grep -q 'buildLevel(state.level + 1);' "$app_file" || fail "next level advancement missing"
grep -q 'drawTrail(state.trail' "$app_file" || fail "flight trail rendering missing"
grep -q 'drawGravityWell(planet);' "$app_file" || fail "gravity well rendering missing"

printf 'slingshot game smoke test passed\n'
