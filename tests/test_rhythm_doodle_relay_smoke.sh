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
grep -q 'const totalBeats = 16;' "$app_file" || fail "16-beat round missing"
grep -q 'const beatsPerPlayer = 8;' "$app_file" || fail "8-beat player switch missing"
grep -q 'const bpmOptions =' "$app_file" || fail "bpm options missing"
grep -q 'perfectWindowMs = 70' "$app_file" || fail "perfect timing window missing"
grep -q 'goodWindowMs = 150' "$app_file" || fail "good timing window missing"
grep -q 'id="mode-select"' "$app_file" || fail "mode selector missing"
grep -q 'id="speed-select"' "$app_file" || fail "speed selector missing"
grep -q 'window.AudioContext || window.webkitAudioContext' "$app_file" || fail "web audio setup missing"
grep -q 'function playBeatClick' "$app_file" || fail "metronome click missing"
grep -q 'function judgeBeat' "$app_file" || fail "beat judgement missing"
grep -q 'function getAccuracyPercent' "$app_file" || fail "accuracy scoring missing"
grep -q 'function pauseForPlayerSwitch' "$app_file" || fail "player switch handler missing"
grep -q 'function advanceBeat' "$app_file" || fail "beat advance missing"
grep -q 'function downloadImage' "$app_file" || fail "download handler missing"
grep -q 'canvas.toDataURL("image/png")' "$app_file" || fail "png export missing"
grep -q 'window.addEventListener("keydown", handleKeyDown);' "$app_file" || fail "keyboard drawing missing"
grep -q '玩家 1 区域' "$app_file" || fail "top-half split label missing"
grep -q '玩家 2 区域' "$app_file" || fail "bottom-half split label missing"

printf 'rhythm doodle relay smoke test passed\n'
