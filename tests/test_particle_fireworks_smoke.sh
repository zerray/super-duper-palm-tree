#!/usr/bin/env bash

set -euo pipefail

root_dir="$(cd "$(dirname "$0")/.." && pwd)"
app_file="$root_dir/particle-fireworks/index.html"

fail() {
  printf 'FAIL: %s\n' "$1" >&2
  exit 1
}

[ -f "$app_file" ] || fail "particle-fireworks/index.html is missing"

grep -q '<canvas id="fireworks-canvas"' "$app_file" || fail "fireworks canvas missing"
grep -q 'id="record-button"' "$app_file" || fail "record button missing"
grep -q 'id="playback-button"' "$app_file" || fail "playback button missing"
grep -q 'const MAX_PARTICLES = 2000;' "$app_file" || fail "particle pool constant missing"
grep -q 'const RECORDING_LIMIT_MS = 10000;' "$app_file" || fail "recording limit missing"
grep -q 'function mapBurstProfile' "$app_file" || fail "coordinate mapping function missing"
grep -q 'holdDuration / 1200' "$app_file" || fail "hold duration height mapping missing"
grep -q 'hue: Math.round(nx \* 360)' "$app_file" || fail "x to hue mapping missing"
grep -q 'secondaryChance: lerp(0.05, 0.32, ny)' "$app_file" || fail "secondary explosion mapping missing"
grep -q 'function recordFireworkEvent' "$app_file" || fail "recording function missing"
grep -q 'function updatePlayback' "$app_file" || fail "playback loop missing"
grep -q 'canvas.addEventListener("pointerdown"' "$app_file" || fail "pointer launch handler missing"
grep -q 'canvas.addEventListener("pointerup"' "$app_file" || fail "pointer release handler missing"
grep -q 'touch-action: none;' "$app_file" || fail "touch support styling missing"
grep -q 'requestAnimationFrame(animate);' "$app_file" || fail "animation loop missing"

printf 'particle fireworks smoke test passed\n'
