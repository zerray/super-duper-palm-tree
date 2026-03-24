#!/usr/bin/env bash

set -euo pipefail

root_dir="$(cd "$(dirname "$0")/.." && pwd)"
app_file="$root_dir/rhythm-color-battle/index.html"
index_file="$root_dir/index.html"

fail() {
  printf 'FAIL: %s\n' "$1" >&2
  exit 1
}

[ -f "$app_file" ] || fail "rhythm-color-battle/index.html is missing"
[ -f "$index_file" ] || fail "index.html is missing"

grep -q '节奏色块大作战' "$app_file" || fail "title missing"
grep -q '单人练习' "$app_file" || fail "solo mode copy missing"
grep -q '双人热座' "$app_file" || fail "duel mode copy missing"
grep -q 'const COLORS = \[' "$app_file" || fail "color config missing"
grep -q 'frequency: 659.25' "$app_file" || fail "sixth tone missing"
grep -q 'AudioContext' "$app_file" || fail "audio context missing"
grep -q 'createOscillator' "$app_file" || fail "oscillator generation missing"
grep -q 'navigator.vibrate' "$app_file" || fail "vibration feedback missing"
grep -q 'state.phase = STATES.ADD_BLOCK;' "$app_file" || fail "add block phase missing"
grep -q 'state.sequence.push(randomIndex())' "$app_file" || fail "solo sequence growth missing"
grep -q 'state.sequence.push(index);' "$app_file" || fail "duel append missing"
grep -q 'grid-template-columns: repeat(3, minmax(0, 1fr));' "$app_file" || fail "6-block board missing"
grep -q '重新开始' "$app_file" || fail "restart control missing"
grep -q '再来一局' "$app_file" || fail "overlay restart missing"
grep -q 'rhythm-color-battle' "$index_file" || fail "root index entry missing"
grep -q '节奏色块大作战' "$index_file" || fail "root index title missing"

printf 'rhythm color battle smoke test passed\n'
