#!/usr/bin/env bash

set -euo pipefail

root_dir="$(cd "$(dirname "$0")/.." && pwd)"
app_file="$root_dir/rhythm-memory-grid/index.html"

fail() {
  printf 'FAIL: %s\n' "$1" >&2
  exit 1
}

[ -f "$app_file" ] || fail "rhythm-memory-grid/index.html is missing"

grep -q '<title>节奏色块记忆挑战</title>' "$app_file" || fail "page title missing"
grep -q 'const levels = \[' "$app_file" || fail "levels array missing"
grep -q 'patternLength: 3' "$app_file" || fail "level 1 sequence length missing"
grep -q 'patternLength: 5' "$app_file" || fail "level 2 sequence length missing"
grep -q 'patternLength: 7' "$app_file" || fail "level 3 sequence length missing"
grep -q 'data-mode="solo"' "$app_file" || fail "solo mode button missing"
grep -q 'data-mode="versus"' "$app_file" || fail "versus mode button missing"
grep -q 'localStorage.getItem(storageKey)' "$app_file" || fail "high score persistence missing"
grep -q 'navigator.vibrate' "$app_file" || fail "error vibration feedback missing"
grep -q 'AudioContext || window.webkitAudioContext' "$app_file" || fail "web audio setup missing"
grep -q 'function generateSequence(level)' "$app_file" || fail "sequence generator missing"
grep -q 'async function playbackSequence(token)' "$app_file" || fail "pattern playback missing"
grep -q 'function handleCellInput(index)' "$app_file" || fail "input handler missing"
grep -q 'function resolveVersusResult()' "$app_file" || fail "hot-seat result flow missing"
grep -q '玩家 1 获胜' "$app_file" || fail "two-player winner copy missing"

printf 'rhythm memory grid smoke test passed\n'
