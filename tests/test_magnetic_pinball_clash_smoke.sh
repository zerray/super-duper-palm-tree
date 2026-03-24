#!/usr/bin/env bash

set -euo pipefail

root_dir="$(cd "$(dirname "$0")/.." && pwd)"
app_file="$root_dir/magnetic-pinball-clash/index.html"
index_file="$root_dir/index.html"

fail() {
  printf 'FAIL: %s\n' "$1" >&2
  exit 1
}

[ -f "$app_file" ] || fail "magnetic-pinball-clash/index.html is missing"
[ -f "$index_file" ] || fail "index.html is missing"

grep -q '<!DOCTYPE html>' "$app_file" || fail "doctype missing"
grep -q '<canvas id="game"' "$app_file" || fail "canvas missing"
grep -q 'const magneticPinballClash = (() => {' "$app_file" || fail "game module missing"
grep -q 'A / D 调角度，W 发射，S 切换弹珠' "$app_file" || fail "player 1 controls missing"
grep -q '← / → 调角度，↑ 发射，↓ 切换弹珠' "$app_file" || fail "player 2 controls missing"
grep -q 'const marbleTypes = \[' "$app_file" || fail "marble types missing"
grep -q 'name: "正极"' "$app_file" || fail "positive marble missing"
grep -q 'name: "负极"' "$app_file" || fail "negative marble missing"
grep -q 'name: "中性"' "$app_file" || fail "neutral marble missing"
grep -q 'const ROUND_SECONDS = 60;' "$app_file" || fail "timer missing"
grep -q 'function applyMagnetism(dt)' "$app_file" || fail "magnet logic missing"
grep -q 'function collideMarbles()' "$app_file" || fail "collision logic missing"
grep -q 'function drawLinks()' "$app_file" || fail "field visualization missing"
grep -q 'scores\[1\] += 1;' "$app_file" || fail "player 1 scoring missing"
grep -q 'scores\[2\] += 1;' "$app_file" || fail "player 2 scoring missing"
grep -q 'window.addEventListener("keydown", onKeyDown, { passive: false });' "$app_file" || fail "keyboard input missing"
grep -q 'requestAnimationFrame(frame);' "$app_file" || fail "animation loop missing"
grep -q '按 Space 或 Enter 可重开' "$app_file" || fail "restart hint missing"

grep -q 'slug: "magnetic-pinball-clash"' "$index_file" || fail "showcase entry missing"
grep -q 'title: "磁力弹珠台：双人同屏对撞"' "$index_file" || fail "showcase title missing"

printf 'magnetic pinball clash smoke test passed\n'
