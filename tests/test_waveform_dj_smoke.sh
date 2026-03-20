#!/usr/bin/env bash

set -euo pipefail

root_dir="$(cd "$(dirname "$0")/.." && pwd)"
app_file="$root_dir/waveform-dj/index.html"

fail() {
  printf 'FAIL: %s\n' "$1" >&2
  exit 1
}

[ -f "$app_file" ] || fail "waveform-dj/index.html is missing"

grep -q '<html' "$app_file" || fail "html tag missing"
grep -q '</html>' "$app_file" || fail "closing html tag missing"
grep -q 'AudioContextClass' "$app_file" || fail "AudioContext setup missing"
grep -q 'createOscillator' "$app_file" || fail "oscillator generation missing"
grep -q 'createAnalyser' "$app_file" || fail "analyser setup missing"
grep -q 'waveformTypes = \["sine", "square", "sawtooth", "triangle"\]' "$app_file" || fail "required oscillator types missing"
grep -q 'id="patch-board"' "$app_file" || fail "patch board missing"
grep -q 'localStorage' "$app_file" || fail "preset persistence missing"
grep -q 'id="mute-toggle"' "$app_file" || fail "mute toggle missing"
grep -q 'requestAnimationFrame(animationLoop)' "$app_file" || fail "visualization loop missing"

printf 'waveform dj smoke test passed\n'
