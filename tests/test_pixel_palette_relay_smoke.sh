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
grep -q 'const TEMPLATES = \[' "$app_file" || fail "templates config missing"
grep -q 'name: "莓果心跳"' "$app_file" || fail "8x8 template missing"
grep -q 'name: "午后花盆"' "$app_file" || fail "10x10 template missing"
grep -q 'name: "小屋黄昏"' "$app_file" || fail "12x12 template missing"
grep -q 'size: 8' "$app_file" || fail "8x8 size missing"
grep -q 'size: 10' "$app_file" || fail "10x10 size missing"
grep -q 'size: 12' "$app_file" || fail "12x12 size missing"
grep -q '<canvas id="play-canvas"' "$app_file" || fail "play canvas missing"
grep -q '<canvas id="target-canvas"' "$app_file" || fail "target canvas missing"
grep -q '单人模式' "$app_file" || fail "single-player label missing"
grep -q '双人热座' "$app_file" || fail "hot-seat label missing"
grep -q '半透明提示' "$app_file" || fail "hint description missing"
grep -q '撤回错放' "$app_file" || fail "undo button missing"
grep -q '总步数' "$app_file" || fail "step counter missing"
grep -q 'function createOwnerGrid' "$app_file" || fail "ownership split logic missing"
grep -q 'function drawPlayBoard' "$app_file" || fail "board renderer missing"
grep -q 'function handlePlayBoardClick' "$app_file" || fail "board click handler missing"
grep -q 'function undoLatestWrongPlacement' "$app_file" || fail "undo logic missing"
grep -q 'function finishGame' "$app_file" || fail "completion logic missing"

grep -q 'pixel-palette-relay' "$index_file" || fail "root index entry missing"
grep -q 'private hint overlays' "$index_file" || fail "root index description not updated"

printf 'pixel palette relay smoke test passed\n'
