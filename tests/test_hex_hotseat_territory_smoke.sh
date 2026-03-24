#!/usr/bin/env bash

set -euo pipefail

root_dir="$(cd "$(dirname "$0")/.." && pwd)"
app_file="$root_dir/hex-hotseat-territory/index.html"
index_file="$root_dir/index.html"

fail() {
  printf 'FAIL: %s\n' "$1" >&2
  exit 1
}

[ -f "$app_file" ] || fail "hex-hotseat-territory/index.html is missing"

grep -q '<title>领地争夺 - 热座回合制策略</title>' "$app_file" || fail "title missing"
grep -q '<svg id="hex-board"' "$app_file" || fail "svg board missing"
grep -q 'id="round-label"' "$app_file" || fail "round label missing"
grep -q 'id="player-label"' "$app_file" || fail "player label missing"
grep -q 'id="action-label"' "$app_file" || fail "action label missing"
grep -q 'id="score-p1"' "$app_file" || fail "p1 score missing"
grep -q 'id="score-p2"' "$app_file" || fail "p2 score missing"
grep -q 'id="result-overlay"' "$app_file" || fail "result overlay missing"
grep -q 'const GRID_ROWS = 6;' "$app_file" || fail "grid rows missing"
grep -q 'const GRID_COLS = 8;' "$app_file" || fail "grid cols missing"
grep -q 'const MAX_ROUNDS = 30;' "$app_file" || fail "max rounds missing"
grep -q 'const MIN_RESOURCES = 3;' "$app_file" || fail "min resources missing"
grep -q 'const MAX_RESOURCES = 5;' "$app_file" || fail "max resources missing"
grep -q 'function getNeighbors(row, col)' "$app_file" || fail "neighbor logic missing"
grep -q 'function placeResources()' "$app_file" || fail "resource placement missing"
grep -q 'function resolveBattle(cell)' "$app_file" || fail "battle logic missing"
grep -q 'function endTurn()' "$app_file" || fail "turn switching missing"
grep -q 'function finishGame()' "$app_file" || fail "game end missing"
grep -q '资源点每回合额外提供 1 次行动' "$app_file" || fail "resource rule copy missing"
grep -q '30 回合结束后按占领格数判定胜负' "$app_file" || fail "round win rule copy missing"

grep -q 'slug: "hex-hotseat-territory"' "$index_file" || fail "root index card missing"

printf 'hex hotseat territory smoke test passed\n'
