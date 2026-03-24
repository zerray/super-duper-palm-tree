#!/usr/bin/env bash

set -euo pipefail

root_dir="$(cd "$(dirname "$0")/.." && pwd)"
app_file="$root_dir/rhythm-memory-grid/index.html"

fail() {
  printf 'FAIL: %s\n' "$1" >&2
  exit 1
}

[ -f "$app_file" ] || fail "rhythm-memory-grid/index.html is missing"

grep -q '<title>节奏色块记忆 —— 双人合作音乐记忆挑战</title>' "$app_file" || fail "page title missing"
grep -q 'data-mode="solo"' "$app_file" || fail "solo mode button missing"
grep -q 'data-mode="coop"' "$app_file" || fail "co-op mode button missing"
grep -q '玩家 1 负责左侧 `A / S / D`' "$app_file" || fail "player 1 instructions missing"
grep -q '玩家 2 负责右侧 `J / K / L`' "$app_file" || fail "player 2 instructions missing"
grep -q 'const pads = \[' "$app_file" || fail "pad config missing"
grep -q 'window.AudioContext || window.webkitAudioContext' "$app_file" || fail "web audio setup missing"
grep -q 'performance.now()' "$app_file" || fail "timing source missing"
grep -q 'absDelta > 150' "$app_file" || fail "judgement window missing"
grep -q 'const grade = absDelta <= 60 ? "perfect" : "good";' "$app_file" || fail "perfect/good judgement missing"
grep -q 'function buildSequence(length, mode)' "$app_file" || fail "sequence generator missing"
grep -q 'async function playbackSequence(token)' "$app_file" || fail "sequence playback missing"
grep -q 'function judgeInput(padId)' "$app_file" || fail "input judge missing"
grep -q 'function finishRound()' "$app_file" || fail "round progression missing"
grep -q 'Perfect' "$app_file" || fail "perfect feedback copy missing"
grep -q 'Good' "$app_file" || fail "good feedback copy missing"
grep -q 'Miss' "$app_file" || fail "miss feedback copy missing"

printf 'rhythm memory grid smoke test passed\n'
