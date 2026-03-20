#!/usr/bin/env bash

set -euo pipefail

root_dir="$(cd "$(dirname "$0")/.." && pwd)"
app_file="$root_dir/particle-life/index.html"

fail() {
  printf 'FAIL: %s\n' "$1" >&2
  exit 1
}

[ -f "$app_file" ] || fail "particle-life/index.html is missing"

grep -q '<canvas id="particle-canvas"' "$app_file" || fail "canvas element missing"
grep -q 'const PARTICLE_COUNT = 640;' "$app_file" || fail "particle count missing"
grep -q 'const SPECIES = \[' "$app_file" || fail "species list missing"
grep -q 'id="matrix-grid"' "$app_file" || fail "matrix UI missing"
grep -q 'id="randomize-button"' "$app_file" || fail "randomize button missing"
grep -q 'id="reset-button"' "$app_file" || fail "reset button missing"
grep -q 'id="spawn-species-select"' "$app_file" || fail "spawn species selector missing"
grep -q 'id="boundary-select"' "$app_file" || fail "boundary selector missing"
grep -q 'function randomizeMatrix' "$app_file" || fail "matrix randomizer missing"
grep -q 'function resetParticles' "$app_file" || fail "particle reset missing"
grep -q 'function spawnParticlesAt' "$app_file" || fail "spawn handler missing"
grep -q 'canvas.addEventListener("click", handleCanvasClick);' "$app_file" || fail "canvas click spawn missing"
grep -q 'function buildSpatialGrid' "$app_file" || fail "spatial grid missing"
grep -q 'function forceKernel' "$app_file" || fail "force kernel missing"
grep -q 'input type="range"' "$app_file" || fail "matrix sliders missing"
grep -q 'ctx.fillStyle = "rgba(2, 8, 18, 0.16)"' "$app_file" || fail "trail rendering missing"
grep -q 'requestAnimationFrame(tick)' "$app_file" || fail "animation loop missing"

printf 'particle life smoke test passed\n'
