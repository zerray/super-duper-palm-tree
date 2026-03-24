#!/usr/bin/env bash

set -euo pipefail

root_dir="$(cd "$(dirname "$0")/.." && pwd)"
app_file="$root_dir/rhythm-block-clear/index.html"
index_file="$root_dir/index.html"
readme_file="$root_dir/README.md"

fail() {
  printf 'FAIL: %s\n' "$1" >&2
  exit 1
}

[ -f "$app_file" ] || fail "rhythm-block-clear/index.html is missing"

grep -q '<title>节奏方块消除</title>' "$app_file" || fail "page title missing"
grep -q 'const bpm = 120;' "$app_file" || fail "bpm constant missing"
grep -q 'const perfectWindowMs = 80;' "$app_file" || fail "perfect window missing"
grep -q 'const goodWindowMs = 150;' "$app_file" || fail "good window missing"
grep -q 'const rhythmBlockClearStorageKey = "rhythm-block-clear-best-score";' "$app_file" || fail "storage key missing"
grep -q 'const AudioContextClass = window.AudioContext || window.webkitAudioContext;' "$app_file" || fail "audio context setup missing"
grep -q 'a: { player: 0, action: "left" }' "$app_file" || fail "player 1 horizontal mapping missing"
grep -q 'q: { player: 0, action: "rotateLeft" }' "$app_file" || fail "player 1 rotate mapping missing"
grep -q 'j: { player: 1, action: "left" }' "$app_file" || fail "player 2 horizontal mapping missing"
grep -q 'u: { player: 1, action: "rotateLeft" }' "$app_file" || fail "player 2 rotate mapping missing"
grep -q 'function judgeInput(currentTime)' "$app_file" || fail "beat judgement missing"
grep -q 'function applyBonusSpace(playerIndex, lines)' "$app_file" || fail "bonus space mechanic missing"
grep -q 'function scheduleBeatSound(beatIndex, when)' "$app_file" || fail "beat sound scheduler missing"
grep -q 'function processBeat(beatTime)' "$app_file" || fail "beat fall loop missing"
grep -q 'function lockPiece(playerIndex, lockedJudgement = null)' "$app_file" || fail "piece lock flow missing"
grep -q 'requestAnimationFrame(render);' "$app_file" || fail "animation loop missing"
grep -q 'id="game-canvas"' "$app_file" || fail "canvas missing"
grep -q 'id="final-score"' "$app_file" || fail "final score output missing"
grep -q 'Perfect / Good / Miss' "$app_file" || fail "judgement copy missing"

grep -q 'slug: "rhythm-block-clear"' "$index_file" || fail "root index metadata missing"
grep -q '52 playable games' "$index_file" || fail "root game count not updated"
grep -q '## 节奏方块消除' "$readme_file" || fail "README entry missing"

printf 'rhythm block clear smoke test passed\n'
