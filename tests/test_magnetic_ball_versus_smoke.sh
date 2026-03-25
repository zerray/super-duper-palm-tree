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
grep -q '玩家 1：W/S 调角度，A/D 调力度，Space 发射。玩家 2：方向键调角度/力度，Enter 发射。' "$app_file" || fail "status controls missing"
grep -q '底部发射器。W / S 微调发射角，A / D 微调力度，Space 发射磁力弹球。' "$app_file" || fail "player 1 controls missing"
grep -q '顶部发射器。方向键微调发射角与力度，Enter 发射；双方可同时在场。' "$app_file" || fail "player 2 controls missing"
grep -q '至少 2 个固定磁力点常驻，中场每回合还会随机生成 1-3 个吸引/排斥障碍' "$app_file" || fail "magnet summary missing"
grep -q '弹球落入对方底线得分区即可得分，先到 5 分获胜。' "$app_file" || fail "win condition text missing"
grep -q 'const TARGET_SCORE = 5;' "$app_file" || fail "target score constant missing"
grep -q 'const FIXED_MAGNET_COUNT = 2;' "$app_file" || fail "fixed magnet count missing"
grep -q 'const OBSTACLE_MIN = 1;' "$app_file" || fail "obstacle minimum missing"
grep -q 'const OBSTACLE_MAX = 3;' "$app_file" || fail "obstacle maximum missing"
grep -q 'function createRoundObstacles()' "$app_file" || fail "obstacle generation missing"
grep -q 'function applyMagneticForces(ball, dt)' "$app_file" || fail "magnetic force logic missing"
grep -q 'function fireBall(player)' "$app_file" || fail "fire logic missing"
grep -q 'function handleScoring(ball)' "$app_file" || fail "score logic missing"
grep -q 'function beginNextRound()' "$app_file" || fail "round reset logic missing"
grep -q 'function drawTrails()' "$app_file" || fail "trail renderer missing"
grep -q 'globalCompositeOperation = "lighter"' "$app_file" || fail "glow blend missing"
grep -q 'requestAnimationFrame(frame);' "$app_file" || fail "animation loop missing"

grep -q 'slug: "magnetic-ball-versus"' "$index_file" || fail "showcase entry missing"
grep -q 'title: "双人磁力弹球对战"' "$index_file" || fail "showcase title missing"
grep -q 'top-vs-bottom launcher duel' "$index_file" || fail "showcase description missing"
grep -q '## 双人磁力弹球对战' "$readme_file" || fail "README section missing"
grep -q '玩家 1 使用 `W / S` 调整角度、`A / D` 调整力度并按 `Space` 发射，玩家 2 使用方向键与 `Enter`' "$readme_file" || fail "README controls missing"
grep -q '至少 2 个固定磁力点会持续按距离平方反比改变弹道' "$readme_file" || fail "README magnet physics missing"
grep -q '弹球附带可见拖尾轨迹，先达到 5 分显示胜利画面' "$readme_file" || fail "README win state missing"

printf 'magnetic ball versus smoke test passed\n'
