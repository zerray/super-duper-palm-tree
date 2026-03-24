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

grep -q '<title>双人领地争夺棋</title>' "$app_file" || fail "title missing"
grep -q '<svg id="hex-board"' "$app_file" || fail "svg board missing"
grep -q 'const HEX_DIRECTIONS = \[' "$app_file" || fail "hex direction config missing"
grep -q 'const BOARD_RADIUS = 4;' "$app_file" || fail "board radius missing"
grep -q 'const SPECIAL_TILE_INFO = {' "$app_file" || fail "special tile config missing"
grep -q 'function collectDirectionalFlips' "$app_file" || fail "flip scan logic missing"
grep -q 'function getMoveData' "$app_file" || fail "legal move logic missing"
grep -q 'function tryPortalTeleport' "$app_file" || fail "portal logic missing"
grep -q 'function applyBoosterFlip' "$app_file" || fail "booster logic missing"
grep -q 'function finishIfNeeded' "$app_file" || fail "endgame logic missing"
grep -q 'id="restart-button"' "$app_file" || fail "restart button missing"
grep -q 'id="randomize-button"' "$app_file" || fail "randomize button missing"
grep -q 'id="result-overlay"' "$app_file" || fail "result overlay missing"
grep -q '双人领地争夺棋' "$app_file" || fail "game title copy missing"
grep -q '倍增格' "$app_file" || fail "booster tile copy missing"
grep -q '屏障格' "$app_file" || fail "barrier tile copy missing"
grep -q '传送格' "$app_file" || fail "portal tile copy missing"

grep -q 'slug: "hex-territory-duel"' "$index_file" || fail "root index card missing"

printf 'hex territory duel smoke test passed\n'
