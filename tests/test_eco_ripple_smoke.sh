#!/usr/bin/env bash

set -euo pipefail

root_dir="$(cd "$(dirname "$0")/.." && pwd)"
app_file="$root_dir/eco-ripple/index.html"

fail() {
  printf 'FAIL: %s\n' "$1" >&2
  exit 1
}

[ -f "$app_file" ] || fail "eco-ripple/index.html is missing"

grep -q '<canvas id="world"' "$app_file" || fail "world canvas missing"
grep -q '<canvas id="population-chart"' "$app_file" || fail "population chart missing"
grep -q 'const MAX_ENTITIES = 420;' "$app_file" || fail "entity cap missing"
grep -q 'const GRID_SIZE = 50;' "$app_file" || fail "spatial grid size missing"
grep -q 'function buildSpatialGrid(items)' "$app_file" || fail "spatial hashing missing"
grep -q 'function chooseTarget(entity, grids)' "$app_file" || fail "target selection missing"
grep -q 'function drawChart()' "$app_file" || fail "chart rendering missing"
grep -q 'button type="button" class="tool-button" data-tool="plant"' "$app_file" || fail "plant tool missing"
grep -q 'button type="button" class="tool-button" data-tool="herbivore"' "$app_file" || fail "herbivore tool missing"
grep -q 'button type="button" class="tool-button" data-tool="predator"' "$app_file" || fail "predator tool missing"
grep -q 'button type="button" class="tool-button" data-tool="decomposer"' "$app_file" || fail "decomposer tool missing"
grep -q 'button type="button" class="tool-button" data-tool="obstacle"' "$app_file" || fail "obstacle tool missing"
grep -q 'id="rain-button"' "$app_file" || fail "rain event missing"
grep -q 'id="drought-button"' "$app_file" || fail "drought event missing"
grep -q 'class="speed-button" data-speed="2"' "$app_file" || fail "2x speed missing"
grep -q 'class="speed-button" data-speed="4"' "$app_file" || fail "4x speed missing"
grep -q 'requestAnimationFrame(frame)' "$app_file" || fail "animation loop missing"
grep -q '植物 → 草食 → 掠食 → 尸体 → 分解者 → 养分 → 植物' "$app_file" || fail "food chain description missing"

printf 'eco ripple smoke test passed\n'
