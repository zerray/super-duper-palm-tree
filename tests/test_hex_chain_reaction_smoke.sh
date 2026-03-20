#!/usr/bin/env bash

set -euo pipefail

root_dir="$(cd "$(dirname "$0")/.." && pwd)"
app_file="$root_dir/hex-chain-reaction/index.html"

fail() {
  printf 'FAIL: %s\n' "$1" >&2
  exit 1
}

[ -s "$app_file" ] || fail "hex-chain-reaction/index.html is missing or empty"

grep -q '<svg id="board"' "$app_file" || fail "svg board missing"
grep -q 'const DEFAULT_BOARD_RADIUS = 7;' "$app_file" || fail "default board radius missing"
grep -q 'const HEX_DIRECTIONS = \[' "$app_file" || fail "cube direction list missing"
grep -q 'function keyForCube' "$app_file" || fail "cube key helper missing"
grep -q 'function cubeToAxial' "$app_file" || fail "cube to axial conversion missing"
grep -q 'function createBoard(radius)' "$app_file" || fail "board creation missing"
grep -q 'board: new Map()' "$app_file" || fail "map-backed board state missing"
grep -q 'function getNeighbors(cell, board = state.board)' "$app_file" || fail "neighbor lookup missing"
grep -q "cell.count > getCapacity(cell, board)" "$app_file" || fail "overflow rule missing"
grep -q 'async function resolveChainReaction()' "$app_file" || fail "chain reaction resolver missing"
grep -q 'Board radius' "$app_file" || fail "size control label missing"
grep -q 'Two-player hot-seat' "$app_file" || fail "hot-seat rules text missing"
grep -q 'New Game' "$app_file" || fail "new game button missing"
grep -q 'last player with tokens on the board' "$app_file" || fail "win condition text missing"

printf 'hex chain reaction smoke test passed\n'
