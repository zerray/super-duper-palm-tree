#!/usr/bin/env bash

set -euo pipefail

root_dir="$(cd "$(dirname "$0")/.." && pwd)"
app_file="$root_dir/gravity-sandbox/index.html"

fail() {
  printf 'FAIL: %s\n' "$1" >&2
  exit 1
}

[ -f "$app_file" ] || fail "gravity-sandbox/index.html is missing"

grep -q '<canvas id="sim"></canvas>' "$app_file" || fail "simulation canvas missing"
grep -q 'id="gravity-slider"' "$app_file" || fail "gravity slider missing"
grep -q 'id="mass-slider"' "$app_file" || fail "mass slider missing"
grep -q 'id="trail-slider"' "$app_file" || fail "trail slider missing"
grep -q 'id="pause-button"' "$app_file" || fail "pause button missing"
grep -q 'id="clear-button"' "$app_file" || fail "clear button missing"
grep -q 'const MAX_PARTICLES = 160;' "$app_file" || fail "particle cap missing"
grep -q 'class Particle' "$app_file" || fail "particle class missing"
grep -q 'function mergeParticles' "$app_file" || fail "merge handler missing"
grep -q 'function drawTrails' "$app_file" || fail "trail renderer missing"
grep -q 'function drawLaunchArrow' "$app_file" || fail "drag arrow missing"
grep -q 'canvas.addEventListener("mousedown", beginDrag);' "$app_file" || fail "mouse drag handler missing"
grep -q 'window.addEventListener("mouseup", endDrag);' "$app_file" || fail "mouse release handler missing"
grep -q 'canvas.addEventListener("touchstart", beginDrag, { passive: false });' "$app_file" || fail "touch start handler missing"
grep -q 'ctx.globalCompositeOperation = "lighter";' "$app_file" || fail "glow blend mode missing"
grep -q 'requestAnimationFrame(tick)' "$app_file" || fail "animation loop missing"

printf 'gravity sandbox smoke test passed\n'
