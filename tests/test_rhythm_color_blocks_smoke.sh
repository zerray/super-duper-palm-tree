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

grep -q '节奏色块接力' "$app_file" || fail "title missing"
grep -q 'D / F' "$app_file" || fail "left player controls missing"
grep -q 'J / K' "$app_file" || fail "right player controls missing"
grep -q 'requestAnimationFrame' "$app_file" || fail "animation loop missing"
grep -q 'GainNode' "$app_file" || fail "GainNode copy missing"
grep -q 'MISS_STREAK_THRESHOLD = 3' "$app_file" || fail "miss threshold missing"
grep -Fq 'const LEVELS = [' "$app_file" || fail "levels config missing"
grep -Fq 'colors: [0, 1, 2, 3]' "$app_file" || fail "level 3 colors missing"
grep -q 'Perfect / Good / Miss' "$app_file" || fail "judgement tiers missing"
grep -q 'createOscillator' "$app_file" || fail "oscillator synthesis missing"
grep -q 'createGain' "$app_file" || fail "gain node creation missing"
grep -q 'rhythm-color-blocks' "$index_file" || fail "root index entry missing"
grep -q '节奏色块接力' "$index_file" || fail "root index title missing"
grep -q '节奏色块接力' "$root_dir/README.md" || fail "readme entry missing"

printf 'rhythm color blocks smoke test passed\n'
