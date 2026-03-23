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
grep -q 'matter.min.js' "$app_file" || fail "Matter.js CDN missing"
grep -q 'const magneticPinballDuel = (() => {' "$app_file" || fail "game module missing"
grep -q 'Player 1: WASD 调角，空格发射' "$app_file" || fail "player 1 controls missing"
grep -q 'Player 2: 方向键调角，Enter 发射' "$app_file" || fail "player 2 controls missing"
grep -q 'const TARGET_SCORE = 9;' "$app_file" || fail "target score missing"
grep -q 'const BALL_TYPES = \[' "$app_file" || fail "ball types missing"
grep -q 'label: "±"' "$app_file" || fail "bipolar marble missing"
grep -q 'const SCORE_ZONES = \[' "$app_file" || fail "score zones missing"
grep -q 'function applyMagnetism(dt)' "$app_file" || fail "magnetism logic missing"
grep -q 'function handleScoreZoneCollision(zoneIndex, marble)' "$app_file" || fail "score zone logic missing"
grep -q 'function scorePoint(playerKey, marble, amount)' "$app_file" || fail "scoring logic missing"
grep -q 'state.players\[playerKey\].score += amount;' "$app_file" || fail "score increment missing"
grep -q 'scorePoint("right", marble, 3);' "$app_file" || fail "right-side goal scoring missing"
grep -q 'scorePoint("left", marble, 3);' "$app_file" || fail "left-side goal scoring missing"
grep -q 'button id="restart-button"' "$app_file" || fail "restart button missing"
grep -q 'event.code === "Space" || event.code === "Enter"' "$app_file" || fail "keyboard restart missing"
grep -q 'requestAnimationFrame(tick);' "$app_file" || fail "animation loop missing"

grep -q 'slug: "magnetic-pinball-duel"' "$index_file" || fail "showcase entry missing"
grep -q 'title: "磁力弹珠台：双人同屏对战"' "$index_file" || fail "showcase title missing"

printf 'magnetic pinball duel smoke test passed\n'
