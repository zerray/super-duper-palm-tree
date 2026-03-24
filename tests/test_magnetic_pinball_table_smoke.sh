#!/usr/bin/env bash

set -euo pipefail

root_dir="$(cd "$(dirname "$0")/.." && pwd)"
app_file="$root_dir/magnetic-pinball-table/index.html"
index_file="$root_dir/index.html"

fail() {
  printf 'FAIL: %s\n' "$1" >&2
  exit 1
}

[ -f "$app_file" ] || fail "magnetic-pinball-table/index.html is missing"
[ -f "$index_file" ] || fail "index.html is missing"

grep -q '<!DOCTYPE html>' "$app_file" || fail "doctype missing"
grep -q '<canvas id="game"' "$app_file" || fail "canvas missing"
grep -q 'const magneticPinballTable = (() => {' "$app_file" || fail "game module missing"
grep -q 'W / S 调整角度，A / D 调整力度，F 发射' "$app_file" || fail "player 1 controls missing"
grep -q '↑ / ↓ 调整角度，← / → 调整力度，/ 发射' "$app_file" || fail "player 2 controls missing"
grep -q 'TARGET_SCORE = 5' "$app_file" || fail "target score missing"
grep -q 'MAGNET_RANGE = 200' "$app_file" || fail "magnet range missing"
grep -q 'FIRE_COOLDOWN = 600' "$app_file" || fail "cooldown missing"
grep -q 'const targets = \[' "$app_file" || fail "targets missing"
grep -q 'const shields = \[' "$app_file" || fail "shields missing"
grep -q 'function fireMarble(playerId)' "$app_file" || fail "fire logic missing"
grep -q 'function applyMagnetForce(marble, magnet)' "$app_file" || fail "magnet logic missing"
grep -q 'function resolveShieldCollision(marble, shield)' "$app_file" || fail "shield collision missing"
grep -q 'function resolveTargetCollision(marble, target)' "$app_file" || fail "target collision missing"
grep -q 'function showVictory(playerId)' "$app_file" || fail "victory logic missing"
grep -q 'globalCompositeOperation = "lighter"' "$app_file" || fail "trail effect missing"
grep -q 'canvas.addEventListener("pointerdown", handlePointerDown);' "$app_file" || fail "pointer drag missing"
grep -q 'requestAnimationFrame(tick);' "$app_file" || fail "animation loop missing"

grep -q 'slug: "magnetic-pinball-table"' "$index_file" || fail "showcase entry missing"
grep -q 'title: "磁力弹珠台 — 同屏双人物理弹球对战"' "$index_file" || fail "showcase title missing"

printf 'magnetic pinball table smoke test passed\n'
