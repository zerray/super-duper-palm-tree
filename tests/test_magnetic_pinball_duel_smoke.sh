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
grep -q '鼠标或触屏左半区拖拽瞄准，松开发射' "$app_file" || fail "player 1 controls missing"
grep -q 'WASD 调整右侧发射方向，空格发射' "$app_file" || fail "player 2 controls missing"
grep -q 'const MATCH_DURATION = 60;' "$app_file" || fail "match timer missing"
grep -q 'const PICKUP_INTERVAL = 8;' "$app_file" || fail "pickup timer missing"
grep -q 'const OBSTACLE_INTERVAL = 11;' "$app_file" || fail "obstacle timer missing"
grep -q 'const ZONE_LAYOUT = \[' "$app_file" || fail "zone layout missing"
grep -q 'function beginPointerAim(event)' "$app_file" || fail "pointer aim missing"
grep -q 'function updateP2Aim(dt)' "$app_file" || fail "keyboard aim missing"
grep -q 'function createBall(player, aimX, aimY, powerScale = 1)' "$app_file" || fail "launch function missing"
grep -q 'function applyMagneticForce(ballA, ballB, dt)' "$app_file" || fail "magnetic ball force missing"
grep -q 'function trySpawnObstacle()' "$app_file" || fail "obstacle spawn missing"
grep -q 'function trySpawnPickup()' "$app_file" || fail "pickup spawn missing"
grep -q 'type: "polarity-flip"' "$app_file" || fail "polarity flip pickup missing"
grep -q 'function updateZones()' "$app_file" || fail "zone scoring missing"
grep -q 'state.scores.left = leftScore;' "$app_file" || fail "left score update missing"
grep -q 'state.scores.right = rightScore;' "$app_file" || fail "right score update missing"
grep -q 'function finishMatch()' "$app_file" || fail "match finish missing"
grep -q 'button id="restart-button"' "$app_file" || fail "restart button missing"
grep -q 'event.code === "Space"' "$app_file" || fail "keyboard restart missing"
grep -q 'requestAnimationFrame(tick);' "$app_file" || fail "animation loop missing"

grep -q 'slug: "magnetic-pinball-duel"' "$index_file" || fail "showcase entry missing"
grep -q 'title: "双人磁力弹球竞技场"' "$index_file" || fail "showcase title missing"

printf 'magnetic pinball duel smoke test passed\n'
