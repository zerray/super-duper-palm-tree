#!/usr/bin/env bash

set -euo pipefail

root_dir="$(cd "$(dirname "$0")/.." && pwd)"
app_file="$root_dir/pixel-pulse-sequencer/index.html"

fail() {
  printf 'FAIL: %s\n' "$1" >&2
  exit 1
}

[ -f "$app_file" ] || fail "pixel-pulse-sequencer/index.html is missing"

grep -q 'id="grid"' "$app_file" || fail "grid container missing"
grep -q 'const rows = 8;' "$app_file" || fail "row count missing"
grep -q 'const cols = 16;' "$app_file" || fail "column count missing"
grep -q 'AudioContextClass' "$app_file" || fail "AudioContext setup missing"
grep -q 'scheduleWindow' "$app_file" || fail "look-ahead scheduler missing"
grep -q 'createOscillator' "$app_file" || fail "oscillator tone synthesis missing"
grep -q 'createBufferSource' "$app_file" || fail "noise percussion synthesis missing"
grep -q 'id="bpm-slider"' "$app_file" || fail "BPM slider missing"
grep -q 'id="waveform-select"' "$app_file" || fail "waveform control missing"
grep -q 'id="theme-select"' "$app_file" || fail "theme control missing"
grep -q 'id="clear-button"' "$app_file" || fail "clear button missing"
grep -q 'classList.add("hit")' "$app_file" || fail "pulse animation missing"

printf 'pixel pulse sequencer smoke test passed\n'
