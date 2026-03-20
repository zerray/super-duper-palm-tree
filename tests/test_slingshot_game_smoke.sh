#!/usr/bin/env bash

set -euo pipefail

root_dir="$(cd "$(dirname "$0")/.." && pwd)"
game_file="$root_dir/slingshot-game/index.html"

fail() {
  printf 'FAIL: %s\n' "$1" >&2
  exit 1
}

[ -f "$game_file" ] || fail "slingshot-game/index.html is missing"

grep -q 'Orbital Slingshot' "$game_file" || fail "game title missing"
grep -q 'const PHYSICS = {' "$game_file" || fail "physics configuration missing"
grep -q 'function buildPreview' "$game_file" || fail "trajectory preview logic missing"
grep -q 'function computeGravity' "$game_file" || fail "gravity simulation missing"
grep -q 'function completeLevel' "$game_file" || fail "level advancement logic missing"

printf 'slingshot game smoke test passed\n'
