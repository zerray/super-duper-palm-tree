#!/usr/bin/env bash

set -euo pipefail

root_dir="$(cd "$(dirname "$0")/.." && pwd)"
app_file="$root_dir/rhythm-color-memory-party/index.html"
index_file="$root_dir/index.html"

fail() {
  printf 'FAIL: %s\n' "$1" >&2
  exit 1
}

[ -f "$app_file" ] || fail "rhythm-color-memory-party/index.html is missing"
[ -f "$index_file" ] || fail "index.html is missing"

grep -q '<title>节奏色块记忆派对</title>' "$app_file" || fail "title missing"
grep -q 'grid-template-columns: repeat(4, minmax(0, 1fr));' "$app_file" || fail "4x4 grid missing"
grep -q 'const GRID_SIZE = 16;' "$app_file" || fail "grid size constant missing"
grep -q 'const START_LENGTH = 3;' "$app_file" || fail "start length missing"
grep -q 'const MAX_PLAYERS = 4;' "$app_file" || fail "max player constant missing"
grep -q 'const BEAT_MS = 620;' "$app_file" || fail "beat timing missing"
grep -q 'const STORAGE_KEY = "rhythm-color-memory-party-best";' "$app_file" || fail "storage key missing"
grep -q 'window.AudioContext || window.webkitAudioContext' "$app_file" || fail "web audio setup missing"
grep -q 'async function playbackSequence()' "$app_file" || fail "playback function missing"
grep -q 'async function handlePadInput(padIndex)' "$app_file" || fail "input handler missing"
grep -q 'async function advanceTurn()' "$app_file" || fail "turn advance flow missing"
grep -q 'await showOverlayMessage(`${player.name} 的回合`' "$app_file" || fail "turn transition overlay missing"
grep -q 'player.alive = false;' "$app_file" || fail "elimination logic missing"
grep -q 'window.localStorage.setItem(STORAGE_KEY, String(state.soloBest))' "$app_file" || fail "solo best persistence missing"
grep -q '4x4 色块会按固定节拍依次点亮' "$app_file" || fail "hero copy missing"
grep -q 'slug: "rhythm-color-memory-party"' "$index_file" || fail "root index entry missing"
grep -q '节奏色块记忆派对' "$index_file" || fail "root index title missing"

printf 'rhythm color memory party smoke test passed\n'
