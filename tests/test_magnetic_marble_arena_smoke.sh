#!/usr/bin/env bash

set -euo pipefail

root_dir="$(cd "$(dirname "$0")/.." && pwd)"
app_file="$root_dir/magnetic-marble-arena/index.html"
index_file="$root_dir/index.html"

fail() {
  printf 'FAIL: %s\n' "$1" >&2
  exit 1
}

[ -f "$app_file" ] || fail "magnetic-marble-arena/index.html is missing"
[ -f "$index_file" ] || fail "index.html is missing"

grep -q '<!DOCTYPE html>' "$app_file" || fail "doctype missing"
grep -q '<canvas id="game"' "$app_file" || fail "canvas missing"
grep -q 'WASD' "$app_file" || fail "player 1 movement controls missing"
grep -q 'Q / E' "$app_file" || fail "player 1 polarity controls missing"
grep -q '方向键' "$app_file" || fail "player 2 movement controls missing"
grep -q ', / \.' "$app_file" || fail "player 2 polarity controls missing"
grep -q '单人对战 AI' "$app_file" || fail "AI mode entry missing"
grep -q 'const WIN_SCORE = 5;' "$app_file" || fail "win score missing"
grep -q 'const K_MAGNET = 280000;' "$app_file" || fail "magnet constant missing"
grep -q 'K_MAGNET / (distance \* distance)' "$app_file" || fail "inverse-square force formula missing"
grep -q 'function applyMagneticForces' "$app_file" || fail "magnetic force update missing"
grep -q 'function updateAi' "$app_file" || fail "AI logic missing"
grep -q 'function spawnObstacleSet' "$app_file" || fail "random obstacle spawn missing"
grep -q 'state.speedBoosts.length < 2' "$app_file" || fail "speed strip spawn missing"
grep -q 'state.obstacles.length < 2' "$app_file" || fail "barrier spawn missing"
grep -q 'function scoreGoal' "$app_file" || fail "goal scoring missing"
grep -q 'function finishMatch' "$app_file" || fail "victory state missing"
grep -q 'requestAnimationFrame(tick);' "$app_file" || fail "animation loop missing"

size_bytes="$(wc -c < "$app_file")"
[ "$size_bytes" -gt 5000 ] || fail "game file too small to contain full implementation"

grep -q 'slug: "magnetic-marble-arena"' "$index_file" || fail "showcase entry missing"
grep -q 'switch between attract and repel' "$index_file" || fail "showcase description not updated"

printf 'magnetic marble arena smoke test passed\n'
