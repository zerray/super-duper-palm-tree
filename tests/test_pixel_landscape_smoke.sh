#!/usr/bin/env bash

set -euo pipefail

root_dir="$(cd "$(dirname "$0")/.." && pwd)"
app_file="$root_dir/pixel-landscape/index.html"

fail() {
  printf 'FAIL: %s\n' "$1" >&2
  exit 1
}

[ -f "$app_file" ] || fail "pixel-landscape/index.html is missing"

grep -q '<canvas id="landscape-canvas"' "$app_file" || fail "canvas element missing"
grep -q 'function mulberry32' "$app_file" || fail "seeded RNG missing"
grep -q 'function buildValueNoise' "$app_file" || fail "1D noise function missing"
grep -q 'id="biome-slider"' "$app_file" || fail "biome slider missing"
grep -q 'id="time-slider"' "$app_file" || fail "time slider missing"
grep -q 'id="palette-slider"' "$app_file" || fail "palette slider missing"
grep -q 'id="regenerate-button"' "$app_file" || fail "regenerate button missing"
grep -q 'id="export-button"' "$app_file" || fail "export button missing"
grep -q "canvas.toDataURL(\"image/png\")" "$app_file" || fail "PNG export missing"
grep -q 'drawWater' "$app_file" || fail "water layer missing"
grep -q 'drawCloud' "$app_file" || fail "cloud layer missing"

printf 'pixel landscape smoke test passed\n'
