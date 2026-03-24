#!/usr/bin/env bash

set -euo pipefail

root_dir="$(cd "$(dirname "$0")/.." && pwd)"
app_file="$root_dir/magnetic-pinball-duel/index.html"
index_file="$root_dir/index.html"

fail() {
  printf 'FAIL: %s\n' "$1" >&2
  exit 1
}

[ -f "$app_file" ] || fail "magnetic-pinball-duel/index.html is missing"
[ -f "$index_file" ] || fail "index.html is missing"

grep -q '<!DOCTYPE html>' "$app_file" || fail "doctype missing"
grep -q '<canvas id="game"' "$app_file" || fail "canvas missing"
grep -q 'const magneticPinballDuel = (() => {' "$app_file" || fail "game module missing"
grep -q 'W / S 调整发射角度，A / D 调整发射力度，F 发射' "$app_file" || fail "player 1 controls missing"
grep -q '↑ / ↓ 调整发射角度，← / → 调整发射力度，Enter 发射' "$app_file" || fail "player 2 controls missing"
grep -q '鼠标左键拖动底部粉色磁铁' "$app_file" || fail "player 1 magnet drag missing"
grep -q 'I / J / K / L 微调顶部蓝色磁铁位置' "$app_file" || fail "player 2 magnet controls missing"
grep -q '击中对方区域的得分靶 +1，击中己方护盾 -1，先到 7 分获胜' "$app_file" || fail "win condition text missing"
grep -q 'const FIRST_TO_SCORE = 7;' "$app_file" || fail "score target missing"
grep -q 'const MAX_BALLS = 8;' "$app_file" || fail "ball cap missing"
grep -q 'const GRAVITY = 880;' "$app_file" || fail "gravity missing"
grep -q 'const MAGNET_FIELD_RADIUS = 160;' "$app_file" || fail "magnet field radius missing"
grep -q 'const MAGNET_FORCE = 185000;' "$app_file" || fail "magnet force missing"
grep -q 'const targets = \[' "$app_file" || fail "targets missing"
grep -q 'const shields = \[' "$app_file" || fail "shields missing"
grep -q 'const bumpers = \[' "$app_file" || fail "bumpers missing"
grep -q 'const rails = \[' "$app_file" || fail "rails missing"
grep -q 'function fireShot(playerId)' "$app_file" || fail "launch logic missing"
grep -q 'function scorePoint(ownerId, amount, x, y, message, color)' "$app_file" || fail "score logic missing"
grep -q 'function endMatch(winnerId)' "$app_file" || fail "end match logic missing"
grep -q 'function applyMagnetForce(ball, magnet, dt)' "$app_file" || fail "magnet update missing"
grep -q 'function updateBalls(dt)' "$app_file" || fail "physics update missing"
grep -q 'function drawParticles()' "$app_file" || fail "particle renderer missing"
grep -q 'globalCompositeOperation = "lighter"' "$app_file" || fail "trail effect missing"
grep -q 'Canvas 手写物理 + 拖尾粒子 + 磁场可视化' "$app_file" || fail "implementation text missing"
grep -q 'canvas.addEventListener("pointerdown", handlePointerDown);' "$app_file" || fail "pointer drag handler missing"
grep -q 'window.addEventListener("keydown", handleKeyDown);' "$app_file" || fail "keyboard handler missing"
grep -q '按 F / Enter 或点击按钮重开' "$app_file" || fail "restart hint missing"
grep -q 'requestAnimationFrame(frame);' "$app_file" || fail "animation loop missing"

grep -q 'slug: "magnetic-pinball-duel"' "$index_file" || fail "showcase entry missing"
grep -q 'title: "磁力弹珠台：双人同屏对撞"' "$index_file" || fail "showcase title missing"

printf 'magnetic pinball duel smoke test passed\n'
