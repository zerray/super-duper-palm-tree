#!/usr/bin/env bash

set -euo pipefail

root_dir="$(cd "$(dirname "$0")/.." && pwd)"
app_file="$root_dir/magnetic-pinball-arena/index.html"
index_file="$root_dir/index.html"
readme_file="$root_dir/README.md"

fail() {
  printf 'FAIL: %s\n' "$1" >&2
  exit 1
}

[ -f "$app_file" ] || fail "magnetic-pinball-arena/index.html is missing"
[ -f "$index_file" ] || fail "index.html is missing"
[ -f "$readme_file" ] || fail "README.md is missing"

grep -q '<!DOCTYPE html>' "$app_file" || fail "doctype missing"
grep -q '<canvas id="game"' "$app_file" || fail "canvas missing"
grep -q 'const magneticPinballArena = (() => {' "$app_file" || fail "game module missing"
grep -q '双人磁力弹球竞技场' "$app_file" || fail "title missing"
grep -q 'W / S 调角度，D 蓄力发射' "$app_file" || fail "player 1 controls missing"
grep -q '↑ / ↓ 调角度，← 蓄力发射' "$app_file" || fail "player 2 controls missing"
grep -q '先到 5 分获胜' "$app_file" || fail "win condition missing"
grep -q 'const WIN_SCORE = 5;' "$app_file" || fail "win score constant missing"
grep -q 'const MAX_BALLS = 12;' "$app_file" || fail "ball cap missing"
grep -q 'const MAGNET_BLOCK_INTERVAL = 3.8;' "$app_file" || fail "magnet interval missing"
grep -q 'const MAGNET_RANGE = 180;' "$app_file" || fail "magnet range missing"
grep -q 'function spawnBall(player)' "$app_file" || fail "ball spawn logic missing"
grep -q 'function spawnMagneticBlock()' "$app_file" || fail "magnet block spawner missing"
grep -q 'function applyMagneticBlocks(dt)' "$app_file" || fail "magnet block updater missing"
grep -q 'function resolveBallCollisions()' "$app_file" || fail "ball collision logic missing"
grep -q 'function scorePoint(player, x, y)' "$app_file" || fail "goal scoring missing"
grep -q 'function playScoreSound()' "$app_file" || fail "score sound missing"
grep -q 'function drawBallTrails()' "$app_file" || fail "trail renderer missing"
grep -q '命中对方底线得分' "$app_file" || fail "scoring feedback text missing"
grep -q 'requestAnimationFrame(tick);' "$app_file" || fail "animation loop missing"
grep -q 'FPS ' "$app_file" || fail "fps label missing"

grep -q 'slug: "magnetic-pinball-arena"' "$index_file" || fail "showcase entry missing"
grep -q 'title: "双人磁力弹球竞技场"' "$index_file" || fail "showcase title missing"
grep -q '## 双人磁力弹球竞技场' "$readme_file" || fail "README section missing"

printf 'magnetic pinball arena smoke test passed\n'
