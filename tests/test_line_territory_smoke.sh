#!/usr/bin/env bash

set -euo pipefail

root_dir="$(cd "$(dirname "$0")/.." && pwd)"
app_file="$root_dir/line-territory/index.html"
index_file="$root_dir/index.html"

fail() {
  printf 'FAIL: %s\n' "$1" >&2
  exit 1
}

[ -f "$app_file" ] || fail "line-territory/index.html is missing"

grep -q '<canvas id="territory-canvas"' "$app_file" || fail "canvas missing"
grep -q 'const GRID_COLS = 60;' "$app_file" || fail "grid width missing"
grep -q 'const GRID_ROWS = 40;' "$app_file" || fail "grid height missing"
grep -q 'const ROUND_SECONDS = 90;' "$app_file" || fail "round timer missing"
grep -q 'const P1_TRAIL = 3;' "$app_file" || fail "player 1 trail state missing"
grep -q 'const P2_TRAIL = 4;' "$app_file" || fail "player 2 trail state missing"
grep -q 'function floodFillCapture(player)' "$app_file" || fail "flood fill capture missing"
grep -q 'function cancelTrail(player, reason)' "$app_file" || fail "trail cancel logic missing"
grep -q 'W / A / S / D' "$app_file" || fail "player 1 controls missing"
grep -q '↑ / ← / ↓ / →' "$app_file" || fail "player 2 controls missing"
grep -q '未闭合线段' "$app_file" || fail "trail failure rule text missing"
grep -q 'requestAnimationFrame(frame);' "$app_file" || fail "animation loop missing"

grep -q 'slug: "line-territory"' "$index_file" || fail "root index entry missing"

printf 'line territory smoke test passed\n'
