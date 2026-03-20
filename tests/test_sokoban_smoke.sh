#!/usr/bin/env bash

set -euo pipefail

root_dir="$(cd "$(dirname "$0")/.." && pwd)"
app_file="$root_dir/sokoban-game/index.html"

fail() {
  printf 'FAIL: %s\n' "$1" >&2
  exit 1
}

[ -f "$app_file" ] || fail "sokoban-game/index.html is missing"

level_count="$(grep -c 'name: "' "$app_file" || true)"
[ "$level_count" -ge 10 ] || fail "expected at least 10 level definitions"
grep -q '<canvas id="game-canvas"' "$app_file" || fail "canvas element missing"
grep -q 'const LEVELS = \[' "$app_file" || fail "level array missing"
grep -q 'window.localStorage' "$app_file" || fail "localStorage persistence missing"
grep -q 'function tryMove' "$app_file" || fail "movement logic missing"
grep -q 'function undoMove' "$app_file" || fail "undo logic missing"
grep -q 'id="undo-button"' "$app_file" || fail "undo button missing"
grep -q 'id="level-grid"' "$app_file" || fail "level select UI missing"
grep -q 'WASD' "$app_file" || fail "WASD hint missing"

printf 'sokoban smoke test passed\n'
