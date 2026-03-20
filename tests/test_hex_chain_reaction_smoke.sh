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
grep -q 'const ANIMATION_STEP_MS = 240;' "$app_file" || fail "animation timing missing"
grep -q 'board: new Map()' "$app_file" || fail "Map-backed board state missing"
grep -q 'gridSize: DEFAULT_GRID_SIZE' "$app_file" || fail "configurable grid state missing"
grep -q 'function offsetToAxial' "$app_file" || fail "axial conversion missing"
grep -q 'function getNeighbors' "$app_file" || fail "neighbor lookup missing"
grep -q 'cell.count > getNeighborCount(cell)' "$app_file" || fail "overflow threshold missing"
grep -q 'async function resolveChainReaction' "$app_file" || fail "animated chain reaction missing"
grep -q 'id="sizeSelect"' "$app_file" || fail "grid size control missing"
grep -q 'Moves: <span id="moveCount">0</span>' "$app_file" || fail "move counter missing"
grep -q 'Restart Match' "$app_file" || fail "restart control missing"
grep -q 'Two players alternate on a compact hex grid' "$app_file" || fail "rules copy missing"
grep -q 'controls all occupied cells after the final cascade' "$app_file" || fail "win condition text missing"

printf 'hex chain reaction smoke test passed\n'
