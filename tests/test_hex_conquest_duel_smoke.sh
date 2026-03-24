#!/usr/bin/env bash

set -euo pipefail

root_dir="$(cd "$(dirname "$0")/.." && pwd)"
app_file="$root_dir/hex-conquest-duel/index.html"
index_file="$root_dir/index.html"

fail() {
  printf 'FAIL: %s\n' "$1" >&2
  exit 1
}

[ -f "$app_file" ] || fail "hex-conquest-duel/index.html is missing"

grep -q '<title>领地争夺：回合制策略涂色</title>' "$app_file" || fail "title missing"
grep -q '<svg id="hex-board"' "$app_file" || fail "svg board missing"
grep -q 'id="mode-select"' "$app_file" || fail "mode select missing"
grep -q 'id="size-select"' "$app_file" || fail "size select missing"
grep -q 'id="restart-button"' "$app_file" || fail "restart button missing"
grep -q 'id="result-overlay"' "$app_file" || fail "result overlay missing"
grep -q 'const SPECIALS = {' "$app_file" || fail "special config missing"
grep -q 'function getNeighbors' "$app_file" || fail "neighbor logic missing"
grep -q 'function collectLegalMoves' "$app_file" || fail "legal move logic missing"
grep -q 'function chooseAiMove' "$app_file" || fail "ai logic missing"
grep -q 'function finishIfNeeded' "$app_file" || fail "endgame logic missing"
grep -q '双倍扩张' "$app_file" || fail "double tile copy missing"
grep -q '窃取' "$app_file" || fail "steal tile copy missing"
grep -q '建墙' "$app_file" || fail "wall tile copy missing"
grep -q 'vs AI' "$app_file" || fail "ai mode copy missing"

grep -q 'slug: "hex-conquest-duel"' "$index_file" || fail "root index card missing"

printf 'hex conquest duel smoke test passed\n'
