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
grep -q 'WASD 移动磁铁，Q 切换吸引，E 切换排斥' "$app_file" || fail "player 1 controls missing"
grep -q '方向键移动磁铁，逗号切换吸引，句号切换排斥' "$app_file" || fail "player 2 controls missing"
grep -q 'const TARGET_SCORE = 7;' "$app_file" || fail "target score missing"
grep -q 'const OBSTACLE_INTERVAL = 10;' "$app_file" || fail "obstacle timer missing"
grep -q 'const PICKUP_INTERVAL = 14;' "$app_file" || fail "pickup timer missing"
grep -q 'function applyMagneticForce(player, dt)' "$app_file" || fail "magnet force logic missing"
grep -q 'function trySpawnObstacle()' "$app_file" || fail "obstacle spawn missing"
grep -q 'function trySpawnPickup()' "$app_file" || fail "pickup spawn missing"
grep -q 'function awardPoint(playerKey)' "$app_file" || fail "scoring function missing"
grep -q 'state.players\[playerKey\].score += 1;' "$app_file" || fail "score increment missing"
grep -q 'awardPoint("right");' "$app_file" || fail "right-side scoring missing"
grep -q 'awardPoint("left");' "$app_file" || fail "left-side scoring missing"
grep -q 'button id="restart-button"' "$app_file" || fail "restart button missing"
grep -q 'event.code === "Space"' "$app_file" || fail "keyboard restart missing"
grep -q 'requestAnimationFrame(tick);' "$app_file" || fail "animation loop missing"

grep -q 'slug: "magnetic-pinball-duel"' "$index_file" || fail "showcase entry missing"
grep -q 'title: "磁力弹珠台：双人同屏对战"' "$index_file" || fail "showcase title missing"

printf 'magnetic pinball duel smoke test passed\n'
