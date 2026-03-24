#!/usr/bin/env bash

set -euo pipefail

root_dir="$(cd "$(dirname "$0")/.." && pwd)"
app_file="$root_dir/infinite-mine/index.html"
index_file="$root_dir/index.html"

fail() {
  printf 'FAIL: %s\n' "$1" >&2
  exit 1
}

[ -f "$app_file" ] || fail "infinite-mine/index.html is missing"

grep -q '<canvas id="mine-canvas"' "$app_file" || fail "canvas mine view missing"
grep -q 'localStorage' "$app_file" || fail "localStorage persistence missing"
grep -q 'requestAnimationFrame(step)' "$app_file" || fail "animation loop missing"
grep -q 'mineStep()' "$app_file" || fail "auto mining step missing"
grep -q 'pickOre' "$app_file" || fail "procedural ore generation missing"
grep -q '更快的钻头' "$app_file" || fail "speed upgrade missing"
grep -q '更宽的挖掘范围' "$app_file" || fail "width upgrade missing"
grep -q '自动收集器' "$app_file" || fail "collector upgrade missing"
grep -q '地层扫描仪' "$app_file" || fail "scanner upgrade missing"
grep -q 'diamond' "$app_file" || fail "diamond ore tier missing"
grep -q 'mystic' "$app_file" || fail "mystic ore tier missing"
grep -q 'spawnCollectionVfx' "$app_file" || fail "collection vfx missing"
grep -q 'image-rendering: pixelated' "$app_file" || fail "pixelated canvas styling missing"
grep -q 'STORAGE_KEY = "infinite-mine-save-v2"' "$app_file" || fail "save key missing"

grep -q '56 playable games' "$index_file" || fail "root game count not updated"
grep -q 'slug: "infinite-mine"' "$index_file" || fail "root card metadata missing"

printf 'infinite mine smoke test passed\n'
