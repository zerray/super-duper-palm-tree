#!/usr/bin/env bash

set -euo pipefail

root_dir="$(cd "$(dirname "$0")/.." && pwd)"
app_file="$root_dir/rhythm-tap/index.html"

fail() {
  printf 'FAIL: %s\n' "$1" >&2
  exit 1
}

[ -f "$app_file" ] || fail "rhythm-tap/index.html is missing"

grep -q 'id="game-board"' "$app_file" || fail "game board missing"
grep -q 'data-lane="0"' "$app_file" || fail "lane markup missing"
grep -q 'const laneConfig = \[' "$app_file" || fail "lane config missing"
grep -q 'window.requestAnimationFrame(gameLoop)' "$app_file" || fail "animation loop missing"
grep -q 'function scheduleNotes' "$app_file" || fail "procedural note generation missing"
grep -q 'function handleKeyPress' "$app_file" || fail "key handling missing"
grep -q 'state.combo' "$app_file" || fail "combo tracking missing"
grep -q 'state.score' "$app_file" || fail "score tracking missing"
grep -q 'state.misses' "$app_file" || fail "miss tracking missing"
grep -q 'new window.AudioContext()' "$app_file" || fail "Web Audio API usage missing"
grep -q 'Final score:' "$app_file" || fail "game over overlay missing"

printf 'rhythm tap smoke test passed\n'
