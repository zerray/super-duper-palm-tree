#!/usr/bin/env bash

set -euo pipefail

root_dir="$(cd "$(dirname "$0")/.." && pwd)"
game_file="$root_dir/snake-game/index.html"

fail() {
  printf 'FAIL: %s\n' "$1" >&2
  exit 1
}

[ -f "$game_file" ] || fail "snake-game/index.html is missing"

grep -q 'const LEADERBOARD_KEY = "snake-game-leaderboard"' "$game_file" || fail "leaderboard storage key missing"
grep -q 'window.localStorage' "$game_file" || fail "localStorage leaderboard support missing"
grep -q 'arrowup' "$game_file" || fail "keyboard controls missing"
grep -q 'id="score"' "$game_file" || fail "score display missing"
grep -q 'id="leaderboard-list"' "$game_file" || fail "leaderboard UI missing"

printf 'snake game smoke test passed\n'
