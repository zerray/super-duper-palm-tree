#!/usr/bin/env bash

set -euo pipefail

root_dir="$(cd "$(dirname "$0")/.." && pwd)"
app_file="$root_dir/pixel-ecosystem-tank/index.html"

fail() {
  printf 'FAIL: %s\n' "$1" >&2
  exit 1
}

[ -f "$app_file" ] || fail "pixel-ecosystem-tank/index.html is missing"

grep -q '<canvas id="tank-canvas"' "$app_file" || fail "tank canvas missing"
grep -q 'id="light-slider"' "$app_file" || fail "light slider missing"
grep -q 'id="temperature-slider"' "$app_file" || fail "temperature slider missing"
grep -q 'MAX_CREATURES = 200' "$app_file" || fail "population cap missing"
grep -q 'algae:' "$app_file" || fail "algae species missing"
grep -q 'zooplankton:' "$app_file" || fail "zooplankton species missing"
grep -q 'fish:' "$app_file" || fail "fish species missing"
grep -q '藻类 → 浮游动物 → 小鱼' "$app_file" || fail "food chain copy missing"
grep -q 'STATE_WANDER = "wander"' "$app_file" || fail "wander state missing"
grep -q 'STATE_SEEK = "seek"' "$app_file" || fail "seek state missing"
grep -q 'STATE_CHASE = "chase"' "$app_file" || fail "chase state missing"
grep -q 'STATE_EAT = "eat"' "$app_file" || fail "eat state missing"
grep -q 'function reproductionPass()' "$app_file" || fail "reproduction logic missing"
grep -q 'function mortalityPass()' "$app_file" || fail "mortality logic missing"
grep -q 'spawnParticles(organism.x, organism.y, "#7de0ae"' "$app_file" || fail "birth particles missing"
grep -q 'spawnParticles(organism.x, organism.y, "#ff7b68"' "$app_file" || fail "death particles missing"
grep -q 'requestAnimationFrame(frame)' "$app_file" || fail "animation loop missing"
grep -q 'speciesList.replaceChildren' "$app_file" || fail "live stats panel missing"

printf 'pixel ecosystem tank smoke test passed\n'
