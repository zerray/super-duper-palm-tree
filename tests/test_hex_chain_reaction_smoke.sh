#!/usr/bin/env bash

set -euo pipefail

root_dir="$(cd "$(dirname "$0")/.." && pwd)"
app_file="$root_dir/hex-chain-reaction/index.html"

fail() {
  printf 'FAIL: %s\n' "$1" >&2
  exit 1
}

[ -f "$app_file" ] || fail "hex-chain-reaction/index.html is missing"

grep -q 'Hex Chain Reaction' "$app_file" || fail "title missing"
grep -q 'const DEFAULT_GRID_SIZE = 7;' "$app_file" || fail "default grid size missing"
grep -q 'const ANIMATION_STEP_MS = 180;' "$app_file" || fail "animation timing missing"
grep -q 'gridSize: DEFAULT_GRID_SIZE' "$app_file" || fail "configurable grid size state missing"
grep -q 'board: new Map()' "$app_file" || fail "Map-backed board state missing"
grep -q 'function offsetToAxial' "$app_file" || fail "axial conversion missing"
grep -q 'function getNeighborsFromBoard' "$app_file" || fail "neighbor lookup missing"
grep -q 'cell.count > getNeighborCount(cell, board)' "$app_file" || fail "overflow threshold missing"
grep -q 'id="sizeSelect"' "$app_file" || fail "board size control missing"
grep -q 'Human vs AI' "$app_file" || fail "ai match copy missing"
grep -q 'function chooseGreedyAiMove' "$app_file" || fail "greedy ai missing"
grep -q 'simulateCascade(boardCopy, PLAYER_TWO);' "$app_file" || fail "ai full cascade simulation missing"
grep -q 'async function resolveChainReaction' "$app_file" || fail "animated chain reaction missing"
grep -q 'AI think time' "$app_file" || fail "ai timing badge missing"
grep -q 'New Game' "$app_file" || fail "restart control missing"
grep -q 'Move:' "$app_file" || fail "move counter missing"
grep -q 'Take turns placing tokens on a hex grid' "$app_file" || fail "rules copy missing"
grep -q 'controls all occupied cells after the final cascade' "$app_file" || fail "win condition text missing"

printf 'hex chain reaction smoke test passed\n'
