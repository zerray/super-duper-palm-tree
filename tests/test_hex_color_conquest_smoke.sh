#!/usr/bin/env bash

set -euo pipefail

root_dir="$(cd "$(dirname "$0")/.." && pwd)"
app_file="$root_dir/hex-color-conquest/index.html"

fail() {
  printf 'FAIL: %s\n' "$1" >&2
  exit 1
}

[ -f "$app_file" ] || fail "hex-color-conquest/index.html is missing"

grep -q 'Hex Color Conquest' "$app_file" || fail "title missing"
grep -q 'const BOARD_ROWS = 7;' "$app_file" || fail "board rows missing"
grep -q 'const BOARD_COLS = 7;' "$app_file" || fail "board cols missing"
grep -q 'const PALETTE = \["#ff595e", "#ffca3a", "#8ac926", "#00bbf9", "#6a4cff", "#ff6ad5"\];' "$app_file" || fail "palette missing"
grep -q 'function applyColorChoice' "$app_file" || fail "flood fill missing"
grep -q 'function chooseAiMove()' "$app_file" || fail "AI chooser missing"
grep -q 'window.setTimeout(takeAiTurn, AI_DELAY_MS)' "$app_file" || fail "AI delay missing"
grep -q 'id="board"' "$app_file" || fail "svg board missing"
grep -q 'id="play-again-button"' "$app_file" || fail "play again button missing"
grep -q 'game ends when all hexes are claimed' "$app_file" || fail "rules text missing"
grep -q 'Create Room' "$app_file" || fail "create room action missing"
grep -q 'Join Room' "$app_file" || fail "join room action missing"
grep -q '../shared/peer-multiplayer.js' "$app_file" || fail "shared multiplayer helper missing"

printf 'hex color conquest smoke test passed\n'
