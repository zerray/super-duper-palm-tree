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
grep -q 'const gridSize = 16;' "$app_file" || fail "16x16 grid missing"
grep -q 'const steps = 16;' "$app_file" || fail "16-step playback missing"
grep -q 'id="grid-canvas"' "$app_file" || fail "grid canvas missing"
grep -q 'id="play-button"' "$app_file" || fail "play button missing"
grep -q 'id="replay-button"' "$app_file" || fail "replay button missing"
grep -q 'id="switch-player-button"' "$app_file" || fail "switch player button missing"
grep -q 'id="clear-button"' "$app_file" || fail "clear button missing"
grep -q 'window.AudioContext || window.webkitAudioContext' "$app_file" || fail "web audio setup missing"
grep -q 'wave: "sine"' "$app_file" || fail "player 1 sine voice missing"
grep -q 'wave: "square"' "$app_file" || fail "player 2 square voice missing"
grep -q 'function getFrequencyForRow' "$app_file" || fail "pitch mapping missing"
grep -q 'function triggerColumn' "$app_file" || fail "column playback missing"
grep -q 'function startPlayback' "$app_file" || fail "playback controller missing"
grep -q 'canvas.addEventListener("pointerdown"' "$app_file" || fail "pointer drawing start missing"
grep -q 'canvas.addEventListener("pointermove"' "$app_file" || fail "pointer drawing move missing"
grep -q 'currentScanColumn' "$app_file" || fail "scan line state missing"

printf 'rhythm doodle relay smoke test passed\n'
