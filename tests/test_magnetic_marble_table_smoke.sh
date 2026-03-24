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
grep -q 'W / S 调角，Space 发射' "$app_file" || fail "player 1 control hint missing"
grep -q '↑ / ↓ 调角，Enter 发射' "$app_file" || fail "player 2 control hint missing"
grep -q 'const WIN_SCORE = 7;' "$app_file" || fail "win score missing"
grep -q 'const MIN_MAGNETS = 3;' "$app_file" || fail "minimum magnet count missing"
grep -q 'const K_MAGNET = 240000;' "$app_file" || fail "magnet strength missing"
grep -Fq 'K_MAGNET / distanceSq' "$app_file" || fail "inverse-square force formula missing"
grep -q 'function applyMagneticForce' "$app_file" || fail "magnetic force logic missing"
grep -q 'function generateMagnets' "$app_file" || fail "random magnet generation missing"
grep -q '单人模式 vs AI' "$app_file" || fail "single player mode missing"
grep -q 'function finishMatch' "$app_file" || fail "victory overlay missing"
grep -q 'requestAnimationFrame(tick);' "$app_file" || fail "animation loop missing"
grep -q '击中对方底线得分' "$app_file" || fail "goal scoring text missing"

size_bytes="$(wc -c < "$app_file")"
[ "$size_bytes" -gt 5000 ] || fail "game file too small to contain full implementation"

grep -q 'slug: "magnetic-marble-table"' "$index_file" || fail "showcase entry missing"
grep -q 'same-screen marble duel where left and right magnetic launchers fire into a central arena' "$index_file" || fail "showcase description missing"

printf 'magnetic marble table smoke test passed\n'
