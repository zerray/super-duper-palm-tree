#!/usr/bin/env bash

set -euo pipefail

root_dir="$(cd "$(dirname "$0")/.." && pwd)"
app_file="$root_dir/gravity-well-slingshot/index.html"

fail() {
  printf 'FAIL: %s\n' "$1" >&2
  exit 1
}

[ -f "$app_file" ] || fail "gravity-well-slingshot/index.html is missing"

grep -q '<canvas id="game"></canvas>' "$app_file" || fail "canvas missing"
grep -q 'const levelConfigs = \[' "$app_file" || fail "level config missing"
grep -q 'const previewSteps = 200;' "$app_file" || fail "prediction step configuration missing"
grep -q 'const G = 4200;' "$app_file" || fail "gravity constant missing"
grep -q 'function computeGravity(position)' "$app_file" || fail "gravity simulation missing"
grep -q 'function updatePrediction()' "$app_file" || fail "prediction line simulation missing"
grep -q 'function updateSimulation(dt)' "$app_file" || fail "simulation loop missing"
grep -q 'function drawGravityWell(well)' "$app_file" || fail "gravity well rendering missing"
grep -q 'function drawTrail(points)' "$app_file" || fail "trail rendering missing"
grep -q 'function finishLevel()' "$app_file" || fail "level completion missing"
grep -q 'state.levelIndex === levelConfigs.length - 1' "$app_file" || fail "final level completion missing"
grep -q 'canvas.addEventListener("pointerdown"' "$app_file" || fail "pointer launch controls missing"
grep -q 'id="score-label"' "$app_file" || fail "score label missing"
grep -q 'requestAnimationFrame(frame);' "$app_file" || fail "animation loop missing"

printf 'gravity well slingshot smoke test passed\n'
