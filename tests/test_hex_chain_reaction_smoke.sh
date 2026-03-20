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
grep -q 'const DEFAULT_BOARD_SIZE = 7;' "$app_file" || fail "default board size missing"
grep -q 'const AI_SEARCH_DEPTH = 3;' "$app_file" || fail "AI depth missing"
grep -q 'const ANIMATION_STEP_MS = 180;' "$app_file" || fail "animation timing missing"
grep -q 'function getNeighborPositions' "$app_file" || fail "neighbor logic missing"
grep -q 'function resolveChainReactionSync' "$app_file" || fail "chain reaction simulation missing"
grep -q 'function findOverflowingCells' "$app_file" || fail "overflow detection missing"
grep -q 'function minimax' "$app_file" || fail "minimax missing"
grep -q 'window.setTimeout(takeAiTurn, AI_DELAY_MS)' "$app_file" || fail "AI delay scheduling missing"
grep -q 'Chain reactions finish before the turn changes' "$app_file" || fail "rules text missing"
grep -q '<svg id="board"' "$app_file" || fail "svg board missing"

printf 'hex chain reaction smoke test passed\n'
