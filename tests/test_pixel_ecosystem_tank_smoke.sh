#!/usr/bin/env bash

set -euo pipefail

root_dir="$(cd "$(dirname "$0")/.." && pwd)"
app_file="$root_dir/pixel-ecosystem-tank/index.html"

fail() {
  printf 'FAIL: %s\n' "$1" >&2
  exit 1
}

[ -f "$app_file" ] || fail "pixel-ecosystem-tank/index.html is missing"

grep -q '<canvas id="tank"' "$app_file" || fail "tank canvas missing"
grep -q '<canvas id="chart"' "$app_file" || fail "chart canvas missing"
grep -q '光照强度' "$app_file" || fail "light control copy missing"
grep -q 'type="range"' "$app_file" || fail "light slider missing"
grep -q '藻类 → 浮游生物 → 捕食者' "$app_file" || fail "food chain copy missing"
grep -q 'const MAX_ALGAE = 220' "$app_file" || fail "algae cap missing"
grep -q 'const MAX_PLANKTON = 90' "$app_file" || fail "plankton cap missing"
grep -q 'const MAX_PREDATORS = 40' "$app_file" || fail "predator cap missing"
grep -q 'function updateAlgae' "$app_file" || fail "algae simulation missing"
grep -q 'function updatePlankton' "$app_file" || fail "plankton simulation missing"
grep -q 'function updatePredators' "$app_file" || fail "predator simulation missing"
grep -q 'function renderChart' "$app_file" || fail "population chart missing"
grep -q 'countList.replaceChildren' "$app_file" || fail "live species counts missing"
grep -q 'tank.addEventListener("pointerdown"' "$app_file" || fail "paint interaction missing"
grep -q 'requestAnimationFrame(frame)' "$app_file" || fail "animation loop missing"

printf 'pixel ecosystem tank smoke test passed\n'
