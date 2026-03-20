#!/usr/bin/env bash

set -euo pipefail

root_dir="$(cd "$(dirname "$0")/.." && pwd)"
app_file="$root_dir/wfc-painter/index.html"

fail() {
  printf 'FAIL: %s\n' "$1" >&2
  exit 1
}

[ -f "$app_file" ] || fail "wfc-painter/index.html is missing"

grep -q '<canvas id="wfc-canvas"' "$app_file" || fail "canvas element missing"
grep -q 'Wave Function Collapse Painter' "$app_file" || fail "title missing"
grep -q 'id="tileset-select"' "$app_file" || fail "tileset selector missing"
grep -q 'id="grid-size-select"' "$app_file" || fail "grid size selector missing"
grep -q 'id="speed-slider"' "$app_file" || fail "speed slider missing"
grep -q 'id="pin-tile-select"' "$app_file" || fail "pin tile selector missing"
grep -q 'id="restart-button"' "$app_file" || fail "restart button missing"
grep -q 'id="export-button"' "$app_file" || fail "export button missing"
grep -q 'Contradiction detected, restarting' "$app_file" || fail "contradiction handling missing"
grep -q 'canvas.toDataURL("image/png")' "$app_file" || fail "PNG export missing"
grep -q 'Pipes' "$app_file" || fail "pipes tileset missing"
grep -q 'Circuits' "$app_file" || fail "circuits tileset missing"
grep -q 'function propagate' "$app_file" || fail "propagation function missing"
grep -q 'function collapseOne' "$app_file" || fail "collapse step missing"

printf 'wfc painter smoke test passed\n'
