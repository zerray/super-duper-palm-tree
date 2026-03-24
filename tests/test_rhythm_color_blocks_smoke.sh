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

grep -q '节奏色块：回合制双人记忆对战' "$app_file" || fail "title missing"
grep -Eq 'AudioContext|webkitAudioContext' "$app_file" || fail "audio context missing"
grep -q 'createOscillator' "$app_file" || fail "oscillator synthesis missing"
grep -q 'createGain' "$app_file" || fail "gain node creation missing"
grep -q '4x4 彩色网格' "$app_file" || fail "grid copy missing"
grep -q '玩家 1 分数' "$app_file" || fail "player 1 score missing"
grep -q '玩家 2 分数' "$app_file" || fail "player 2 score missing"
grep -q 'const WIN_SCORE = 30;' "$app_file" || fail "win score missing"
grep -q 'grid-template-columns: repeat(4, minmax(0, 1fr));' "$app_file" || fail "4x4 grid styling missing"
grep -Fq 'state.sequence.push(nextRandomIndex())' "$app_file" || fail "sequence growth missing"
grep -Fq 'state.scores[opponent] += state.sequence.length' "$app_file" || fail "failure scoring missing"
grep -q '重新开始' "$app_file" || fail "restart control missing"
grep -q '再来一局' "$app_file" || fail "overlay restart missing"
grep -q 'rhythm-color-blocks' "$index_file" || fail "root index entry missing"
grep -q '节奏色块：回合制双人记忆对战' "$index_file" || fail "root index title missing"
grep -q '节奏色块：回合制双人记忆对战' "$root_dir/README.md" || fail "readme entry missing"

printf 'rhythm color blocks smoke test passed\n'
