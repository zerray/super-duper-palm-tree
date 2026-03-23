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
grep -q '← / → 调整角度，↑ / ↓ 调整力度，Enter 发射' "$app_file" || fail "player 2 keyboard controls missing"
grep -q '先让对方被灌入 5 颗弹珠即获胜' "$app_file" || fail "win condition text missing"
grep -q 'const LOSING_SCORE = 5;' "$app_file" || fail "losing score missing"
grep -q 'const MAGNET_STRENGTH = 130000;' "$app_file" || fail "magnet strength missing"
grep -q 'function fireCurrentPlayer()' "$app_file" || fail "shot logic missing"
grep -q 'function scoreMarble(marble, targetId)' "$app_file" || fail "score logic missing"
grep -q 'function applyMagneticForces(dt)' "$app_file" || fail "magnet update missing"
grep -q 'const samePolarity = a.polarity === b.polarity;' "$app_file" || fail "polarity interaction missing"
grep -q 'state.winner = targetId === "p1" ? players.p2.name : players.p1.name;' "$app_file" || fail "winner resolution missing"
grep -q 'event.code === "Space"' "$app_file" || fail "player 1 fire key missing"
grep -q 'event.code === "Enter"' "$app_file" || fail "player 2 fire key missing"
grep -q 'globalCompositeOperation = "lighter"' "$app_file" || fail "neon trail effect missing"
grep -q 'requestAnimationFrame(frame);' "$app_file" || fail "animation loop missing"

grep -q 'slug: "magnetic-pinball-duel"' "$index_file" || fail "showcase entry missing"
grep -q 'title: "磁力弹珠台 - 同屏双人对战"' "$index_file" || fail "showcase title missing"

printf 'magnetic pinball duel smoke test passed\n'
