#!/usr/bin/env bash

set -euo pipefail

root_dir="$(cd "$(dirname "$0")/.." && pwd)"
game_file="$root_dir/sokoban-game/index.html"

fail() {
  printf 'FAIL: %s\n' "$1" >&2
  exit 1
}

[ -f "$game_file" ] || fail "sokoban-game/index.html is missing"

grep -q '<canvas id="game"' "$game_file" || fail "canvas element missing"
grep -q 'const STORAGE_KEY = "sokoban-browser-save"' "$game_file" || fail "storage key missing"
grep -q 'window.localStorage' "$game_file" || fail "localStorage persistence missing"
grep -q 'const levels = \[' "$game_file" || fail "level definitions missing"
grep -q 'name: "Level 10"' "$game_file" || fail "ten levels not defined"
grep -q 'function undoMove' "$game_file" || fail "undo support missing"
grep -q 'data-move="up"' "$game_file" || fail "mobile controls missing"

printf 'sokoban smoke test passed\n'
