#!/usr/bin/env bash

set -euo pipefail

root_dir="$(cd "$(dirname "$0")/.." && pwd)"
app_file="$root_dir/magnetic-pinball-duel/index.html"
index_file="$root_dir/index.html"

fail() {
  printf 'FAIL: %s\n' "$1" >&2
  exit 1
}

[ -f "$app_file" ] || fail "magnetic-pinball-duel/index.html is missing"
[ -f "$index_file" ] || fail "index.html is missing"

grep -q '<!DOCTYPE html>' "$app_file" || fail "doctype missing"
grep -q '<canvas id="game"' "$app_file" || fail "canvas missing"
grep -q 'const magneticPinballDuel = (() => {' "$app_file" || fail "game module missing"
grep -q 'A / D 调整角度，W / S 调整力度，空格发射' "$app_file" || fail "player 1 keyboard controls missing"
grep -q '方向键左右调整角度，方向键上下调整力度，Enter 发射' "$app_file" || fail "player 2 keyboard controls missing"
grep -q 'const WIN_SCORE = 5;' "$app_file" || fail "win score missing"
grep -q 'const POWERUP_INTERVAL = 8000;' "$app_file" || fail "powerup interval missing"
grep -q 'const MAGNET_STRENGTH = 235000;' "$app_file" || fail "magnet strength missing"
grep -q 'function goalZoneForPlayer(playerId)' "$app_file" || fail "goal zone logic missing"
grep -q 'function createMarble(playerId)' "$app_file" || fail "launch function missing"
grep -q 'function applyMagnetism(dt)' "$app_file" || fail "magnet update missing"
grep -q 'const polarityFactor = a.polarity \* b.polarity;' "$app_file" || fail "polarity interaction missing"
grep -q 'function reverseAllPolarities()' "$app_file" || fail "polarity reversal missing"
grep -q 'function startRoundReset(scoredBy)' "$app_file" || fail "round reset missing"
grep -q '玩家 1 使用 WASD + 空格，玩家 2 使用方向键 + Enter' "$app_file" || fail "intro controls missing"
grep -q 'state.score\[scoredBy\] += 1;' "$app_file" || fail "score increment missing"
grep -q 'state.score\[scoredBy\] >= WIN_SCORE' "$app_file" || fail "win condition missing"
grep -q 'event.code === "Space"' "$app_file" || fail "player 1 fire key missing"
grep -q 'event.code === "Enter"' "$app_file" || fail "player 2 fire key missing"
grep -q 'requestAnimationFrame(tick);' "$app_file" || fail "animation loop missing"

grep -q 'slug: "magnetic-pinball-duel"' "$index_file" || fail "showcase entry missing"
grep -q 'title: "双人磁力弹珠竞技场"' "$index_file" || fail "showcase title missing"

printf 'magnetic pinball duel smoke test passed\n'
