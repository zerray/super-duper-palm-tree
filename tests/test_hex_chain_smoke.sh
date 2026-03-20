#!/usr/bin/env bash

set -euo pipefail

root_dir="$(cd "$(dirname "$0")/.." && pwd)"
app_file="$root_dir/hex-chain/index.html"

fail() {
  printf 'FAIL: %s\n' "$1" >&2
  exit 1
}

[ -f "$app_file" ] || fail "hex-chain/index.html is missing"

grep -q '<svg id="board"' "$app_file" || fail "svg board missing"
grep -q 'const GRID_SIZE = 7;' "$app_file" || fail "grid size missing"
grep -q 'function getChain' "$app_file" || fail "chain detection missing"
grep -q 'return Math.pow(2, Math.max(chainLength - 1, 0));' "$app_file" || fail "exponential scoring missing"
grep -q 'function chooseAiMove()' "$app_file" || fail "AI move picker missing"
grep -q 'move.score === bestMove.score && move.blockScore > bestMove.blockScore' "$app_file" || fail "AI block tiebreak missing"
grep -q 'window.setTimeout(takeAiTurn, AI_DELAY_MS)' "$app_file" || fail "AI delay missing"
grep -q 'New Game' "$app_file" || fail "restart UI missing"
grep -q 'Hex Chain' "$app_file" || fail "title missing"

printf 'hex chain smoke test passed\n'
