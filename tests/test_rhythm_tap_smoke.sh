#!/usr/bin/env bash

set -euo pipefail

root_dir="$(cd "$(dirname "$0")/.." && pwd)"
app_file="$root_dir/rhythm-tap/index.html"

fail() {
  printf 'FAIL: %s\n' "$1" >&2
  exit 1
}

[ -f "$app_file" ] || fail "rhythm-tap/index.html is missing"

grep -q 'const laneKeys = \["KeyD", "KeyF", "KeyJ", "KeyK"\];' "$app_file" || fail "lane key bindings missing"
grep -q 'requestAnimationFrame(gameLoop)' "$app_file" || fail "animation loop missing"
grep -q 'function spawnNotesUntil(currentTime)' "$app_file" || fail "procedural note spawning missing"
grep -q 'const hitWindowMs = 110;' "$app_file" || fail "hit timing window missing"
grep -q 'function handleLanePress(laneIndex)' "$app_file" || fail "input handler missing"
grep -q 'createOscillator' "$app_file" || fail "audio synthesis missing"
grep -q 'state.combo = 0;' "$app_file" || fail "combo reset logic missing"
grep -q 'state.score += 100 \* getMultiplier();' "$app_file" || fail "score update missing"
grep -q 'state.speed = 1 + level \* 0.12;' "$app_file" || fail "difficulty ramp missing"
grep -q 'const maxMisses = 10;' "$app_file" || fail "miss limit missing"
grep -q 'id="game-over"' "$app_file" || fail "game over overlay missing"

printf 'rhythm tap smoke test passed\n'
