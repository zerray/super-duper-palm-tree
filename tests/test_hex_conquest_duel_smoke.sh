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
grep -q 'id="player-count-select"' "$app_file" || fail "player count select missing"
grep -q 'id="size-select"' "$app_file" || fail "size select missing"
grep -q 'id="restart-button"' "$app_file" || fail "restart button missing"
grep -q 'id="result-overlay"' "$app_file" || fail "result overlay missing"
grep -q 'id="ranking-list"' "$app_file" || fail "ranking list missing"
grep -q 'id="result-ranking"' "$app_file" || fail "result ranking missing"
grep -q 'const PLAYER_CONFIG = \[' "$app_file" || fail "player config missing"
grep -q 'const SPECIALS = {' "$app_file" || fail "special config missing"
grep -q 'function getNeighbors' "$app_file" || fail "neighbor logic missing"
grep -q 'function collectLegalMoves' "$app_file" || fail "legal move logic missing"
grep -q 'function applyBarrier' "$app_file" || fail "barrier logic missing"
grep -q 'function getStandings()' "$app_file" || fail "standings logic missing"
grep -q 'function finishIfNeeded' "$app_file" || fail "endgame logic missing"
grep -q '双倍扩张' "$app_file" || fail "double tile copy missing"
grep -q '防御屏障' "$app_file" || fail "barrier tile copy missing"
grep -q '2-4 人热座' "$app_file" || fail "hotseat copy missing"
grep -q '地图填满或所有玩家都没有合法落点时' "$app_file" || fail "end condition copy missing"

grep -q 'slug: "hex-conquest-duel"' "$index_file" || fail "root index card missing"

printf 'hex conquest duel smoke test passed\n'
