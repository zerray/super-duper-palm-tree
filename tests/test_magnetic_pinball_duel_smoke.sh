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
grep -q 'A/D 调整角度，W 发射' "$app_file" || fail "player 1 keyboard controls missing"
grep -q '方向键左右调整角度，上方向键发射' "$app_file" || fail "player 2 keyboard controls missing"
grep -q '左右半屏分别控制两位玩家' "$app_file" || fail "touch control hint missing"
grep -q 'const SHOTS_PER_PLAYER = 10;' "$app_file" || fail "shot limit missing"
grep -q 'const MAGNET_STRENGTH = 180000;' "$app_file" || fail "magnet strength missing"
grep -q 'const KILL_MARGIN = 50;' "$app_file" || fail "out of bounds margin missing"
grep -q 'const ZONES = \[' "$app_file" || fail "scoring zones missing"
grep -q 'function createBall(playerId, directionX, directionY)' "$app_file" || fail "launch function missing"
grep -q 'function applyMagnetism(dt)' "$app_file" || fail "magnet update missing"
grep -q 'const sameColor = a.owner === b.owner;' "$app_file" || fail "same color polarity logic missing"
grep -q 'state.penalties\[ball.owner\] += 1;' "$app_file" || fail "out of bounds penalty missing"
grep -q 'function finishGame()' "$app_file" || fail "finish game missing"
grep -q '玩家 1 获胜' "$app_file" || fail "winner text missing"
grep -q '玩家 2 获胜' "$app_file" || fail "winner text missing"
grep -q '平局' "$app_file" || fail "draw text missing"
grep -q 'function onPointerDown(event)' "$app_file" || fail "pointer control missing"
grep -q 'function onPointerUp(event)' "$app_file" || fail "pointer release missing"
grep -q 'event.code === "KeyW"' "$app_file" || fail "player 1 fire key missing"
grep -q 'event.code === "ArrowUp"' "$app_file" || fail "player 2 fire key missing"
grep -q 'requestAnimationFrame(tick);' "$app_file" || fail "animation loop missing"

grep -q 'slug: "magnetic-pinball-duel"' "$index_file" || fail "showcase entry missing"
grep -q 'title: "磁力弹珠对战台"' "$index_file" || fail "showcase title missing"

printf 'magnetic pinball duel smoke test passed\n'
