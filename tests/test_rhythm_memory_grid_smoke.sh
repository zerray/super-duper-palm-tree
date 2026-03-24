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
grep -q '热座双人轮流挑战同一序列' "$app_file" || fail "hot-seat instructions missing"
grep -q '支持触屏、鼠标与数字键 `1-8`' "$app_file" || fail "input instructions missing"
grep -q 'const PAD_LIBRARY = \[' "$app_file" || fail "pad config missing"
grep -q 'window.AudioContext || window.webkitAudioContext' "$app_file" || fail "web audio setup missing"
grep -q 'window.localStorage.getItem(STORAGE_KEY)' "$app_file" || fail "best-score persistence missing"
grep -q 'pointerdown' "$app_file" || fail "pointer input missing"
grep -Fq 'Math.min(4 + Math.floor((state.round - 1) / 3), PAD_LIBRARY.length)' "$app_file" || fail "pad growth rule missing"
grep -Fq 'const baseInterval = 720;' "$app_file" || fail "base interval missing"
grep -Fq 'const intervalDrop = (state.round - 1) * 28;' "$app_file" || fail "tempo scaling missing"
grep -q 'function appendRandomPad()' "$app_file" || fail "sequence growth missing"
grep -q 'async function playbackSequence()' "$app_file" || fail "sequence playback missing"
grep -q 'async function handlePadInput(id)' "$app_file" || fail "input handler missing"
grep -q 'function finishVersusRun()' "$app_file" || fail "versus result handling missing"
grep -q 'playBeatTick' "$app_file" || fail "beat audio missing"

printf 'rhythm memory grid smoke test passed\n'
