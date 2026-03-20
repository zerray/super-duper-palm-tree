#!/usr/bin/env bash

set -euo pipefail

root_dir="$(cd "$(dirname "$0")/.." && pwd)"
app_file="$root_dir/pixel-synth-sequencer/index.html"

fail() {
  printf 'FAIL: %s\n' "$1" >&2
  exit 1
}

[ -f "$app_file" ] || fail "pixel-synth-sequencer/index.html is missing"

grep -q 'id="grid"' "$app_file" || fail "grid container missing"
grep -q 'const rows = 12;' "$app_file" || fail "row count missing"
grep -q 'const cols = 16;' "$app_file" || fail "column count missing"
grep -q 'const pentatonicScale =' "$app_file" || fail "pentatonic scale missing"
grep -q 'AudioContextClass = window.AudioContext || window.webkitAudioContext' "$app_file" || fail "AudioContext setup missing"
grep -q 'createOscillator' "$app_file" || fail "oscillator synthesis missing"
grep -q 'window.setInterval(tick, stepDurationMs())' "$app_file" || fail "transport interval missing"
grep -q 'id="bpm-slider"' "$app_file" || fail "BPM slider missing"
grep -q 'id="waveform-select"' "$app_file" || fail "waveform selector missing"
grep -q 'id="volume-slider"' "$app_file" || fail "volume slider missing"
grep -q 'id="clear-button"' "$app_file" || fail "clear button missing"
grep -q 'classList.add("hit")' "$app_file" || fail "cell hit feedback missing"

printf 'pixel synth sequencer smoke test passed\n'
