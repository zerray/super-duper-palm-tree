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
grep -q 'applyOfflineProgress' "$app_file" || fail "offline progress calculation missing"
grep -q 'getPassiveDigsPerSecond' "$app_file" || fail "idle digging loop missing"
grep -q 'pickOre' "$app_file" || fail "procedural ore generation missing"
grep -q '钻头' "$app_file" || fail "drill upgrade missing"
grep -q '背包' "$app_file" || fail "backpack upgrade missing"
grep -q '探灯' "$app_file" || fail "lantern upgrade missing"
grep -q 'diamond' "$app_file" || fail "deep ore tier missing"
grep -q 'STORAGE_KEY = "infinite-mine-save-v1"' "$app_file" || fail "save key missing"

grep -q '43 playable games' "$index_file" || fail "root game count not updated"
grep -q 'slug: "infinite-mine"' "$index_file" || fail "root card metadata missing"

printf 'infinite mine smoke test passed\n'
