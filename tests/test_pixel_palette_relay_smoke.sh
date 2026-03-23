#!/usr/bin/env bash

set -euo pipefail

root_dir="$(cd "$(dirname "$0")/.." && pwd)"
app_file="$root_dir/pixel-palette-relay/index.html"
index_file="$root_dir/index.html"

fail() {
  printf 'FAIL: %s\n' "$1" >&2
  exit 1
}

[ -f "$app_file" ] || fail "pixel-palette-relay/index.html is missing"

grep -q '<title>像素调色板接力：合作拼图</title>' "$app_file" || fail "page title missing"
grep -q 'const TURN_LIMIT = 20;' "$app_file" || fail "turn limit missing"
grep -q 'const GRID_SIZE = 8;' "$app_file" || fail "grid size missing"
grep -q 'const PATTERNS = \[' "$app_file" || fail "patterns config missing"
grep -q 'name: "晚霞条带"' "$app_file" || fail "first pattern missing"
grep -q 'name: "信号光柱"' "$app_file" || fail "second pattern missing"
grep -q 'name: "港口灯带"' "$app_file" || fail "third pattern missing"
grep -q 'function createScrambledBoard' "$app_file" || fail "scramble logic missing"
grep -q 'function getProgress' "$app_file" || fail "progress logic missing"
grep -q 'function applyColor' "$app_file" || fail "move application missing"
grep -q '热座双人' "$app_file" || fail "coop mode label missing"
grep -q '单人模式' "$app_file" || fail "single player label missing"

grep -q 'pixel-palette-relay' "$index_file" || fail "root index entry missing"

printf 'pixel palette relay smoke test passed\n'
