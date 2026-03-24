#!/usr/bin/env bash

set -euo pipefail

root_dir="$(cd "$(dirname "$0")/.." && pwd)"
app_file="$root_dir/magnetic-ball-versus/index.html"
index_file="$root_dir/index.html"
readme_file="$root_dir/README.md"

fail() {
  printf 'FAIL: %s\n' "$1" >&2
  exit 1
}

[ -f "$app_file" ] || fail "magnetic-ball-versus/index.html is missing"
[ -f "$index_file" ] || fail "index.html is missing"
[ -f "$readme_file" ] || fail "README.md is missing"

grep -q '<!DOCTYPE html>' "$app_file" || fail "doctype missing"
grep -q '<canvas id="game"' "$app_file" || fail "canvas missing"
grep -q 'const magneticBallVersus = (() => {' "$app_file" || fail "game module missing"
grep -q '双人磁力弹球对战' "$app_file" || fail "title missing"
grep -q 'W / A / S / D 移动磁力器，空格切换吸引 / 排斥模式' "$app_file" || fail "player 1 controls missing"
grep -q '方向键移动磁力器，Enter 切换吸引 / 排斥模式' "$app_file" || fail "player 2 controls missing"
grep -q '固定挡板与加速带' "$app_file" || fail "obstacle text missing"
grep -q '让金属球撞上对方底线即可得分，先到 5 分触发胜负判定界面' "$app_file" || fail "win condition text missing"
grep -q 'const TARGET_SCORE = 5;' "$app_file" || fail "target score constant missing"
grep -q 'const MAGNET_RANGE = 240;' "$app_file" || fail "magnet range missing"
grep -q 'function spawnObstacles()' "$app_file" || fail "obstacle spawn logic missing"
grep -q 'function togglePolarity(player)' "$app_file" || fail "polarity toggle logic missing"
grep -q 'function applyPlayerMagnetism(ball, dt)' "$app_file" || fail "magnet logic missing"
grep -q 'function handleBarrierCollisions(ball)' "$app_file" || fail "barrier collision logic missing"
grep -q 'function handleSpeedStripCollisions(ball)' "$app_file" || fail "speed strip logic missing"
grep -q 'function handlePlayerCollisions(ball)' "$app_file" || fail "player collision logic missing"
grep -q 'function handleScoring(ball)' "$app_file" || fail "score logic missing"
grep -q 'function drawTrails()' "$app_file" || fail "trail renderer missing"
grep -q 'function drawMagneticLinks()' "$app_file" || fail "field line renderer missing"
grep -q 'function drawPlayers()' "$app_file" || fail "player renderer missing"
grep -q 'globalCompositeOperation = "lighter"' "$app_file" || fail "neon blend missing"
grep -q 'requestAnimationFrame(frame);' "$app_file" || fail "animation loop missing"

grep -q 'slug: "magnetic-ball-versus"' "$index_file" || fail "showcase entry missing"
grep -q 'title: "双人磁力弹球对战"' "$index_file" || fail "showcase title missing"
grep -q '## 双人磁力弹球对战' "$readme_file" || fail "README section missing"

printf 'magnetic ball versus smoke test passed\n'
