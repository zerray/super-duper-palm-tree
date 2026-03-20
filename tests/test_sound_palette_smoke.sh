#!/usr/bin/env bash

set -euo pipefail

root_dir="$(cd "$(dirname "$0")/.." && pwd)"
app_file="$root_dir/sound-palette/index.html"

fail() {
  printf 'FAIL: %s\n' "$1" >&2
  exit 1
}

[ -f "$app_file" ] || fail "sound-palette/index.html is missing"

grep -q 'id="grid"' "$app_file" || fail "grid container missing"
grep -q 'const rows = 8;' "$app_file" || fail "row count missing"
grep -q 'const cols = 8;' "$app_file" || fail "column count missing"
grep -q 'new AudioContextClass()' "$app_file" || fail "AudioContext setup missing"
grep -q 'createOscillator' "$app_file" || fail "oscillator synthesis missing"
grep -q 'setInterval(advanceStep, stepIntervalMs())' "$app_file" || fail "looping transport missing"
grep -q 'id="bpm-slider"' "$app_file" || fail "BPM slider missing"
grep -q 'id="clear-button"' "$app_file" || fail "clear button missing"
grep -q 'pentatonicScale' "$app_file" || fail "pentatonic scale missing"
grep -q 'classList.add("pulse")' "$app_file" || fail "pulse animation missing"

printf 'sound palette smoke test passed\n'
