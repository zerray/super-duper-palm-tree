#!/usr/bin/env bash

set -euo pipefail

root_dir="$(cd "$(dirname "$0")/.." && pwd)"
app_file="$root_dir/hex-chain/index.html"

fail() {
  printf 'FAIL: %s\n' "$1" >&2
  exit 1
}

[ -f "$app_file" ] || fail "hex-chain/index.html is missing"

grep -q 'Hex Chain' "$app_file" || fail "title missing"
grep -q '<svg id="board"' "$app_file" || fail "svg board missing"
grep -q 'const BOARD_ROWS = 7;' "$app_file" || fail "board rows missing"
grep -q 'const BOARD_COLS = 7;' "$app_file" || fail "board cols missing"
grep -q 'const COLORS = \[' "$app_file" || fail "color list missing"
grep -q 'function getChain(board, q, r)' "$app_file" || fail "chain flood fill missing"
grep -q 'function getChainScore(chainLength)' "$app_file" || fail "chain scoring missing"
grep -q 'function chooseAiMove()' "$app_file" || fail "AI move picker missing"
grep -q 'move.playerBestReply < bestMove.playerBestReply' "$app_file" || fail "AI blocking tiebreak missing"
grep -q 'window.setTimeout(() => {' "$app_file" || fail "AI turn delay missing"
grep -q 'New Game' "$app_file" || fail "restart control missing"
grep -qi 'board full after' "$app_file" || fail "game-over summary missing"

printf 'hex chain smoke test passed\n'
