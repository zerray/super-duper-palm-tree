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
grep -q 'data-mode="solo"' "$app_file" || fail "solo mode button missing"
grep -q 'data-mode="versus"' "$app_file" || fail "versus mode button missing"
grep -q 'pointerdown' "$app_file" || fail "pointer input missing"
grep -q '热座双人模式' "$app_file" || fail "hot-seat instructions missing"
grep -q 'window.AudioContext || window.webkitAudioContext' "$app_file" || fail "web audio setup missing"
grep -q 'function buildSequence(length, activeCount)' "$app_file" || fail "sequence generator missing"
grep -q 'async function playbackSequence' "$app_file" || fail "sequence playback missing"
grep -q 'function handleTileInput(tileId)' "$app_file" || fail "input handler missing"
grep -q 'function advanceRound()' "$app_file" || fail "round progression missing"
grep -Fq 'Math.min(9, 4 + Math.floor((round - 1) / 3))' "$app_file" || fail "tile scaling rule missing"
grep -Fq 'Math.max(320, 860 - (round - 1) * 38)' "$app_file" || fail "tempo scaling rule missing"
grep -q 'matchSequences' "$app_file" || fail "shared versus sequences missing"
grep -q 'localStorage.getItem' "$app_file" || fail "best score persistence missing"
grep -q '玩家 1 获胜' "$app_file" || fail "winner copy missing"
grep -q '玩家 2 获胜' "$app_file" || fail "winner copy missing"
grep -q '顺序错误' "$app_file" || fail "fail state missing"
grep -q '支持鼠标点击与触屏点击' "$app_file" || fail "input copy missing"

printf 'rhythm memory grid smoke test passed\n'
