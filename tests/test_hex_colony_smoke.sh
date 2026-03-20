#!/usr/bin/env bash

set -euo pipefail

root_dir="$(cd "$(dirname "$0")/.." && pwd)"
app_file="$root_dir/hex-colony/index.html"

fail() {
  printf 'FAIL: %s\n' "$1" >&2
  exit 1
}

[ -f "$app_file" ] || fail "hex-colony/index.html is missing"

grep -qi '<html' "$app_file" || fail "html tag missing"
grep -qi '</html>' "$app_file" || fail "closing html tag missing"
grep -q '<svg id="board"' "$app_file" || fail "svg board missing"
grep -q 'const BOARD_RADIUS = 4;' "$app_file" || fail "board radius missing"
grep -q 'const MAX_PLACEMENTS = 18;' "$app_file" || fail "placement limit missing"
grep -q 'const TARGET_SCORE = 48;' "$app_file" || fail "target score missing"
grep -q 'const TILE_LIBRARY = {' "$app_file" || fail "tile library missing"
grep -q 'forest:' "$app_file" || fail "forest tile missing"
grep -q 'farm:' "$app_file" || fail "farm tile missing"
grep -q 'village:' "$app_file" || fail "village tile missing"
grep -q 'mine:' "$app_file" || fail "mine tile missing"
grep -q 'lake:' "$app_file" || fail "lake tile missing"
grep -q 'const SYNERGY_RULES = {' "$app_file" || fail "synergy rules missing"
grep -q 'function calculatePlacement(type, targetKey)' "$app_file" || fail "adjacency scoring missing"
grep -q 'function placeTile(targetKey)' "$app_file" || fail "tile placement missing"
grep -q 'function finishGame()' "$app_file" || fail "end game logic missing"
grep -qi 'new game' "$app_file" || fail "new game text missing"
grep -qi 'score' "$app_file" || fail "score text missing"
grep -qi 'highlighted frontier' "$app_file" || fail "placement guidance missing"

printf 'hex colony smoke test passed\n'
