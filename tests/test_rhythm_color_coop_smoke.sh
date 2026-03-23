#!/usr/bin/env bash

set -euo pipefail

root_dir="$(cd "$(dirname "$0")/.." && pwd)"
app_file="$root_dir/rhythm-color-coop/index.html"

fail() {
  printf 'FAIL: %s\n' "$1" >&2
  exit 1
}

[ -f "$app_file" ] || fail "rhythm-color-coop/index.html is missing"

grep -q '<title>合作节奏染色方块</title>' "$app_file" || fail "page title missing"
grep -q 'const gridSize = 8;' "$app_file" || fail "8x8 grid configuration missing"
grep -q 'const bpm = 112;' "$app_file" || fail "fixed BPM missing"
grep -q 'const songSequence = \[' "$app_file" || fail "embedded beat sequence missing"
grep -q 'w: { player: 1, direction: "up" }' "$app_file" || fail "player 1 WASD mapping missing"
grep -q 'arrowup: { player: 2, direction: "up" }' "$app_file" || fail "player 2 arrow mapping missing"
grep -q 'perfectWindow = 70' "$app_file" || fail "perfect timing window missing"
grep -q 'goodWindow = 150' "$app_file" || fail "good timing window missing"
grep -q 'createOscillator' "$app_file" || fail "web audio synthesis missing"
grep -q 'function spawnSequenceBeat(entry)' "$app_file" || fail "beat spawning missing"
grep -q 'function judgePress(player, direction, pressedAt)' "$app_file" || fail "input judgement missing"
grep -q 'function drawMandala(now)' "$app_file" || fail "center art renderer missing"
grep -q 'requestAnimationFrame(frame);' "$app_file" || fail "animation loop missing"
grep -q 'id="final-score"' "$app_file" || fail "final score output missing"
grep -q 'Perfect / Good / Miss' "$app_file" || fail "results stats copy missing"

printf 'rhythm color coop smoke test passed\n'
