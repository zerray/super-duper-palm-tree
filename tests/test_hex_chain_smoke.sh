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
grep -q 'const GRID_ROWS = 7;' "$app_file" || fail "grid rows missing"
grep -q 'const GRID_COLS = 7;' "$app_file" || fail "grid cols missing"
grep -q '<svg id="board"' "$app_file" || fail "svg board missing"
grep -q 'function getChain(board, startQ, startR, color, owner)' "$app_file" || fail "chain flood fill missing"
grep -q 'function getChainScore(chainLength)' "$app_file" || fail "chain scoring helper missing"
grep -q 'return 2 \*\* Math.max(0, chainLength - 1);' "$app_file" || fail "exponential scoring missing"
grep -q 'function chooseAiMove()' "$app_file" || fail "AI heuristic missing"
grep -q 'blockScore' "$app_file" || fail "AI blocking tiebreak missing"
grep -q 'window.setTimeout(takeAiTurn, AI_DELAY_MS);' "$app_file" || fail "AI turn scheduling missing"
grep -q 'Board Full' "$app_file" || fail "game over overlay missing"
grep -q 'New Game' "$app_file" || fail "restart control missing"
grep -q 'Pick Color' "$app_file" || fail "color picker missing"

printf 'hex chain smoke test passed\n'
