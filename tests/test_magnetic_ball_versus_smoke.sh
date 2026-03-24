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
grep -q 'W / S 移动，A / D 调角度，空格发射，Q 切换极性' "$app_file" || fail "player 1 controls missing"
grep -q '↑ / ↓ 移动，← / → 调角度，Enter 发射，Shift 切换极性' "$app_file" || fail "player 2 controls missing"
grep -q '球穿过对方底线得 1 分，先到 7 分获胜' "$app_file" || fail "win condition text missing"
grep -q 'const TARGET_SCORE = 7;' "$app_file" || fail "target score constant missing"
grep -q 'const MAGNET_RANGE = 220;' "$app_file" || fail "magnet range missing"
grep -q 'const MAX_BALLS_PER_PLAYER = 8;' "$app_file" || fail "ball cap missing"
grep -q 'function togglePolarity(playerId)' "$app_file" || fail "polarity logic missing"
grep -q 'function spawnBall(player)' "$app_file" || fail "spawn logic missing"
grep -q 'function applyMagneticForces(dt)' "$app_file" || fail "magnet logic missing"
grep -q 'function resolveBallCollisions()' "$app_file" || fail "collision logic missing"
grep -q 'function handleScoring()' "$app_file" || fail "score logic missing"
grep -q 'function drawTrails()' "$app_file" || fail "trail renderer missing"
grep -q 'function drawMagneticLinks()' "$app_file" || fail "field line renderer missing"
grep -q 'globalCompositeOperation = "lighter"' "$app_file" || fail "neon blend missing"
grep -q 'requestAnimationFrame(frame);' "$app_file" || fail "animation loop missing"

grep -q 'slug: "magnetic-ball-versus"' "$index_file" || fail "showcase entry missing"
grep -q 'title: "双人磁力弹球对战"' "$index_file" || fail "showcase title missing"
grep -q '## 双人磁力弹球对战' "$readme_file" || fail "README section missing"

printf 'magnetic ball versus smoke test passed\n'
