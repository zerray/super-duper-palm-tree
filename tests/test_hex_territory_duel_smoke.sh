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

grep -q '<title>领地争夺：双人策略涂色</title>' "$app_file" || fail "title missing"
grep -q '<svg id="hex-board"' "$app_file" || fail "svg board missing"
grep -q 'const ROWS = 7;' "$app_file" || fail "row config missing"
grep -q 'const COLS = 7;' "$app_file" || fail "col config missing"
grep -q 'const SPECIAL_TILE_RATIO = 0.15;' "$app_file" || fail "special tile ratio missing"
grep -q 'function computeLegalMoves' "$app_file" || fail "legal move logic missing"
grep -q 'function clearBombRing' "$app_file" || fail "bomb logic missing"
grep -q 'function applyPortal' "$app_file" || fail "portal logic missing"
grep -q 'function pickAiMove' "$app_file" || fail "ai logic missing"
grep -q 'function finishGame' "$app_file" || fail "endgame logic missing"
grep -q 'id="restart-button"' "$app_file" || fail "restart button missing"
grep -q 'id="randomize-button"' "$app_file" || fail "randomize button missing"
grep -q 'id="ai-toggle"' "$app_file" || fail "ai toggle missing"
grep -q 'id="result-overlay"' "$app_file" || fail "result overlay missing"
grep -q '领地争夺：双人策略涂色' "$app_file" || fail "game title copy missing"
grep -q '💣 炸弹格' "$app_file" || fail "bomb tile copy missing"
grep -q '🌀 传送门' "$app_file" || fail "portal tile copy missing"
grep -q '双人热座回合制六边形扩张' "$app_file" || fail "rules summary missing"

grep -q 'slug: "hex-territory-duel"' "$index_file" || fail "root index card missing"

printf 'hex territory duel smoke test passed\n'
