#!/usr/bin/env bash

set -euo pipefail

root_dir="$(cd "$(dirname "$0")/.." && pwd)"
app_file="$root_dir/hex-colony/index.html"

fail() {
  printf 'FAIL: %s\n' "$1" >&2
  exit 1
}

[ -f "$app_file" ] || fail "hex-colony/index.html is missing"

grep -q '<svg id="board"' "$app_file" || fail "svg board missing"
grep -q 'const BOARD_RADIUS = 7;' "$app_file" || fail "board radius missing"
grep -q 'const TARGET_TERRITORY = 50;' "$app_file" || fail "win condition missing"
grep -q 'const BLIGHT_INTERVAL = 3;' "$app_file" || fail "blight interval missing"
grep -q 'const TILE_COSTS = { farm: 2, tower: 3, wall: 1 };' "$app_file" || fail "tile costs missing"
grep -q 'function processTowerClaims()' "$app_file" || fail "tower claim logic missing"
grep -q 'function spreadBlight()' "$app_file" || fail "blight spread logic missing"
grep -q 'function placeSelectedTile(targetKey)' "$app_file" || fail "tile placement logic missing"
grep -q 'Farms earn 1 gold at the end of every turn.' "$app_file" || fail "farm rule text missing"
grep -q 'Reach 50 controlled hexes before blight reaches home.' "$app_file" || fail "goal text missing"

printf 'hex colony smoke test passed\n'
