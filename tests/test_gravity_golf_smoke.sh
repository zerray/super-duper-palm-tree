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
grep -q 'const levels = \[' "$app_file" || fail "level data missing"
grep -q 'name: "Final Eclipse"' "$app_file" || fail "expected fifth level missing"
grep -q 'kind: "repulsor"' "$app_file" || fail "repulsor well missing"
grep -q 'orbit:' "$app_file" || fail "orbiting well missing"
grep -q 'toggleZones:' "$app_file" || fail "gravity toggle zone missing"
grep -q 'function buildPreview(pointer)' "$app_file" || fail "trajectory preview missing"
grep -q 'function launchBall(pointer)' "$app_file" || fail "launch handling missing"
grep -q 'function computeAcceleration(ball, runtime, time)' "$app_file" || fail "gravity physics missing"
grep -q 'function finishHole()' "$app_file" || fail "hole completion missing"
grep -q 'id="hole-strokes-label"' "$app_file" || fail "hole stroke counter missing"
grep -q 'id="total-strokes-label"' "$app_file" || fail "total stroke counter missing"
grep -q 'playTone(660, 0.22, "triangle", 0.06);' "$app_file" || fail "sink audio cue missing"
grep -q 'requestAnimationFrame(frame);' "$app_file" || fail "animation loop missing"

printf 'gravity golf smoke test passed\n'
