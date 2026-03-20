#!/usr/bin/env bash

set -euo pipefail

root_dir="$(cd "$(dirname "$0")/.." && pwd)"
app_file="$root_dir/beat-grid/index.html"

fail() {
  printf 'FAIL: %s\n' "$1" >&2
  exit 1
}

[ -f "$app_file" ] || fail "beat-grid/index.html is missing"

grep -q 'class="pad-grid" id="pad-grid"' "$app_file" || fail "pad grid missing"
grep -q 'const gridSize = 4;' "$app_file" || fail "grid size missing"
grep -q 'const maxMisses = 5;' "$app_file" || fail "miss limit missing"
grep -q 'const hitsPerTempoIncrease = 20;' "$app_file" || fail "hit-based tempo ramp missing"
grep -q 'const tempoIncreaseIntervalMs = 30000;' "$app_file" || fail "time-based tempo ramp missing"
grep -q 'window.setInterval(scheduler, schedulerTickMs)' "$app_file" || fail "beat scheduler missing"
grep -q 'AudioContextClass = window.AudioContext || window.webkitAudioContext' "$app_file" || fail "web audio setup missing"
grep -q 'function scheduleBeatEvent(beatTime)' "$app_file" || fail "beat event generation missing"
grep -q 'state.score += 10 \* getMultiplier();' "$app_file" || fail "score logic missing"
grep -q 'finalScoreEl.textContent = String(state.score);' "$app_file" || fail "final score output missing"
grep -q 'id="game-over"' "$app_file" || fail "game over overlay missing"

printf 'beat grid smoke test passed\n'
