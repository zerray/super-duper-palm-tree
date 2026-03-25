#!/usr/bin/env bash

set -euo pipefail

root_dir="$(cd "$(dirname "$0")/.." && pwd)"
app_file="$root_dir/territory-duel/index.html"
index_file="$root_dir/index.html"

fail() {
  printf 'FAIL: %s\n' "$1" >&2
  exit 1
}

[ -f "$app_file" ] || fail "territory-duel/index.html is missing"

grep -q '<title>画地为牢：双人领地争夺战</title>' "$app_file" || fail "title missing"
grep -q '<canvas id="game-canvas"' "$app_file" || fail "canvas missing"
grep -q 'const ROWS = 22;' "$app_file" || fail "row config missing"
grep -q 'const COLS = 30;' "$app_file" || fail "col config missing"
grep -q 'const GAME_DURATION = 60;' "$app_file" || fail "game duration missing"
grep -q 'const KEY_BINDINGS = {' "$app_file" || fail "key bindings missing"
grep -q 'ArrowUp' "$app_file" || fail "arrow key binding missing"
grep -q 'function fillCapturedArea' "$app_file" || fail "capture fill logic missing"
grep -q 'function floodFromEdges' "$app_file" || fail "flood fill helper missing"
grep -q 'function killPlayer' "$app_file" || fail "kill logic missing"
grep -q 'function updateAi' "$app_file" || fail "ai logic missing"
grep -q 'function finishGame' "$app_file" || fail "finish logic missing"
grep -q 'requestAnimationFrame(frame)' "$app_file" || fail "animation loop missing"
grep -q 'id="ai-toggle"' "$app_file" || fail "ai toggle missing"
grep -q '启用单人 vs 简单 AI' "$app_file" || fail "ai copy missing"
grep -q 'WASD' "$app_file" || fail "player 1 controls copy missing"
grep -q '方向键' "$app_file" || fail "player 2 controls copy missing"

grep -q 'slug: "territory-duel"' "$index_file" || fail "root index card missing"

printf 'territory duel smoke test passed\n'
