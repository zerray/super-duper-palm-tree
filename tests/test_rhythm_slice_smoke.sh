#!/usr/bin/env bash

set -euo pipefail

root_dir="$(cd "$(dirname "$0")/.." && pwd)"
app_file="$root_dir/rhythm-slice/index.html"

fail() {
  printf 'FAIL: %s\n' "$1" >&2
  exit 1
}

[ -f "$app_file" ] || fail "rhythm-slice/index.html is missing"

grep -q '<canvas id="game-canvas"' "$app_file" || fail "game canvas missing"
grep -q 'const perfectWindowMs = 80;' "$app_file" || fail "perfect timing window missing"
grep -q 'const goodWindowMs = 200;' "$app_file" || fail "good timing window missing"
grep -q 'const tracks = \[' "$app_file" || fail "track metadata missing"
grep -q 'title: "Sunset Sync"' "$app_file" || fail "first built-in track missing"
grep -q 'title: "Neon Rush"' "$app_file" || fail "second built-in track missing"
grep -q 'function createBeatMap' "$app_file" || fail "beat map generator missing"
grep -q 'function scheduleTrackAudio' "$app_file" || fail "audio scheduling missing"
grep -q 'function trySliceAtSegment' "$app_file" || fail "slice detection missing"
grep -q 'function emitParticles' "$app_file" || fail "particle system missing"
grep -q 'resultCard.hidden = false;' "$app_file" || fail "results screen missing"

printf 'rhythm slice smoke test passed\n'
