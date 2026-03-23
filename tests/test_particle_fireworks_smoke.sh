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
grep -q 'id="color-input"' "$app_file" || fail "color input missing"
grep -q 'id="shape-select"' "$app_file" || fail "shape select missing"
grep -q 'id="random-button"' "$app_file" || fail "random surprise button missing"
grep -q 'id="record-button"' "$app_file" || fail "record button missing"
grep -q 'id="playback-button"' "$app_file" || fail "playback button missing"
grep -q 'const MAX_PARTICLES = 2400;' "$app_file" || fail "particle pool constant missing"
grep -q 'const replayDurationMs = 10000;' "$app_file" || fail "replay duration missing"
grep -q 'function computeVelocity' "$app_file" || fail "shape velocity function missing"
grep -q 'shape === "heart"' "$app_file" || fail "heart shape missing"
grep -q 'shape === "spiral"' "$app_file" || fail "spiral shape missing"
grep -q 'function recordFireworkEvent' "$app_file" || fail "recording function missing"
grep -q 'function updatePlayback' "$app_file" || fail "playback loop missing"
grep -q 'canvas.addEventListener("pointerdown", handlePointerLaunch);' "$app_file" || fail "pointer launch handler missing"
grep -q 'requestAnimationFrame(animate);' "$app_file" || fail "animation loop missing"

printf 'particle fireworks smoke test passed\n'
