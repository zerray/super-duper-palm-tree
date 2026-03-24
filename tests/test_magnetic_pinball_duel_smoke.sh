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
grep -q 'cdnjs.cloudflare.com/ajax/libs/matter-js/0.20.0/matter.min.js' "$app_file" || fail "matter.js include missing"
grep -q 'W / S 调角度，按住空格蓄力，松开发射' "$app_file" || fail "player 1 controls missing"
grep -q '↑ / ↓ 调角度，按住 Enter 蓄力，松开发射' "$app_file" || fail "player 2 controls missing"
grep -q '玩家 1 磁极翻转' "$app_file" || fail "player 1 polarity button missing"
grep -q '玩家 2 磁极翻转' "$app_file" || fail "player 2 polarity button missing"
grep -q '让自己的弹珠滚入对方一侧的得分洞即可得分' "$app_file" || fail "win condition text missing"
grep -q 'const GAME_SECONDS = 60;' "$app_file" || fail "game timer missing"
grep -q 'const FLIP_DURATION = 4;' "$app_file" || fail "flip duration missing"
grep -q 'const MAGNET_RANGE = 260;' "$app_file" || fail "magnet range missing"
grep -q 'const MAX_ACTIVE_MARBLES = 6;' "$app_file" || fail "marble cap missing"
grep -q 'const bumpers = \[' "$app_file" || fail "bumpers missing"
grep -q 'const blockers = \[' "$app_file" || fail "blockers missing"
grep -q 'function releaseShot(playerId)' "$app_file" || fail "launch logic missing"
grep -q 'function flipPolarity(playerId)' "$app_file" || fail "polarity logic missing"
grep -q 'function handleScoring(playerId, marble)' "$app_file" || fail "score logic missing"
grep -q 'function applyMagneticForces()' "$app_file" || fail "magnet update missing"
grep -q 'Engine.update(engine, dt \* 1000);' "$app_file" || fail "physics update missing"
grep -q 'function drawParticles()' "$app_file" || fail "particle renderer missing"
grep -q 'globalCompositeOperation = "lighter"' "$app_file" || fail "trail effect missing"
grep -q 'requestAnimationFrame(frame);' "$app_file" || fail "animation loop missing"

grep -q 'slug: "magnetic-pinball-duel"' "$index_file" || fail "showcase entry missing"
grep -q 'title: "磁力弹珠台 - 同屏双人对战"' "$index_file" || fail "showcase title missing"

printf 'magnetic pinball duel smoke test passed\n'
