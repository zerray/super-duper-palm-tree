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
grep -q 'data-tool="water"' "$app_file" || fail "water tool missing"
grep -q 'data-tool="sand"' "$app_file" || fail "sand tool missing"
grep -q 'data-tool="seed"' "$app_file" || fail "seed tool missing"
grep -q 'data-tool="sun"' "$app_file" || fail "sun tool missing"
grep -q 'data-tool="fish"' "$app_file" || fail "fish tool missing"
grep -q '右键擦除' "$app_file" || fail "erase instructions missing"
grep -q 'const plantStages = \["seed", "sprout", "stem", "leaf"\]' "$app_file" || fail "plant growth stages missing"
grep -q 'function updateSand' "$app_file" || fail "sand simulation missing"
grep -q 'function updateWater' "$app_file" || fail "water simulation missing"
grep -q 'function updateSeed' "$app_file" || fail "seed simulation missing"
grep -q 'function updateFish' "$app_file" || fail "fish AI missing"
grep -q 'function growPlant' "$app_file" || fail "plant growth logic missing"
grep -q 'spawnBubble' "$app_file" || fail "bubble generation missing"
grep -q 'tank.addEventListener("pointerdown"' "$app_file" || fail "paint interaction missing"
grep -q 'tank.addEventListener("contextmenu"' "$app_file" || fail "right click suppression missing"
grep -q 'state.eraseMode = event.button === 2' "$app_file" || fail "right click erase mode missing"
grep -q 'requestAnimationFrame(frame)' "$app_file" || fail "animation loop missing"

printf 'pixel ecosystem tank smoke test passed\n'
