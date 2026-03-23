#!/usr/bin/env bash

set -euo pipefail

root_dir="$(cd "$(dirname "$0")/.." && pwd)"
app_file="$root_dir/magnetic-pinball-duel/index.html"

fail() {
  printf 'FAIL: %s\n' "$1" >&2
  exit 1
}

[ -f "$app_file" ] || fail "magnetic-pinball-duel/index.html is missing"

grep -q '<canvas id="magnetic-duel-canvas"' "$app_file" || fail "canvas missing"
grep -q 'const magneticPinballDuel = (() => {' "$app_file" || fail "game module missing"
grep -q 'const MATCH_DURATION = 60;' "$app_file" || fail "match duration missing"
grep -q 'const marbleTypes = \[' "$app_file" || fail "marble type rotation missing"
grep -q 'charge: 2' "$app_file" || fail "third pole type missing"
grep -q 'A/D 调整角度，空格发射' "$app_file" || fail "player 1 controls missing"
grep -q '←/→ 调整角度，Enter 发射' "$app_file" || fail "player 2 controls missing"
grep -q 'function applyMagneticForces(dt)' "$app_file" || fail "magnetic force logic missing"
grep -q 'state.scores.left += 1;' "$app_file" || fail "left scoring missing"
grep -q 'state.scores.right += 1;' "$app_file" || fail "right scoring missing"
grep -q '低分获胜' "$app_file" || fail "inverted win condition copy missing"
grep -q 'function drawFieldLines()' "$app_file" || fail "field line rendering missing"
grep -q 'function drawParticles()' "$app_file" || fail "particle rendering missing"
grep -q 'requestAnimationFrame(tick);' "$app_file" || fail "animation loop missing"

printf 'magnetic pinball duel smoke test passed\n'
