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
grep -q 'data-tool="soil"' "$app_file" || fail "soil tool missing"
grep -q 'data-tool="seed"' "$app_file" || fail "seed tool missing"
grep -q 'data-tool="bug"' "$app_file" || fail "bug tool missing"
grep -q 'data-tool="sun"' "$app_file" || fail "sun tool missing"
grep -q '右键擦除' "$app_file" || fail "erase instructions missing"
grep -q 'const GRID_WIDTH = 40;' "$app_file" || fail "grid width missing"
grep -q 'const GRID_HEIGHT = 30;' "$app_file" || fail "grid height missing"
grep -q 'const START_BUDGETS = {' "$app_file" || fail "budget setup missing"
grep -q 'function updateWater' "$app_file" || fail "water simulation missing"
grep -q 'function updateSeed' "$app_file" || fail "seed simulation missing"
grep -q 'function updatePlant' "$app_file" || fail "plant growth logic missing"
grep -q 'function updateBug' "$app_file" || fail "bug AI missing"
grep -q 'function updateSoil' "$app_file" || fail "soil simulation missing"
grep -q 'function finalizeRound' "$app_file" || fail "challenge resolution missing"
grep -q 'localStorage.getItem(STORAGE_KEY)' "$app_file" || fail "best score load missing"
grep -q 'localStorage.setItem(STORAGE_KEY, String(score))' "$app_file" || fail "best score save missing"
grep -q '热座双人' "$app_file" || fail "hotseat mode missing"
grep -q '多样性指数' "$app_file" || fail "diversity stat missing"
grep -q 'tank.addEventListener("pointerdown"' "$app_file" || fail "paint interaction missing"
grep -q 'tank.addEventListener("contextmenu"' "$app_file" || fail "right click suppression missing"
grep -q 'state.eraseMode = event.button === 2' "$app_file" || fail "right click erase mode missing"
grep -q 'requestAnimationFrame(frame)' "$app_file" || fail "animation loop missing"

printf 'pixel ecosystem tank smoke test passed\n'
