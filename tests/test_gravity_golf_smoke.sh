#!/usr/bin/env bash

set -euo pipefail

root_dir="$(cd "$(dirname "$0")/.." && pwd)"
app_file="$root_dir/gravity-golf/index.html"

fail() {
  printf 'FAIL: %s\n' "$1" >&2
  exit 1
}

[ -f "$app_file" ] || fail "gravity-golf/index.html is missing"

grep -q '<canvas id="game"></canvas>' "$app_file" || fail "canvas missing"
grep -q 'const levelCount = 5;' "$app_file" || fail "five level configuration missing"
grep -q 'function generateLevels(count)' "$app_file" || fail "procedural level generation missing"
grep -q 'function simulateReferenceShot(setup)' "$app_file" || fail "reference trajectory solvability check missing"
grep -q 'function computeGravity(position' "$app_file" || fail "gravity physics missing"
grep -q 'function addWell(point)' "$app_file" || fail "gravity well placement missing"
grep -q 'id="strength-slider"' "$app_file" || fail "well strength slider missing"
grep -q 'function launchBall(pointer)' "$app_file" || fail "launch handling missing"
grep -q 'function updateSimulation(dt)' "$app_file" || fail "simulation loop missing"
grep -q 'function completeLevel()' "$app_file" || fail "win state missing"
grep -q 'id="strokes-label"' "$app_file" || fail "stroke counter missing"
grep -q 'id="reset-button"' "$app_file" || fail "reset button missing"
grep -q 'requestAnimationFrame(frame);' "$app_file" || fail "animation loop missing"

printf 'gravity golf smoke test passed\n'
