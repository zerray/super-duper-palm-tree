#!/usr/bin/env bash

set -euo pipefail

root_dir="$(cd "$(dirname "$0")/.." && pwd)"
app_file="$root_dir/pixel-relay-canvas/index.html"
index_file="$root_dir/index.html"

fail() {
  printf 'FAIL: %s\n' "$1" >&2
  exit 1
}

[ -f "$app_file" ] || fail "pixel-relay-canvas/index.html is missing"

grep -q '<title>接力画布：双人合作像素画</title>' "$app_file" || fail "page title missing"
grep -q 'const GRID_SIZE = 16;' "$app_file" || fail "grid size config missing"
grep -q 'const PIXELS_PER_TURN = 5;' "$app_file" || fail "turn pixel limit missing"
grep -q 'const TURN_SECONDS = 10;' "$app_file" || fail "turn timer config missing"
grep -q 'const THEME_WORDS = \["火箭", "蛋糕", "小猫", "西瓜", "城堡", "风筝", "机器人", "蘑菇"\];' "$app_file" || fail "challenge words missing"
grep -q 'id="pixel-canvas"' "$app_file" || fail "main canvas missing"
grep -q '导出 PNG' "$app_file" || fail "png export control missing"
grep -q '动画回放' "$app_file" || fail "replay control missing"
grep -q '挑战模式：开局随机抽主题词，完成后互相猜' "$app_file" || fail "challenge mode label missing"
grep -q 'function createPixelGrid' "$app_file" || fail "grid creation logic missing"
grep -q 'function startTurnTimer' "$app_file" || fail "turn timer logic missing"
grep -q 'function switchTurn' "$app_file" || fail "turn switch logic missing"
grep -q 'function finishGame' "$app_file" || fail "finish flow missing"
grep -q 'function replayHistory' "$app_file" || fail "replay logic missing"
grep -q 'canvas.toBlob' "$app_file" || fail "png export implementation missing"
grep -q 'window.requestAnimationFrame(step);' "$app_file" || fail "requestAnimationFrame replay missing"

grep -q 'slug: "pixel-relay-canvas"' "$index_file" || fail "root index entry missing"
grep -q 'dual-player pixel art relay' "$index_file" || fail "root index description missing"

printf 'pixel relay canvas smoke test passed\n'
