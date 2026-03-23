#!/usr/bin/env bash

set -euo pipefail

root_dir="$(cd "$(dirname "$0")/.." && pwd)"
app_file="$root_dir/rhythm-dj-coop/index.html"

fail() {
  printf 'FAIL: %s\n' "$1" >&2
  exit 1
}

[ -f "$app_file" ] || fail "rhythm-dj-coop/index.html is missing"

grep -q '<title>节奏色块：合作打碟机</title>' "$app_file" || fail "page title missing"
grep -q 'const leftKeys = \["KeyA", "KeyS", "KeyD", "KeyF"\];' "$app_file" || fail "left key bindings missing"
grep -q 'const rightKeys = \["KeyJ", "KeyK", "KeyL", "Semicolon"\];' "$app_file" || fail "right key bindings missing"
grep -q 'const perfectWindowMs = 55;' "$app_file" || fail "perfect judgment window missing"
grep -q 'const goodWindowMs = 120;' "$app_file" || fail "good judgment window missing"
grep -q 'function spawnNotesUntil(currentTime)' "$app_file" || fail "beat spawning missing"
grep -q 'function playKick()' "$app_file" || fail "kick synthesis missing"
grep -q 'createOscillator' "$app_file" || fail "Web Audio oscillator usage missing"
grep -q 'state.combo = 0;' "$app_file" || fail "combo reset logic missing"
grep -q 'modeSelect' "$app_file" || fail "single-player mode selector missing"
grep -q 'requestAnimationFrame(gameLoop);' "$app_file" || fail "animation loop missing"
grep -q 'id="game-over"' "$app_file" || fail "game over overlay missing"

printf 'rhythm dj coop smoke test passed\n'
