#!/usr/bin/env bash

set -euo pipefail

root_dir="$(cd "$(dirname "$0")/.." && pwd)"
app_file="$root_dir/rhythm-dj-coop/index.html"
index_file="$root_dir/index.html"

fail() {
  printf 'FAIL: %s\n' "$1" >&2
  exit 1
}

[ -f "$app_file" ] || fail "rhythm-dj-coop/index.html is missing"

grep -q 'const leftKeys = \["KeyA", "KeyS", "KeyD", "KeyF"\];' "$app_file" || fail "left key bindings missing"
grep -q 'const rightKeys = \["KeyJ", "KeyK", "KeyL", "Semicolon"\];' "$app_file" || fail "right key bindings missing"
grep -q 'const judgmentWindows = { perfect: 50, good: 120 };' "$app_file" || fail "judgment windows missing"
grep -q 'function spawnBeatBatch(beatTime)' "$app_file" || fail "beat spawning function missing"
grep -q 'function evaluateHit(side, laneIndex, eventTime)' "$app_file" || fail "hit evaluation missing"
grep -q 'function updateVisualLevel()' "$app_file" || fail "visual escalation logic missing"
grep -q 'createOscillator' "$app_file" || fail "web audio synthesis missing"
grep -q 'requestAnimationFrame(frame);' "$app_file" || fail "animation loop missing"
grep -q 'data-mode="solo-left"' "$app_file" || fail "solo left mode missing"
grep -q 'data-mode="solo-right"' "$app_file" || fail "solo right mode missing"
grep -q 'id="combo-count"' "$app_file" || fail "combo display missing"
grep -q 'id="game-over"' "$app_file" || fail "game over overlay missing"

grep -q 'slug: "rhythm-dj-coop"' "$index_file" || fail "root index entry missing"

printf 'rhythm dj coop smoke test passed\n'
