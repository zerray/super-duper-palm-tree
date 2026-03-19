#!/usr/bin/env bash

set -euo pipefail

root_dir="$(cd "$(dirname "$0")/.." && pwd)"
game_file="$root_dir/nie-xiaoqian-rpg/index.html"

fail() {
  printf 'FAIL: %s\n' "$1" >&2
  exit 1
}

[ -f "$game_file" ] || fail "nie-xiaoqian-rpg/index.html is missing"

grep -q '<canvas id="game"' "$game_file" || fail "game canvas missing"
grep -q '开始游戏' "$game_file" || fail "start button text missing"
grep -q 'js/map.js' "$game_file" || fail "map module reference missing"
grep -q 'js/dialogue.js' "$game_file" || fail "dialogue module reference missing"
grep -q 'js/battle.js' "$game_file" || fail "battle module reference missing"
grep -q 'js/engine.js' "$game_file" || fail "engine module reference missing"

printf 'nie xiao qian smoke test passed\n'
