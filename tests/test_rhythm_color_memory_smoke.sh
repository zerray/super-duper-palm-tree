#!/usr/bin/env bash

set -euo pipefail

root_dir="$(cd "$(dirname "$0")/.." && pwd)"
app_file="$root_dir/rhythm-color-memory/index.html"
index_file="$root_dir/index.html"

fail() {
  printf 'FAIL: %s\n' "$1" >&2
  exit 1
}

[ -f "$app_file" ] || fail "rhythm-color-memory/index.html is missing"
[ -f "$index_file" ] || fail "index.html is missing"

grep -q '<title>节奏色块记忆挑战</title>' "$app_file" || fail "title missing"
grep -q 'grid-template-columns: repeat(4, minmax(0, 1fr));' "$app_file" || fail "4x4 grid missing"
grep -q 'const GRID_SIZE = 16;' "$app_file" || fail "grid size constant missing"
grep -q 'const START_LENGTH = 3;' "$app_file" || fail "start length missing"
grep -q 'const BEAT_MS = 520;' "$app_file" || fail "beat timing missing"
grep -q 'window.AudioContext || window.webkitAudioContext' "$app_file" || fail "web audio setup missing"
grep -q 'function mulberry32(seed)' "$app_file" || fail "seeded rng missing"
grep -q 'function buildSequence(seed, length)' "$app_file" || fail "sequence builder missing"
grep -q 'async function playbackSequence()' "$app_file" || fail "sequence playback missing"
grep -q 'async function handlePadInput(padIndex)' "$app_file" || fail "input handler missing"
grep -q '热座双人使用同一种子生成同一套随机序列' "$app_file" || fail "hot-seat rule copy missing"
grep -q '最高记录排行' "$app_file" || fail "leaderboard missing"
grep -q 'window.localStorage.setItem(STORAGE_KEY, JSON.stringify(state.leaderboard))' "$app_file" || fail "leaderboard persistence missing"
grep -q 'slug: "rhythm-color-memory"' "$index_file" || fail "root index entry missing"

printf 'rhythm color memory smoke test passed\n'
