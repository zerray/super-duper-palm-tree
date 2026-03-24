#!/usr/bin/env bash

set -euo pipefail

root_dir="$(cd "$(dirname "$0")/.." && pwd)"
app_file="$root_dir/number-territory/index.html"
index_file="$root_dir/index.html"

fail() {
  printf 'FAIL: %s\n' "$1" >&2
  exit 1
}

[ -f "$app_file" ] || fail "number-territory/index.html is missing"

grep -q '<title>数字领地争夺战</title>' "$app_file" || fail "title missing"
grep -q '<svg id="hex-board"' "$app_file" || fail "svg board missing"
grep -q 'id="turn-label"' "$app_file" || fail "turn label missing"
grep -q 'id="score-p1"' "$app_file" || fail "player 1 score missing"
grep -q 'id="score-p2"' "$app_file" || fail "player 2 score missing"
grep -q 'id="result-overlay"' "$app_file" || fail "result overlay missing"
grep -q 'id="restart-button"' "$app_file" || fail "restart button missing"
grep -q 'const ROWS = 5;' "$app_file" || fail "row config missing"
grep -q 'const COLS = 7;' "$app_file" || fail "col config missing"
grep -q 'const MIN_TOTAL_CELLS = 30;' "$app_file" || fail "minimum cell config missing"
grep -q 'function getNeighbors(row, col)' "$app_file" || fail "neighbor function missing"
grep -q 'function computeFrontier(player)' "$app_file" || fail "frontier logic missing"
grep -q 'function claimCell(row, col)' "$app_file" || fail "claim logic missing"
grep -q 'function advanceTurn()' "$app_file" || fail "turn advance missing"
grep -q 'function finishGame()' "$app_file" || fail "finish logic missing"
grep -q '数字领地争夺战' "$app_file" || fail "game title copy missing"
grep -q '只能占领与自己领地相邻，且数值 ≤ 当前总兵力的空格' "$app_file" || fail "rules summary missing"
grep -q '自动跳过。继续由玩家' "$app_file" || fail "turn skip copy missing"

grep -q 'slug: "number-territory"' "$index_file" || fail "root index card missing"

printf 'number territory smoke test passed\n'
