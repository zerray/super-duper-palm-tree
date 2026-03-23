#!/usr/bin/env bash

set -euo pipefail

root_dir="$(cd "$(dirname "$0")/.." && pwd)"
app_file="$root_dir/magnetic-pinball-duel/index.html"

fail() {
  printf 'FAIL: %s\n' "$1" >&2
  exit 1
}

[ -f "$app_file" ] || fail "magnetic-pinball-duel/index.html is missing"

grep -q '<canvas id="magnetic-pinball-duel-canvas"' "$app_file" || fail "canvas missing"
grep -q 'const magneticPinballDuel = (() => {' "$app_file" || fail "game module missing"
grep -q 'Player 1: W/S 调角度，A/D 切换 N/S，Space 发射' "$app_file" || fail "player 1 controls missing"
grep -q 'Player 2: ↑/↓ 调角度，←/→ 切换 N/S，Enter 发射' "$app_file" || fail "player 2 controls missing"
grep -q 'const TARGET_SCORE = 5;' "$app_file" || fail "target score missing"
grep -q 'const MAX_BALLS = 10;' "$app_file" || fail "max balls limit missing"
grep -q 'const MAGNETIC_CONSTANT = 260000;' "$app_file" || fail "magnetic constant missing"
grep -q 'function applyMagneticForces(dt)' "$app_file" || fail "ball magnetic force logic missing"
grep -q 'const q1 = a.polarity === "N" ? 1 : -1;' "$app_file" || fail "north south polarity mapping missing"
grep -q 'function drawMagneticLinks()' "$app_file" || fail "magnetic link rendering missing"
grep -q 'function scorePoint(targetSide, ball)' "$app_file" || fail "scoring logic missing"
grep -q 'state.players\[targetSide\].score += 1;' "$app_file" || fail "score increment missing"
grep -q 'function resetGame()' "$app_file" || fail "restart logic missing"
grep -q 'button id="restart-button"' "$app_file" || fail "restart button missing"
grep -q 'requestAnimationFrame(tick);' "$app_file" || fail "animation loop missing"

printf 'magnetic pinball duel smoke test passed\n'
