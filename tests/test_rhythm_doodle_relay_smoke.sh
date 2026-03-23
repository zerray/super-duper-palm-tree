#!/usr/bin/env bash

set -euo pipefail

root_dir="$(cd "$(dirname "$0")/.." && pwd)"
app_file="$root_dir/rhythm-doodle-relay/index.html"

fail() {
  printf 'FAIL: %s\n' "$1" >&2
  exit 1
}

[ -f "$app_file" ] || fail "rhythm-doodle-relay/index.html is missing"

grep -q '<title>节奏涂鸦接力</title>' "$app_file" || fail "page title missing"
grep -q '<canvas id="paint-canvas"' "$app_file" || fail "paint canvas missing"
grep -q 'const bpm = 120;' "$app_file" || fail "fixed bpm missing"
grep -q 'const totalBeats = 32;' "$app_file" || fail "32-beat round missing"
grep -q 'const beatsPerTurn = 4;' "$app_file" || fail "4-beat player rotation missing"
grep -q 'const beatWindowMs = 150;' "$app_file" || fail "beat window missing"
grep -q 'new AudioContext()' "$app_file" || fail "audio context setup missing"
grep -q 'function scheduleBeat' "$app_file" || fail "beat scheduler missing"
grep -q 'function classifyStroke' "$app_file" || fail "stroke timing classification missing"
grep -q 'function finishRound' "$app_file" || fail "round results missing"
grep -q 'canvas.toBlob' "$app_file" || fail "png export missing"

printf 'rhythm doodle relay smoke test passed\n'
