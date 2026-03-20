#!/usr/bin/env bash

set -euo pipefail

root_dir="$(cd "$(dirname "$0")/.." && pwd)"
app_file="$root_dir/pixel-biome-terrarium/index.html"

fail() {
  printf 'FAIL: %s\n' "$1" >&2
  exit 1
}

[ -f "$app_file" ] || fail "pixel-biome-terrarium/index.html is missing"

grep -q '<canvas id="world-canvas"' "$app_file" || fail "world canvas missing"
grep -q '<canvas id="population-chart"' "$app_file" || fail "population chart canvas missing"
grep -q 'const GRID_SIZE = 64;' "$app_file" || fail "64x64 world configuration missing"
grep -q 'const CELL_SIZE = 6;' "$app_file" || fail "pixel cell size missing"
grep -q 'function tick()' "$app_file" || fail "simulation tick loop missing"
grep -q 'function updateGrass(nextGrass)' "$app_file" || fail "grass growth logic missing"
grep -q 'function chooseTarget' "$app_file" || fail "creature targeting logic missing"
grep -q 'function drawChart()' "$app_file" || fail "population chart rendering missing"
grep -q 'id="rain-toggle"' "$app_file" || fail "rain toggle missing"
grep -q 'id="tick-speed"' "$app_file" || fail "tick speed slider missing"
grep -q 'name="tool" value="grass"' "$app_file" || fail "food drop interaction missing"
grep -q 'name="tool" value="herbivore"' "$app_file" || fail "herbivore spawn interaction missing"
grep -q 'name="tool" value="predator"' "$app_file" || fail "predator spawn interaction missing"
grep -q 'requestAnimationFrame(frame)' "$app_file" || fail "continuous simulation loop missing"

printf 'pixel biome terrarium smoke test passed\n'
