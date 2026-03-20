#!/usr/bin/env bash

set -euo pipefail

root_dir="$(cd "$(dirname "$0")/.." && pwd)"
app_file="$root_dir/gravity-well-sandbox/index.html"

fail() {
  printf 'FAIL: %s\n' "$1" >&2
  exit 1
}

[ -f "$app_file" ] || fail "gravity-well-sandbox/index.html is missing"

grep -q '<canvas id="sim"></canvas>' "$app_file" || fail "canvas element missing"
grep -q 'id="mass-slider"' "$app_file" || fail "mass slider missing"
grep -q 'id="particle-slider"' "$app_file" || fail "particle slider missing"
grep -q 'id="mode-toggle"' "$app_file" || fail "mode toggle missing"
grep -q 'id="trail-toggle"' "$app_file" || fail "trail toggle missing"
grep -q 'id="clear-particles"' "$app_file" || fail "clear particles button missing"
grep -q 'id="clear-nodes"' "$app_file" || fail "clear nodes button missing"
grep -q 'const MAX_PARTICLES = 480;' "$app_file" || fail "particle cap missing"
grep -q 'function spawnBurst' "$app_file" || fail "particle launch function missing"
grep -q 'function accelerationAt' "$app_file" || fail "gravity calculation missing"
grep -q 'function updateParticles' "$app_file" || fail "verlet update missing"
grep -q 'canvas.addEventListener("pointerdown"' "$app_file" || fail "pointer launch handler missing"
grep -q 'canvas.addEventListener("contextmenu"' "$app_file" || fail "node removal handler missing"
grep -q 'trailsEnabled = !trailsEnabled;' "$app_file" || fail "trail toggle logic missing"
grep -q 'requestAnimationFrame(tick)' "$app_file" || fail "animation loop missing"

printf 'gravity well sandbox smoke test passed\n'
