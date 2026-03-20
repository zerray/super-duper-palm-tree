#!/usr/bin/env bash

set -euo pipefail

root_dir="$(cd "$(dirname "$0")/.." && pwd)"
app_file="$root_dir/rhythm-tap/index.html"

fail() {
  printf 'FAIL: %s\n' "$1" >&2
  exit 1
}

[ -f "$app_file" ] || fail "rhythm-tap/index.html is missing"

grep -q 'id="game-stage"' "$app_file" || fail "game stage missing"
grep -q 'const lanes = \[' "$app_file" || fail "lane setup missing"
grep -q 'key: "d"' "$app_file" || fail "D lane missing"
grep -q 'key: "k"' "$app_file" || fail "K lane missing"
grep -q 'requestAnimationFrame(frame)' "$app_file" || fail "animation loop missing"
grep -q 'AudioContextClass' "$app_file" || fail "AudioContext setup missing"
grep -q 'createOscillator' "$app_file" || fail "oscillator synthesis missing"
grep -q 'state.combo = 0;' "$app_file" || fail "combo reset on miss missing"
grep -q 'state.score += 100 \* multiplier;' "$app_file" || fail "score update missing"
grep -q 'state.scrollSpeed = baseScrollSpeed + state.difficultyLevel \* 38;' "$app_file" || fail "difficulty ramp missing"
grep -q 'state.misses >= maxMisses' "$app_file" || fail "game over condition missing"
grep -q 'id="restart-button"' "$app_file" || fail "restart button missing"

printf 'rhythm tap smoke test passed\n'
