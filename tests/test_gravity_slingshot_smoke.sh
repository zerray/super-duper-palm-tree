#!/usr/bin/env bash

set -euo pipefail

root_dir="$(cd "$(dirname "$0")/.." && pwd)"
app_file="$root_dir/gravity-slingshot/index.html"

fail() {
  printf 'FAIL: %s\n' "$1" >&2
  exit 1
}

[ -f "$app_file" ] || fail "gravity-slingshot/index.html is missing"

grep -q '<canvas id="game"></canvas>' "$app_file" || fail "canvas missing"
grep -q 'const G = 3200;' "$app_file" || fail "gravity constant missing"
grep -q 'const crystalTargetCount = 6;' "$app_file" || fail "crystal count configuration missing"
grep -q 'function generateBodies(rng)' "$app_file" || fail "procedural body generation missing"
grep -q 'function computeGravity(position)' "$app_file" || fail "gravity calculation missing"
grep -q 'function updateSimulation(dt)' "$app_file" || fail "simulation loop missing"
grep -q 'function drawGravityGrid()' "$app_file" || fail "gravity well visualization missing"
grep -q 'function handleCrystalCollection()' "$app_file" || fail "crystal collection logic missing"
grep -q 'id="reset-button"' "$app_file" || fail "reset button missing"
grep -q 'requestAnimationFrame(frame);' "$app_file" || fail "animation loop missing"

printf 'gravity slingshot smoke test passed\n'
