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
grep -q 'W / S 调角度，A / D 调力度，Space 发射' "$app_file" || fail "player 1 controls missing"
grep -q '↑ / ↓ 调角度，← / → 调力度，Enter 发射' "$app_file" || fail "player 2 controls missing"
grep -q '玩家 1 用 WASD + Space，玩家 2 用方向键 + Enter。按住方向键可在发射前调整角度和力度。' "$app_file" || fail "status text missing"
grep -q 'const TARGET_SCORE = 5;' "$app_file" || fail "target score constant missing"
grep -q 'function generateMagneticObstacles()' "$app_file" || fail "obstacle generator missing"
grep -q 'const count = 1 + Math.floor(Math.random() \* 3);' "$app_file" || fail "1-3 obstacle logic missing"
grep -q 'const baseMagneticPoints = \[' "$app_file" || fail "base magnetic points missing"
grep -q 'strength: 1' "$app_file" || fail "attractor point missing"
grep -q 'strength: -1' "$app_file" || fail "repulsor point missing"
grep -q 'function applyMagneticForces(marble)' "$app_file" || fail "magnet force logic missing"
grep -q 'MAGNET_FORCE / safeDistanceSq' "$app_file" || fail "inverse square force missing"
grep -q 'function handleScoring(marble)' "$app_file" || fail "scoring logic missing"
grep -q 'function finishGame(player)' "$app_file" || fail "finish game logic missing"
grep -q 'function drawTrails()' "$app_file" || fail "trail renderer missing"
grep -q 'ctx.arc(point.x, point.y, point.radius \* pulse' "$app_file" || fail "magnetic pulse visual missing"
grep -q 'requestAnimationFrame(tick);' "$app_file" || fail "animation loop missing"

grep -q 'slug: "magnetic-ball-versus"' "$index_file" || fail "showcase entry missing"
grep -q 'title: "双人磁力弹球对战"' "$index_file" || fail "showcase title missing"
grep -q 'top and bottom players tune angle and power' "$index_file" || fail "showcase description missing"
grep -q '## 双人磁力弹球对战' "$readme_file" || fail "README section missing"
grep -q '玩家 1 使用 `W / S` 调整角度、`A / D` 调整力度、`Space` 发射' "$readme_file" || fail "README controls missing"
grep -q '固定存在至少 `2` 个磁力点' "$readme_file" || fail "README magnetic points missing"
grep -q '随机生成 `1-3` 个吸引或排斥磁力障碍物' "$readme_file" || fail "README obstacle copy missing"
grep -q '先到 `5` 分显示胜利画面' "$readme_file" || fail "README victory copy missing"

printf 'magnetic ball versus smoke test passed\n'
