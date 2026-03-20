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
grep -q 'const levelDefinitions = \[' "$app_file" || fail "level definitions missing"
grep -q 'name: "Gravity Toggle"' "$app_file" || fail "fifth hole missing"
grep -q 'kind: "orbiting"' "$app_file" || fail "orbiting planet missing"
grep -q 'kind: "gravity-toggle"' "$app_file" || fail "gravity toggle zone missing"
grep -q 'function computeGravity(position' "$app_file" || fail "gravity physics missing"
grep -q 'function simulateShot(pointer)' "$app_file" || fail "trajectory preview missing"
grep -q 'function launchBall(pointer)' "$app_file" || fail "launch handling missing"
grep -q 'function updateSimulation(dt, elapsedSeconds)' "$app_file" || fail "simulation loop missing"
grep -q 'function sinkBall()' "$app_file" || fail "goal sink handling missing"
grep -q 'function playSinkSound()' "$app_file" || fail "audio cue missing"
grep -q 'id="strokes-label"' "$app_file" || fail "stroke counter missing"
grep -q 'id="total-label"' "$app_file" || fail "total score missing"
grep -q 'id="reset-shot"' "$app_file" || fail "reset shot button missing"
grep -q 'requestAnimationFrame(frame);' "$app_file" || fail "animation loop missing"

printf 'gravity golf smoke test passed\n'
