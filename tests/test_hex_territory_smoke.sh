#!/usr/bin/env bash

set -euo pipefail

root_dir="$(cd "$(dirname "$0")/.." && pwd)"
game_file="$root_dir/hex-territory/index.html"

fail() {
  printf 'FAIL: %s\n' "$1" >&2
  exit 1
}

[ -f "$game_file" ] || fail "hex-territory/index.html is missing"

grep -q 'Hex Territory' "$game_file" || fail "title missing"
grep -q 'const CONFIG = {' "$game_file" || fail "config missing"
grep -q 'cols: 7' "$game_file" || fail "default grid size missing"
grep -q 'svg id="board"' "$game_file" || fail "SVG board missing"
grep -q 'function runAiTurn()' "$game_file" || fail "AI turn logic missing"
grep -q 'Adjacent claims are free' "$game_file" || fail "move rule copy missing"
grep -q 'Player Territory' "$game_file" || fail "territory counter missing"

printf 'hex territory smoke test passed\n'
