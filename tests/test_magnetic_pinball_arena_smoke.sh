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
grep -q '磁力弹珠台：双人同屏对战' "$app_file" || fail "title missing"
grep -q 'W / S 控制角度，空格发射' "$app_file" || fail "player 1 controls missing"
grep -q '↑ / ↓ 控制角度，Enter 发射' "$app_file" || fail "player 2 controls missing"
grep -q 'const GAME_DURATION = 60;' "$app_file" || fail "game duration missing"
grep -q 'const MAX_BALLS_PER_PLAYER = 3;' "$app_file" || fail "ball cap missing"
grep -q 'const OBSTACLE_REFRESH = 15;' "$app_file" || fail "obstacle refresh missing"
grep -q 'const MAGNET_RANGE = 220;' "$app_file" || fail "magnet range missing"
grep -q 'function createObstacleSet()' "$app_file" || fail "obstacle setup missing"
grep -q 'type: "deflector"' "$app_file" || fail "deflector obstacle missing"
grep -q 'type: "bumper"' "$app_file" || fail "bumper obstacle missing"
grep -q 'type: "speedStrip"' "$app_file" || fail "speed strip obstacle missing"
grep -q 'function updateFieldLines()' "$app_file" || fail "magnet line updater missing"
grep -q 'sameColor = a.ownerId === b.ownerId' "$app_file" || fail "magnet polarity logic missing"
grep -q 'function finishGame()' "$app_file" || fail "game over handler missing"
grep -q '单人挑战 AI' "$app_file" || fail "AI mode text missing"
grep -q 'const desiredAngle = Math.atan2' "$app_file" || fail "AI aiming missing"
grep -q 'requestAnimationFrame(tick);' "$app_file" || fail "animation loop missing"

grep -q 'slug: "magnetic-pinball-arena"' "$index_file" || fail "showcase entry missing"
grep -q 'title: "磁力弹珠台：双人同屏对战"' "$index_file" || fail "showcase title missing"
grep -q '## 磁力弹珠台：双人同屏对战' "$readme_file" || fail "README section missing"
grep -q 'W / S + Space' "$readme_file" || fail "README player 1 controls missing"
grep -q '↑ / ↓ + Enter' "$readme_file" || fail "README player 2 controls missing"
grep -q '`60` 秒' "$readme_file" || fail "README timer missing"

printf 'magnetic pinball arena smoke test passed\n'
