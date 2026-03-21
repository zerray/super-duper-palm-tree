#!/usr/bin/env bash

set -euo pipefail

root_dir="$(cd "$(dirname "$0")/.." && pwd)"
app_file="$root_dir/hex-territory/index.html"

fail() {
  printf 'FAIL: %s\n' "$1" >&2
  exit 1
}

[ -f "$app_file" ] || fail "hex-territory/index.html is missing"

grep -q '<svg id="board"' "$app_file" || fail "svg board missing"
grep -q 'const BOARD_RADIUS = 6;' "$app_file" || fail "board radius missing"
grep -q 'function findClusterAndLiberties' "$app_file" || fail "capture flood fill missing"
grep -q 'function applyCaptures' "$app_file" || fail "capture application missing"
grep -q 'function chooseAiMove()' "$app_file" || fail "AI move picker missing"
grep -q 'captures === bestMove.captures && adjacency > bestMove.adjacency' "$app_file" || fail "greedy AI tiebreak missing"
grep -q 'window.setTimeout(takeAiTurn, AI_DELAY_MS)' "$app_file" || fail "AI delay missing"
grep -q 'Hex Territory Strategy' "$app_file" || fail "game title missing"
grep -q 'Create Room' "$app_file" || fail "online host control missing"
grep -q 'Join Room' "$app_file" || fail "online guest control missing"
grep -q 'peerjs@1.5.4' "$app_file" || fail "PeerJS client missing"
grep -q 'function serializeSnapshot' "$app_file" || fail "snapshot sync missing"
grep -q 'remote player' "$app_file" || fail "online rules copy missing"

printf 'hex territory smoke test passed\n'
