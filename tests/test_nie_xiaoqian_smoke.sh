#!/usr/bin/env bash

set -euo pipefail

root_dir="$(cd "$(dirname "$0")/.." && pwd)"
game_file="$root_dir/nie-xiaoqian-rpg/index.html"

fail() {
  printf 'FAIL: %s\n' "$1" >&2
  exit 1
}

[ -f "$game_file" ] || fail "nie-xiaoqian-rpg/index.html is missing"

grep -q '<canvas id="game"' "$game_file" || fail "canvas element missing"
grep -q 'const maps =' "$game_file" || fail "map data missing"
grep -q 'const battleDefs =' "$game_file" || fail "battle system missing"
grep -q 'function beginDialogue' "$game_file" || fail "dialogue system missing"
grep -q '开始游戏' "$game_file" || fail "title screen text missing"

printf 'nie xiaoqian smoke test passed\n'
