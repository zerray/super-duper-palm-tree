#!/usr/bin/env bash

set -euo pipefail

root_dir="$(cd "$(dirname "$0")/.." && pwd)"
game_file="$root_dir/hex-territory/index.html"

fail() {
  printf 'FAIL: %s\n' "$1" >&2
  exit 1
}

[ -f "$game_file" ] || fail "hex-territory/index.html is missing"

grep -q 'aria-label="Hex territory board"' "$game_file" || fail "svg board missing"
grep -q 'const CONFIG = {' "$game_file" || fail "game config missing"
grep -q 'function chooseAiMove()' "$game_file" || fail "AI move logic missing"
grep -q 'neighborSupport' "$game_file" || fail "greedy AI heuristic missing"
grep -q 'Player Territory' "$game_file" || fail "territory counters missing"
grep -q 'Player Points' "$game_file" || fail "points display missing"

printf 'hex territory smoke test passed\n'
