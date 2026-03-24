#!/usr/bin/env bash

set -euo pipefail

root_dir="$(cd "$(dirname "$0")/.." && pwd)"
app_file="$root_dir/hex-territory-push/index.html"
index_file="$root_dir/index.html"

fail() {
  printf 'FAIL: %s\n' "$1" >&2
  exit 1
}

[ -f "$app_file" ] || fail "hex-territory-push/index.html is missing"

grep -q '<title>领地推进</title>' "$app_file" || fail "title missing"
grep -q 'const ROWS = 7;' "$app_file" || fail "row count missing"
grep -q 'const COLS = 7;' "$app_file" || fail "column count missing"
grep -q 'const PRESSURE_TO_FLIP = 3;' "$app_file" || fail "pressure threshold missing"
grep -q 'const ODD_R_DIRECTIONS = {' "$app_file" || fail "hex neighbor config missing"
grep -q 'function generateFortressLayout' "$app_file" || fail "fortress generation missing"
grep -q 'function getLegalMoves' "$app_file" || fail "legal move logic missing"
grep -q 'async function resolvePressureQueue' "$app_file" || fail "chain pressure logic missing"
grep -q 'async function applyFortressPressure' "$app_file" || fail "fortress auto-pressure missing"
grep -q 'function maybeFinishOrPass' "$app_file" || fail "endgame or pass logic missing"
grep -q 'id="turnBanner"' "$app_file" || fail "turn indicator missing"
grep -q 'id="resultOverlay"' "$app_file" || fail "result overlay missing"
grep -q '重新开局' "$app_file" || fail "restart control missing"
grep -q '地图重生' "$app_file" || fail "new map control missing"
grep -q '双人热座六角格占领对抗' "$app_file" || fail "game description missing"

grep -q 'slug: "hex-territory-push"' "$index_file" || fail "root index card missing"

printf 'hex territory push smoke test passed\n'
