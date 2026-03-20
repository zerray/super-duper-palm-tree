#!/usr/bin/env bash

set -euo pipefail

root_dir="$(cd "$(dirname "$0")/.." && pwd)"
game_file="$root_dir/game-of-life/index.html"

fail() {
  printf 'FAIL: %s\n' "$1" >&2
  exit 1
}

[ -f "$game_file" ] || fail "game-of-life/index.html is missing"

grep -q '<canvas id="life-canvas"' "$game_file" || fail "canvas element missing"
grep -q 'const GRID_WIDTH = 120;' "$game_file" || fail "grid width missing"
grep -q 'let currentGrid = new Uint8Array' "$game_file" || fail "typed array grid missing"
grep -q 'computeNextGeneration' "$game_file" || fail "simulation step function missing"
grep -q 'id="play-button"' "$game_file" || fail "play control missing"
grep -q 'id="pause-button"' "$game_file" || fail "pause control missing"
grep -q 'id="step-button"' "$game_file" || fail "step control missing"
grep -q 'id="speed-slider"' "$game_file" || fail "speed slider missing"
grep -q 'Gosper Glider Gun' "$game_file" || fail "pattern dropdown missing expected option"
grep -q 'handleWheel' "$game_file" || fail "zoom support missing"

printf 'game of life smoke test passed\n'
