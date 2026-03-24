#!/usr/bin/env bash

set -euo pipefail

root_dir="$(cd "$(dirname "$0")/.." && pwd)"
app_file="$root_dir/hex-territory-duel/index.html"
index_file="$root_dir/index.html"

fail() {
  printf 'FAIL: %s\n' "$1" >&2
  exit 1
}

[ -f "$app_file" ] || fail "hex-territory-duel/index.html is missing"

grep -q '<svg id="hex-board"' "$app_file" || fail "svg board missing"
grep -q 'const BOARD_SIZES = {' "$app_file" || fail "board sizes config missing"
grep -q 'small: { rows: 7, cols: 7' "$app_file" || fail "small board size missing"
grep -q 'medium: { rows: 9, cols: 9' "$app_file" || fail "medium board size missing"
grep -q 'large: { rows: 11, cols: 11' "$app_file" || fail "large board size missing"
grep -q 'const MAX_PLACEMENTS = 10;' "$app_file" || fail "turn limit missing"
grep -q 'const CAPTURE_THRESHOLD = 3;' "$app_file" || fail "capture threshold missing"
grep -q 'function getNeighbors(row, col)' "$app_file" || fail "hex neighbor logic missing"
grep -q 'function captureByInfluence(player)' "$app_file" || fail "influence capture logic missing"
grep -q 'function applyPlacement(row, col)' "$app_file" || fail "placement handler missing"
grep -q 'influence' "$app_file" || fail "influence visualization copy missing"
grep -q 'id="size-select"' "$app_file" || fail "map size selector missing"
grep -q 'id="restart-button"' "$app_file" || fail "restart control missing"
grep -q '领地争夺棋' "$app_file" || fail "game title missing"

grep -q 'slug: "hex-territory-duel"' "$index_file" || fail "root index card missing"

printf 'hex territory duel smoke test passed\n'
