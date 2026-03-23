#!/usr/bin/env bash

set -euo pipefail

root_dir="$(cd "$(dirname "$0")/.." && pwd)"
app_file="$root_dir/pixel-territory/index.html"
index_file="$root_dir/index.html"

fail() {
  printf 'FAIL: %s\n' "$1" >&2
  exit 1
}

[ -f "$app_file" ] || fail "pixel-territory/index.html is missing"

grep -q 'id="board"' "$app_file" || fail "board element missing"
grep -q 'const BOARD_SIZE = 12;' "$app_file" || fail "board size missing"
grep -q 'const WIN_THRESHOLD = 72;' "$app_file" || fail "win threshold missing"
grep -q 'function floodExpand' "$app_file" || fail "flood fill missing"
grep -q 'function chooseAiMove()' "$app_file" || fail "AI chooser missing"
grep -q 'window.setTimeout(() => {' "$app_file" || fail "AI delay missing"
grep -q '双人热座' "$app_file" || fail "hotseat mode text missing"
grep -q 'vs AI' "$app_file" || fail "AI mode text missing"
grep -q 'BFS flood-fill' "$app_file" || fail "rules text missing"

grep -q 'slug: "pixel-territory"' "$index_file" || fail "root index entry missing"

printf 'pixel territory smoke test passed\n'
