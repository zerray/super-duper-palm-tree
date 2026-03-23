#!/usr/bin/env bash

set -euo pipefail

root_dir="$(cd "$(dirname "$0")/.." && pwd)"
app_file="$root_dir/pixel-coop-puzzle/index.html"

fail() {
  printf 'FAIL: %s\n' "$1" >&2
  exit 1
}

[ -f "$app_file" ] || fail "pixel-coop-puzzle/index.html is missing"

grep -q '<title>合作像素拼图：双人协作还原像素画</title>' "$app_file" || fail "page title missing"
grep -q 'const DIFFICULTIES = {' "$app_file" || fail "difficulty config missing"
grep -q 'easy: { label: "简单", size: 8, seconds: 180 }' "$app_file" || fail "easy difficulty missing"
grep -q 'medium: { label: "普通", size: 12, seconds: 240 }' "$app_file" || fail "medium difficulty missing"
grep -q 'hard: { label: "困难", size: 16, seconds: 300 }' "$app_file" || fail "hard difficulty missing"
grep -q '玩家 1 负责红色通道，玩家 2 负责青色通道（绿+蓝）' "$app_file" || fail "channel split copy missing"
grep -q 'function generateTarget' "$app_file" || fail "target generation missing"
grep -q 'function splitChannels' "$app_file" || fail "channel split logic missing"
grep -q 'function handlePointerUp' "$app_file" || fail "drop handler missing"
grep -q 'function endGame' "$app_file" || fail "end game summary missing"
grep -q 'id="board-canvas"' "$app_file" || fail "board canvas missing"
grep -q 'id="preview-canvas"' "$app_file" || fail "preview canvas missing"
grep -q 'id="tray-red-canvas"' "$app_file" || fail "red tray canvas missing"
grep -q 'id="tray-cyan-canvas"' "$app_file" || fail "cyan tray canvas missing"
grep -q 'id="result-overlay"' "$app_file" || fail "result overlay missing"

printf 'pixel coop puzzle smoke test passed\n'
