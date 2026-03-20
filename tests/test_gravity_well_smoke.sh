#!/usr/bin/env bash

set -euo pipefail

root_dir="$(cd "$(dirname "$0")/.." && pwd)"
app_file="$root_dir/gravity-well/index.html"

fail() {
  printf 'FAIL: %s\n' "$1" >&2
  exit 1
}

[ -f "$app_file" ] || fail "gravity-well/index.html is missing"

grep -q '<canvas id="sim"></canvas>' "$app_file" || fail "canvas element missing"
grep -q 'id="gravity-slider"' "$app_file" || fail "gravity slider missing"
grep -q 'id="spawn-slider"' "$app_file" || fail "spawn slider missing"
grep -q 'id="trail-slider"' "$app_file" || fail "trail slider missing"
grep -q 'id="clear-button"' "$app_file" || fail "clear button missing"
grep -q 'id="save-button"' "$app_file" || fail "save button missing"
grep -q 'const MAX_PARTICLES = 500;' "$app_file" || fail "particle cap missing"
grep -q 'canvas.addEventListener("click"' "$app_file" || fail "left click handler missing"
grep -q 'canvas.addEventListener("contextmenu"' "$app_file" || fail "right click handler missing"
grep -q 'event.preventDefault();' "$app_file" || fail "context menu suppression missing"
grep -q 'function spawnParticles(dt)' "$app_file" || fail "particle spawning missing"
grep -q 'function updateParticles(dt)' "$app_file" || fail "particle simulation missing"
grep -q 'function drawParticleTrail(particle)' "$app_file" || fail "trail rendering missing"
grep -q 'canvas.toDataURL("image/png")' "$app_file" || fail "PNG export missing"

printf 'gravity well smoke test passed\n'
