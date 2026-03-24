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
grep -q 'localStorage' "$app_file" || fail "localStorage missing"
grep -Eq 'AudioContext|webkitAudioContext' "$app_file" || fail "audio context missing"
grep -q 'createOscillator' "$app_file" || fail "oscillator synthesis missing"
grep -q 'createGain' "$app_file" || fail "gain node creation missing"
grep -Fq 'const LEVELS = [' "$app_file" || fail "levels config missing"
grep -q 'blockCount: 3' "$app_file" || fail "early level block count missing"
grep -q 'blockCount: 8' "$app_file" || fail "late level block count missing"
grep -q 'distractors: 1' "$app_file" || fail "distractor level missing"
grep -q '重试本关' "$app_file" || fail "retry control missing"
grep -q '重新开始' "$app_file" || fail "restart control missing"
grep -q 'rhythm-color-blocks' "$index_file" || fail "root index entry missing"
grep -q '节奏色块记忆挑战' "$index_file" || fail "root index title missing"
grep -q '节奏色块记忆挑战' "$root_dir/README.md" || fail "readme entry missing"

printf 'rhythm color blocks smoke test passed\n'
