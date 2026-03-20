#!/usr/bin/env bash

set -euo pipefail

root_dir="$(cd "$(dirname "$0")/.." && pwd)"
game_file="$root_dir/gem-mine-clicker/index.html"

fail() {
  printf 'FAIL: %s\n' "$1" >&2
  exit 1
}

[ -f "$game_file" ] || fail "gem-mine-clicker/index.html is missing"

grep -q '<!DOCTYPE html>' "$game_file" || fail "doctype missing"
grep -q 'window.localStorage' "$game_file" || fail "localStorage persistence missing"
grep -q 'window.requestAnimationFrame' "$game_file" || fail "requestAnimationFrame ticker missing"
grep -q 'Prestige' "$game_file" || fail "prestige UI missing"
grep -q 'particle' "$game_file" || fail "particle effect code missing"
grep -q 'floating-number' "$game_file" || fail "rising number feedback missing"

printf 'gem mine smoke test passed\n'
