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
grep -q 'data-mode="hotseat"' "$app_file" || fail "hot-seat mode button missing"
grep -q '支持触屏和鼠标点击' "$app_file" || fail "pointer/touch instructions missing"
grep -q '每 3 轮增加 1 个色块' "$app_file" || fail "difficulty copy missing"
grep -q 'const pads = \[' "$app_file" || fail "pad config missing"
grep -q 'window.AudioContext || window.webkitAudioContext' "$app_file" || fail "web audio setup missing"
grep -q 'localStorage.getItem' "$app_file" || fail "localStorage usage missing"
grep -q 'performance.now()' "$app_file" || fail "timing source missing"
grep -q 'Math.min(basePadCount + Math.floor((round - 1) / 3), pads.length)' "$app_file" || fail "pad growth logic missing"
grep -q 'function getTempoForRound(round)' "$app_file" || fail "tempo progression missing"
grep -q 'async function playbackSequence(token)' "$app_file" || fail "sequence playback missing"
grep -q 'function handlePadInput(index)' "$app_file" || fail "input handler missing"
grep -q 'function finishSoloRound()' "$app_file" || fail "solo round progression missing"
grep -q 'function resolveHotseatRound()' "$app_file" || fail "hot-seat resolution missing"
grep -q 'pointerdown' "$app_file" || fail "pointer input missing"

printf 'rhythm memory grid smoke test passed\n'
