#!/usr/bin/env bash

set -euo pipefail

root_dir="$(cd "$(dirname "$0")/.." && pwd)"
app_file="$root_dir/soundscape-garden/index.html"

fail() {
  printf 'FAIL: %s\n' "$1" >&2
  exit 1
}

[ -f "$app_file" ] || fail "soundscape-garden/index.html is missing"

grep -q 'id="garden"' "$app_file" || fail "garden svg missing"
grep -q 'const flowerTypes = \[' "$app_file" || fail "flower type registry missing"
grep -q 'Dawn Bell' "$app_file" || fail "dawn bell type missing"
grep -q 'Moss Pad' "$app_file" || fail "moss pad type missing"
grep -q 'Reed Chime' "$app_file" || fail "reed chime type missing"
grep -q 'Percussion Bloom' "$app_file" || fail "percussion bloom type missing"
grep -q 'AudioContextClass' "$app_file" || fail "audio context setup missing"
grep -q 'createStereoPanner' "$app_file" || fail "stereo panning missing"
grep -q 'createDelay' "$app_file" || fail "delay effect missing"
grep -q 'localStorage.setItem' "$app_file" || fail "localStorage persistence missing"
grep -q 'function applyProximityCoupling()' "$app_file" || fail "proximity coupling missing"
grep -q 'id="tempo-slider"' "$app_file" || fail "tempo control missing"
grep -q 'id="scale-select"' "$app_file" || fail "scale control missing"
grep -q 'id="effect-slider"' "$app_file" || fail "effect control missing"
grep -q 'contextmenu' "$app_file" || fail "flower removal interaction missing"

printf 'soundscape garden smoke test passed\n'
