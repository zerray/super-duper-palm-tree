#!/usr/bin/env bash

set -euo pipefail

root_dir="$(cd "$(dirname "$0")/.." && pwd)"
app_file="$root_dir/rhythm-color-battle/index.html"
index_file="$root_dir/index.html"

fail() {
  printf 'FAIL: %s\n' "$1" >&2
  exit 1
}

[ -f "$app_file" ] || fail "rhythm-color-battle/index.html is missing"
[ -f "$index_file" ] || fail "index.html is missing"

grep -q '<title>节奏染色战</title>' "$app_file" || fail "title missing"
grep -q 'grid-template-columns: repeat(6, minmax(0, 1fr));' "$app_file" || fail "6x6 board missing"
grep -q 'const BOARD_SIZE = 6;' "$app_file" || fail "board size missing"
grep -q 'const PALETTE = \[' "$app_file" || fail "palette config missing"
grep -q 'Math.random() < 0.5 ? 5 : 6' "$app_file" || fail "5-6 color randomization missing"
grep -Fq 'cells[0][0].owner = 1;' "$app_file" || fail "player 1 start missing"
grep -Fq 'cells[BOARD_SIZE - 1][BOARD_SIZE - 1].owner = 2;' "$app_file" || fail "player 2 start missing"
grep -q 'function getNeighbors(row, col)' "$app_file" || fail "neighbor logic missing"
grep -q 'function buildAnimationPhases(player, color)' "$app_file" || fail "animation phase logic missing"
grep -q 'function finishGame()' "$app_file" || fail "finish game missing"
grep -q '禁止选择对手当前正在使用的颜色' "$app_file" || fail "rule copy missing"
grep -q '玩家 1 从左上角开始，玩家 2 从右下角开始' "$app_file" || fail "start corner copy missing"
grep -q '再来一局' "$app_file" || fail "restart button missing"
grep -q 'rhythm-color-battle' "$index_file" || fail "root index entry missing"
grep -q '节奏染色战' "$index_file" || fail "root index title missing"

printf 'rhythm color battle smoke test passed\n'
