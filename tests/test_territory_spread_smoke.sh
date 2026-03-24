#!/usr/bin/env bash

set -euo pipefail

root_dir="$(cd "$(dirname "$0")/.." && pwd)"
app_file="$root_dir/territory-spread/index.html"
index_file="$root_dir/index.html"

fail() {
  printf 'FAIL: %s\n' "$1" >&2
  exit 1
}

[ -f "$app_file" ] || fail "territory-spread/index.html is missing"

grep -q '<canvas id="game-canvas"' "$app_file" || fail "canvas board missing"
grep -q 'const ROWS = 7;' "$app_file" || fail "row count missing"
grep -q 'const COLS = 7;' "$app_file" || fail "col count missing"
grep -q 'const WIN_RATIO = 0.6;' "$app_file" || fail "win ratio missing"
grep -q 'const SEED_TYPES = {' "$app_file" || fail "seed type config missing"
grep -q 'bomb: { label: "藤蔓炸弹", energyCost: 1 }' "$app_file" || fail "bomb seed config missing"
grep -q 'function getNeighbors(row, col)' "$app_file" || fail "hex neighbor logic missing"
grep -q 'function resolveGrowth()' "$app_file" || fail "growth resolution missing"
grep -q 'function evaluateGameState()' "$app_file" || fail "win detection missing"
grep -q 'function placeSeed(row, col)' "$app_file" || fail "placement handler missing"
grep -q '2 回合爆发 + 枯萎' "$app_file" || fail "bomb lifecycle copy missing"
grep -q '双人热座' "$app_file" || fail "hot-seat copy missing"
grep -q '占领比例' "$app_file" || fail "progress UI copy missing"

grep -q 'slug: "territory-spread"' "$index_file" || fail "root index card missing"

printf 'territory spread smoke test passed\n'
