#!/usr/bin/env bash

set -euo pipefail

root_dir="$(cd "$(dirname "$0")/.." && pwd)"
app_file="$root_dir/pixel-ecosystem-tank/index.html"

fail() {
  printf 'FAIL: %s\n' "$1" >&2
  exit 1
}

[ -f "$app_file" ] || fail "pixel-ecosystem-tank/index.html is missing"

grep -q '<canvas id="world"' "$app_file" || fail "world canvas missing"
grep -q 'width="128" height="128"' "$app_file" || fail "128x128 canvas missing"
grep -q 'const WATER = 1' "$app_file" || fail "water type missing"
grep -q 'const SAND = 2' "$app_file" || fail "sand type missing"
grep -q 'const STONE = 3' "$app_file" || fail "stone type missing"
grep -q 'const SEED = 4' "$app_file" || fail "seed type missing"
grep -q 'const PLANT = 5' "$app_file" || fail "plant type missing"
grep -q 'const BUG = 6' "$app_file" || fail "bug type missing"
grep -q '种子 → 植物 → 小虫 → 鸟' "$app_file" || fail "food chain copy missing"
grep -q 'function stepWater' "$app_file" || fail "water simulation missing"
grep -q 'function stepSeed' "$app_file" || fail "seed simulation missing"
grep -q 'function stepPlant' "$app_file" || fail "plant simulation missing"
grep -q 'function stepBug' "$app_file" || fail "bug simulation missing"
grep -q 'function updateBirds' "$app_file" || fail "bird simulation missing"
grep -q 'speciesList.replaceChildren' "$app_file" || fail "live stats panel missing"
grep -q 'ctx.putImageData' "$app_file" || fail "ImageData rendering missing"
grep -q 'requestAnimationFrame(frame)' "$app_file" || fail "animation loop missing"

printf 'pixel ecosystem tank smoke test passed\n'
