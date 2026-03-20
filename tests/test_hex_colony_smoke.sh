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
grep -q 'const TARGET_TERRITORY = 50;' "$app_file" || fail "win target missing"
grep -q 'const BLIGHT_INTERVAL = 3;' "$app_file" || fail "blight interval missing"
grep -q 'farm: { label: "Farm", cost: 2' "$app_file" || fail "farm cost missing"
grep -q 'tower: { label: "Tower", cost: 3' "$app_file" || fail "tower cost missing"
grep -q 'wall: { label: "Wall", cost: 1' "$app_file" || fail "wall cost missing"
grep -q 'function resolveTowers()' "$app_file" || fail "tower resolution missing"
grep -q 'cell.timer < 2' "$app_file" || fail "tower timer missing"
grep -q 'function spreadBlight()' "$app_file" || fail "blight spread missing"
grep -q 'if (neighbor.structure === "wall")' "$app_file" || fail "wall blocking missing"
grep -q 'The blight reached the settlement' "$app_file" || fail "lose state missing"
grep -q 'You claimed 50 hexes' "$app_file" || fail "win state missing"
grep -q 'Gold <strong id="goldValue">' "$app_file" || fail "gold hud missing"
grep -q 'Turn <strong id="turnValue">' "$app_file" || fail "turn hud missing"

printf 'hex colony smoke test passed\n'
