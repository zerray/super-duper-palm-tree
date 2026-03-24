#!/usr/bin/env bash

set -euo pipefail

root_dir="$(cd "$(dirname "$0")/.." && pwd)"
app_file="$root_dir/ink-territory/index.html"
index_file="$root_dir/index.html"

fail() {
  printf 'FAIL: %s\n' "$1" >&2
  exit 1
}

[ -f "$app_file" ] || fail "ink-territory/index.html is missing"

grep -q 'const BOARD_SIZE = 8;' "$app_file" || fail "board size missing"
grep -q 'const MAX_TURNS = 20;' "$app_file" || fail "max turns missing"
grep -q 'const SHAPE_OFFER_COUNT = 3;' "$app_file" || fail "shape offer count missing"
grep -q 'const GOLD_CELL_MIN = 4;' "$app_file" || fail "gold cell min missing"
grep -q 'const GOLD_CELL_MAX = 6;' "$app_file" || fail "gold cell max missing"
grep -q 'function getSpreadTargets' "$app_file" || fail "spread logic missing"
grep -q 'function undoLastTurn' "$app_file" || fail "undo logic missing"
grep -q 'function showGameOver' "$app_file" || fail "game over logic missing"
grep -q 'BFS ink spread' "$app_file" || fail "rules text missing"
grep -q '悔棋' "$app_file" || fail "undo button text missing"
grep -q '再来一局' "$app_file" || fail "restart button text missing"
grep -q 'id="board"' "$app_file" || fail "board element missing"

grep -q 'slug: "ink-territory"' "$index_file" || fail "root index entry missing"

printf 'ink territory smoke test passed\n'
