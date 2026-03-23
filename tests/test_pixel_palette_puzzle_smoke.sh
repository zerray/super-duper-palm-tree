#!/usr/bin/env bash

set -euo pipefail

root_dir="$(cd "$(dirname "$0")/.." && pwd)"
app_file="$root_dir/pixel-palette-puzzle/index.html"

fail() {
  printf 'FAIL: %s\n' "$1" >&2
  exit 1
}

[ -f "$app_file" ] || fail "pixel-palette-puzzle/index.html is missing"

grep -q '<title>像素调色板：合作拼图画布</title>' "$app_file" || fail "page title missing"
grep -q 'const DIFFICULTIES = {' "$app_file" || fail "difficulty configuration missing"
grep -q 'easy: { label: "简单", size: 8, colors: 4, turns: 24' "$app_file" || fail "easy difficulty missing"
grep -q 'medium: { label: "普通", size: 12, colors: 6, turns: 20' "$app_file" || fail "medium difficulty missing"
grep -q 'hard: { label: "困难", size: 16, colors: 8, turns: 20' "$app_file" || fail "hard difficulty missing"
grep -q '玩家 A 只知道颜色总量' "$app_file" || fail "player A clue text missing"
grep -q '玩家 B 只知道哪些位置应该点亮' "$app_file" || fail "player B clue text missing"
grep -q 'function generateTarget' "$app_file" || fail "target generator missing"
grep -q 'function scoreBoards' "$app_file" || fail "scoring logic missing"
grep -q 'function handleSignal' "$app_file" || fail "signal logic missing"
grep -q 'id="transition-screen"' "$app_file" || fail "transition screen missing"
grep -q 'id="target-compare"' "$app_file" || fail "target comparison view missing"
grep -q 'id="shared-compare"' "$app_file" || fail "shared comparison view missing"

printf 'pixel palette puzzle smoke test passed\n'
