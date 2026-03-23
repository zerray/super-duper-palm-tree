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
grep -q 'const leftBindings = \["KeyA", "KeyS", "KeyD", "KeyF"\];' "$app_file" || fail "left player bindings missing"
grep -q 'const rightBindings = \["KeyJ", "KeyK", "KeyL", "Semicolon"\];' "$app_file" || fail "right player bindings missing"
grep -q 'const perfectWindowMs = 55;' "$app_file" || fail "perfect window missing"
grep -q 'const goodWindowMs = 130;' "$app_file" || fail "good window missing"
grep -q 'const setDurationMs = 45000;' "$app_file" || fail "set duration missing"
grep -q 'function spawnBeat(spawnTime)' "$app_file" || fail "beat spawning missing"
grep -q 'function handleLanePress(side, laneIndex, currentTime)' "$app_file" || fail "lane press handler missing"
grep -q 'function playKick()' "$app_file" || fail "kick synthesis missing"
grep -q 'function playHit(laneIndex, judgement)' "$app_file" || fail "hit synthesis missing"
grep -q 'function playMiss()' "$app_file" || fail "miss synthesis missing"
grep -q 'state.combo = 0;' "$app_file" || fail "combo reset missing"
grep -q 'state.level = 3;' "$app_file" || fail "level 3 escalation missing"
grep -q 'option value="left">单人左侧' "$app_file" || fail "single-player left mode missing"
grep -q 'option value="right">单人右侧' "$app_file" || fail "single-player right mode missing"
grep -q 'requestAnimationFrame(gameLoop)' "$app_file" || fail "animation loop missing"
grep -q 'id="game-over"' "$app_file" || fail "game over overlay missing"

printf 'rhythm dj coop smoke test passed\n'
