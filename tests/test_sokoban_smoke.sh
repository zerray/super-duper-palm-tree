#!/usr/bin/env bash

set -euo pipefail

root_dir="$(cd "$(dirname "$0")/.." && pwd)"
app_file="$root_dir/sokoban-game/index.html"

fail() {
  printf 'FAIL: %s\n' "$1" >&2
  exit 1
}

[ -f "$app_file" ] || fail "sokoban-game/index.html is missing"

grep -q '<canvas id="game-canvas"' "$app_file" || fail "canvas missing"
grep -q 'const STORAGE_KEY = "sokoban-warehouse-state-v1";' "$app_file" || fail "storage key missing"
grep -q 'const levels = \[' "$app_file" || fail "level definitions missing"
grep -q 'movePlayer(dx, dy)' "$app_file" || fail "movement handler missing"
grep -q 'undoMove()' "$app_file" || fail "undo handler missing"
grep -q 'localStorage.setItem(STORAGE_KEY' "$app_file" || fail "localStorage persistence missing"
grep -q 'id="level-select"' "$app_file" || fail "level select missing"
grep -q 'data-move="0,-1"' "$app_file" || fail "touch controls missing"
grep -q 'Level complete. Use Next to continue.' "$app_file" || fail "success message missing"

printf 'sokoban smoke test passed\n'
