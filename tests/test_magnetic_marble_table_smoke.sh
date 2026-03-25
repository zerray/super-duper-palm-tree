#!/usr/bin/env bash

set -euo pipefail

root_dir="$(cd "$(dirname "$0")/.." && pwd)"
app_file="$root_dir/magnetic-marble-table/index.html"
index_file="$root_dir/index.html"

fail() {
  printf 'FAIL: %s\n' "$1" >&2
  exit 1
}

[ -f "$app_file" ] || fail "magnetic-marble-table/index.html is missing"
[ -f "$index_file" ] || fail "index.html is missing"

grep -q '<!DOCTYPE html>' "$app_file" || fail "doctype missing"
grep -q '<canvas id="game"' "$app_file" || fail "canvas missing"
grep -q 'W / S' "$app_file" || fail "player 1 angle controls missing"
grep -q 'A / D' "$app_file" || fail "player 1 power controls missing"
grep -q 'Q' "$app_file" || fail "player 1 polarity toggle missing"
grep -q 'Space' "$app_file" || fail "player 1 fire missing"
grep -q '↑ / ↓' "$app_file" || fail "player 2 angle controls missing"
grep -q '← / →' "$app_file" || fail "player 2 power controls missing"
grep -q '/' "$app_file" || fail "player 2 polarity toggle missing"
grep -q 'Enter' "$app_file" || fail "player 2 fire missing"
grep -q 'const WIN_SCORE = 5;' "$app_file" || fail "win score missing"
grep -q 'const MAGNET_STRENGTH = 360000;' "$app_file" || fail "magnet constant missing"
grep -q 'MAGNET_STRENGTH / (distance \* distance)' "$app_file" || fail "inverse-square force formula missing"
grep -q 'function applyMagneticForce' "$app_file" || fail "magnetic force update missing"
grep -q 'function togglePolarity' "$app_file" || fail "polarity toggle handler missing"
grep -q 'function fireMarble' "$app_file" || fail "launcher fire handler missing"
grep -q 'function buildObstacles' "$app_file" || fail "obstacle builder missing"
grep -q 'walls:' "$app_file" || fail "fixed wall obstacles missing"
grep -q 'bumpers:' "$app_file" || fail "bouncer obstacles missing"
grep -q 'gates:' "$app_file" || fail "rotating gate obstacles missing"
grep -q 'function collideWithGate' "$app_file" || fail "rotating gate collision missing"
grep -q 'function handleScore' "$app_file" || fail "scoring handler missing"
grep -q 'triggerShake' "$app_file" || fail "screen shake missing"
grep -q '命中己方得分区 +2' "$app_file" || fail "score zone rule missing"
grep -q '把对手弹珠撞出边界 +1' "$app_file" || fail "out of bounds rule missing"
grep -q 'resetMatch();' "$app_file" || fail "game does not auto-start"
grep -q 'requestAnimationFrame(tick);' "$app_file" || fail "animation loop missing"
grep -q '操作说明：P1 使用 WASD + Q + Space；P2 使用方向键 + / + Enter。' "$app_file" || fail "bottom instructions missing"
grep -q '点击按钮或按 R 重新开始' "$app_file" || fail "restart hint missing"

size_bytes="$(wc -c < "$app_file")"
[ "$size_bytes" -gt 5000 ] || fail "game file too small to contain full implementation"

grep -q 'slug: "magnetic-marble-table"' "$index_file" || fail "showcase entry missing"
grep -q 'two launchers' "$index_file" || fail "showcase description missing"

printf 'magnetic marble table smoke test passed\n'
