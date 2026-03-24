#!/usr/bin/env bash

set -euo pipefail

root_dir="$(cd "$(dirname "$0")/.." && pwd)"
app_file="$root_dir/magnetic-pinball-arena/index.html"
index_file="$root_dir/index.html"

fail() {
  printf 'FAIL: %s\n' "$1" >&2
  exit 1
}

[ -f "$app_file" ] || fail "magnetic-pinball-arena/index.html is missing"
[ -f "$index_file" ] || fail "index.html is missing"

grep -q '<!DOCTYPE html>' "$app_file" || fail "doctype missing"
grep -q '<canvas id="game"' "$app_file" || fail "canvas missing"
grep -q 'const magneticPinballArena = (() => {' "$app_file" || fail "game module missing"
grep -q '双人磁力弹球竞技场' "$app_file" || fail "title missing"
grep -q 'WASD + 空格' "$app_file" || fail "player 1 controls missing"
grep -q '方向键 + Enter' "$app_file" || fail "player 2 controls missing"
grep -q '先到 5 分获胜' "$app_file" || fail "win condition missing"
grep -q 'const WIN_SCORE = 5;' "$app_file" || fail "win score constant missing"
grep -q 'const MAGNET_LIFETIME = 3.2;' "$app_file" || fail "magnet lifetime missing"
grep -q 'const ARENA_EVENT_INTERVAL = 4.5;' "$app_file" || fail "arena event interval missing"
grep -q 'function applyMagneticForces(dt)' "$app_file" || fail "magnetic force updater missing"
grep -q 'function placeMagnet(player)' "$app_file" || fail "magnet placement logic missing"
grep -q 'function spawnArenaEvent()' "$app_file" || fail "arena event spawner missing"
grep -q 'function awardGoal' "$app_file" || fail "goal scoring missing"
grep -q 'requestAnimationFrame(tick);' "$app_file" || fail "animation loop missing"
grep -q 'FPS ' "$app_file" || fail "fps label missing"

grep -q 'slug: "magnetic-pinball-arena"' "$index_file" || fail "showcase entry missing"
grep -q 'title: "双人磁力弹球竞技场"' "$index_file" || fail "showcase title missing"

printf 'magnetic pinball arena smoke test passed\n'
