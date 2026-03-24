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
grep -q 'W 发射' "$app_file" || fail "player 1 fire control missing"
grep -q 'S 切换磁极' "$app_file" || fail "player 1 polarity control missing"
grep -q '↑ 发射' "$app_file" || fail "player 2 fire control missing"
grep -q '↓ 切换磁极' "$app_file" || fail "player 2 polarity control missing"
grep -q 'const WIN_SCORE = 15;' "$app_file" || fail "win score missing"
grep -q 'const K_MAGNET = 280000;' "$app_file" || fail "magnet strength missing"
grep -Fq 'K_MAGNET / (distance * distance)' "$app_file" || fail "inverse-square force formula missing"
grep -q 'function applyMagneticForces' "$app_file" || fail "magnetic force logic missing"
grep -q 'function spawnStar' "$app_file" || fail "star spawn logic missing"
grep -q 'function finishMatch' "$app_file" || fail "victory overlay missing"
grep -q 'requestAnimationFrame(tick);' "$app_file" || fail "animation loop missing"
grep -q '星星 +3' "$app_file" || fail "star bonus text missing"

size_bytes="$(wc -c < "$app_file")"
[ "$size_bytes" -gt 5000 ] || fail "game file too small to contain full implementation"

grep -q 'slug: "magnetic-marble-table"' "$index_file" || fail "showcase entry missing"
grep -q 'same-screen marble pinball duel' "$index_file" || fail "showcase description missing"

printf 'magnetic marble table smoke test passed\n'
