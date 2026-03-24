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

grep -q '节奏色块记忆挑战' "$app_file" || fail "title missing"
grep -q '热座双人' "$app_file" || fail "versus mode copy missing"
grep -q 'const BASE_BPM = 92' "$app_file" || fail "base bpm missing"
grep -q 'const START_LENGTH = 3' "$app_file" || fail "start length missing"
grep -q 'const INPUT_WINDOW_RATIO = 0.92' "$app_file" || fail "beat input window missing"
grep -q 'mulberry32' "$app_file" || fail "seeded rng missing"
grep -q 'window.AudioContext || window.webkitAudioContext' "$app_file" || fail "audio setup missing"
grep -q 'createOscillator' "$app_file" || fail "oscillator synthesis missing"
grep -q 'data-mode="versus"' "$app_file" || fail "versus mode button missing"
grep -q 'data-pad="3"' "$app_file" || fail "pad grid missing"
grep -q 'startInputPhase' "$app_file" || fail "input phase logic missing"
grep -q 'compareScores' "$app_file" || fail "versus scoring missing"
grep -q 'rhythm-color-blocks' "$index_file" || fail "root index entry missing"
grep -q '节奏色块记忆挑战' "$index_file" || fail "root index title missing"
grep -q '节奏色块记忆挑战' "$root_dir/README.md" || fail "readme entry missing"

printf 'rhythm color blocks smoke test passed\n'
