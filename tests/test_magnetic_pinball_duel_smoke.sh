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
grep -q 'A / D 调整角度，W 锁定发射' "$app_file" || fail "player 1 keyboard controls missing"
grep -q '← / → 调整角度，↑ 锁定发射' "$app_file" || fail "player 2 keyboard controls missing"
grep -q '单人练习' "$app_file" || fail "practice mode missing"
grep -q 'const TOTAL_ROUNDS = 10;' "$app_file" || fail "round limit missing"
grep -q 'const MAGNET_STRENGTH = 175000;' "$app_file" || fail "magnet strength missing"
grep -q 'function queueShot(playerId)' "$app_file" || fail "shot queue missing"
grep -q 'function scoreMarble(marble)' "$app_file" || fail "score logic missing"
grep -q 'function applyMagneticForces(dt)' "$app_file" || fail "magnet update missing"
grep -q 'const polarityFactor = a.polarity \* b.polarity;' "$app_file" || fail "polarity interaction missing"
grep -q 'function finishGame()' "$app_file" || fail "finish flow missing"
grep -q '10 回合结束' "$app_file" || fail "final overlay missing"
grep -q 'event.code === "KeyW"' "$app_file" || fail "player 1 fire key missing"
grep -q 'event.code === "ArrowUp"' "$app_file" || fail "player 2 fire key missing"
grep -q 'globalCompositeOperation = "lighter"' "$app_file" || fail "neon trail effect missing"
grep -q 'requestAnimationFrame(frame);' "$app_file" || fail "animation loop missing"

grep -q 'slug: "magnetic-pinball-duel"' "$index_file" || fail "showcase entry missing"
grep -q 'title: "磁力弹珠台 - 同屏双人对战"' "$index_file" || fail "showcase title missing"

printf 'magnetic pinball duel smoke test passed\n'
