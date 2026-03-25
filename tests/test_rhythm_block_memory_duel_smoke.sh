#!/usr/bin/env bash

set -euo pipefail

root_dir="$(cd "$(dirname "$0")/.." && pwd)"
app_file="$root_dir/rhythm-block-memory-duel/index.html"
index_file="$root_dir/index.html"

fail() {
  printf 'FAIL: %s\n' "$1" >&2
  exit 1
}

[ -f "$app_file" ] || fail "rhythm-block-memory-duel/index.html is missing"
[ -f "$index_file" ] || fail "index.html is missing"

grep -q '<title>节奏色块记忆：回合制双人派对游戏</title>' "$app_file" || fail "title missing"
grep -q 'data-mode="solo"' "$app_file" || fail "solo mode button missing"
grep -q 'data-mode="duel"' "$app_file" || fail "duel mode button missing"
grep -q '数字键 `1-6`' "$app_file" || fail "keyboard instructions missing"
grep -q 'const PAD_LIBRARY = \[' "$app_file" || fail "pad library missing"
grep -q 'window.AudioContext || window.webkitAudioContext' "$app_file" || fail "web audio setup missing"
grep -q 'const TARGET_SCORE = 5;' "$app_file" || fail "target score missing"
grep -q 'const BASE_SHOW_MS = 680;' "$app_file" || fail "base show timing missing"
grep -q 'const MIN_SHOW_MS = 260;' "$app_file" || fail "minimum show timing missing"
grep -q 'function appendRandomPad()' "$app_file" || fail "sequence growth missing"
grep -q 'async function playbackSequence(runId)' "$app_file" || fail "playback flow missing"
grep -q 'async function handlePadInput(padId)' "$app_file" || fail "pad input handler missing"
grep -q 'function finishSoloGame()' "$app_file" || fail "solo finish flow missing"
grep -q 'function finishDuelGame(winnerIndex)' "$app_file" || fail "duel finish flow missing"
grep -q 'window.localStorage.setItem(STORAGE_KEY, String(state.soloBest))' "$app_file" || fail "solo best persistence missing"
grep -q 'slug: "rhythm-block-memory-duel"' "$index_file" || fail "root index entry missing"
grep -q '节奏色块记忆：回合制双人派对游戏' "$index_file" || fail "root index title missing"

printf 'rhythm block memory duel smoke test passed\n'
