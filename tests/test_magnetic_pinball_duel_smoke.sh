#!/usr/bin/env bash

set -euo pipefail

root_dir="$(cd "$(dirname "$0")/.." && pwd)"
app_file="$root_dir/magnetic-pinball-duel/index.html"

fail() {
  printf 'FAIL: %s\n' "$1" >&2
  exit 1
}

[ -f "$app_file" ] || fail "magnetic-pinball-duel/index.html is missing"

grep -q '<canvas id="magnetic-duel-canvas"' "$app_file" || fail "canvas missing"
grep -q 'const magneticPinballDuel = (() => {' "$app_file" || fail "game module missing"
grep -q 'W/S 移动，按住 Q 激活磁力' "$app_file" || fail "player 1 controls missing"
grep -q '↑/↓ 移动，按住 / 激活磁力' "$app_file" || fail "player 2 controls missing"
grep -q 'const TARGET_SCORE = 5;' "$app_file" || fail "target score missing"
grep -q 'const powerupTypes = {' "$app_file" || fail "powerup definitions missing"
grep -q 'speed: { key: "speed"' "$app_file" || fail "speed powerup missing"
grep -q 'split: { key: "split"' "$app_file" || fail "split powerup missing"
grep -q 'function applyMagnetForce(ball, paddle, dt)' "$app_file" || fail "magnet force logic missing"
grep -q 'state.paddles.right.score += 1;' "$app_file" || fail "right score increment missing"
grep -q 'state.paddles.left.score += 1;' "$app_file" || fail "left score increment missing"
grep -q 'resetMatch("ai")' "$app_file" || fail "AI mode start missing"
grep -q 'function updateAiPaddle(dt)' "$app_file" || fail "AI paddle logic missing"
grep -q 'function drawFieldLines()' "$app_file" || fail "field line rendering missing"
grep -q 'function drawParticles()' "$app_file" || fail "particle rendering missing"
grep -q 'requestAnimationFrame(tick);' "$app_file" || fail "animation loop missing"

printf 'magnetic pinball duel smoke test passed\n'
