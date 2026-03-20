#!/usr/bin/env bash

set -euo pipefail

root_dir="$(cd "$(dirname "$0")/.." && pwd)"
app_file="$root_dir/hex-territory/index.html"

fail() {
  printf 'FAIL: %s\n' "$1" >&2
  exit 1
}

[ -f "$app_file" ] || fail "hex-territory/index.html is missing"

grep -q '<svg id="board"' "$app_file" || fail "svg board missing"
grep -q 'const CONFIG = {' "$app_file" || fail "config missing"
grep -q 'getMoveCost(col, row, owner)' "$app_file" || fail "move cost logic missing"
grep -q 'function pickAiMove()' "$app_file" || fail "AI move picker missing"
grep -q 'neighborScore: countOwnedNeighbors(col, row, "ai")' "$app_file" || fail "greedy AI heuristic missing"
grep -q 'Player jump points:' "$app_file" || fail "jump point UI missing"
grep -q 'Hex Territory Capture' "$app_file" || fail "game title missing"
grep -q 'Hover to preview whether the move is free or costs 1 point' "$app_file" || fail "hover guidance missing"

printf 'hex territory smoke test passed\n'
