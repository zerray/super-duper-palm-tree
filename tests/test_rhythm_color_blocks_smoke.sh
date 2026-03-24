#!/usr/bin/env bash

set -euo pipefail

root_dir="$(cd "$(dirname "$0")/.." && pwd)"
app_file="$root_dir/rhythm-color-blocks/index.html"
index_file="$root_dir/index.html"

fail() {
  printf 'FAIL: %s\n' "$1" >&2
  exit 1
}

[ -f "$app_file" ] || fail "rhythm-color-blocks/index.html is missing"

grep -q 'id="playfield"' "$app_file" || fail "canvas missing"
grep -q 'const palette = \[' "$app_file" || fail "palette missing"
grep -q 'waveform: "sawtooth"' "$app_file" || fail "four waveform mapping missing"
grep -q 'pentatonicScale' "$app_file" || fail "pentatonic scale missing"
grep -q 'AudioContextClass' "$app_file" || fail "AudioContext setup missing"
grep -q 'createOscillator' "$app_file" || fail "oscillator synthesis missing"
grep -q 'random-button' "$app_file" || fail "random fill button missing"
grep -q 'clear-button' "$app_file" || fail "clear all button missing"
grep -q 'pointerdown' "$app_file" || fail "pointer interaction missing"
grep -q 'dragState.block.y' "$app_file" || fail "drag update missing"
grep -q 'rhythm-color-blocks' "$index_file" || fail "root index entry missing"

printf 'rhythm color blocks smoke test passed\n'
