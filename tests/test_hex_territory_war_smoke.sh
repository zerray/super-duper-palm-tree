#!/usr/bin/env bash

set -euo pipefail

root_dir="$(cd "$(dirname "$0")/.." && pwd)"
app_file="$root_dir/hex-territory-war/index.html"
index_file="$root_dir/index.html"

fail() {
  printf 'FAIL: %s\n' "$1" >&2
  exit 1
}

[ -f "$app_file" ] || fail "hex-territory-war/index.html is missing"

grep -q '<title>六角领地争夺战</title>' "$app_file" || fail "title missing"
grep -q 'id="game-board"' "$app_file" || fail "canvas board missing"
grep -q 'const GRID_ROWS = 7;' "$app_file" || fail "grid rows missing"
grep -q 'const GRID_COLS = 7;' "$app_file" || fail "grid cols missing"
grep -q 'const RESOURCE_RATIO = 0.16;' "$app_file" || fail "resource ratio missing"
grep -q 'const WIN_THRESHOLD = 0.6;' "$app_file" || fail "win threshold missing"
grep -q 'function getNeighbors(row, col)' "$app_file" || fail "neighbor logic missing"
grep -q 'function resolveCombatChain()' "$app_file" || fail "combat chain missing"
grep -q 'function checkVictory()' "$app_file" || fail "victory check missing"
grep -q 'id="victory-overlay"' "$app_file" || fail "victory overlay missing"
grep -q '扩张' "$app_file" || fail "expand action text missing"
grep -q '强化' "$app_file" || fail "fortify action text missing"
grep -q '资源点' "$app_file" || fail "resource text missing"
grep -q '占领超过 60% 地图' "$app_file" || fail "victory rule copy missing"

grep -q 'slug: "hex-territory-war"' "$index_file" || fail "root index card missing"

printf 'hex territory war smoke test passed\n'
