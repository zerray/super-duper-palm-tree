#!/usr/bin/env bash

set -euo pipefail

root_dir="$(cd "$(dirname "$0")/.." && pwd)"
app_file="$root_dir/magnetic-pong/index.html"

fail() {
  printf 'FAIL: %s\n' "$1" >&2
  exit 1
}

[ -f "$app_file" ] || fail "magnetic-pong/index.html is missing"

grep -q '<title>磁力乒乓</title>' "$app_file" || fail "title missing"
grep -q '<canvas id="magnetic-pong-canvas"' "$app_file" || fail "canvas missing"
grep -q 'const magneticPong = (() => {' "$app_file" || fail "game module missing"
grep -q 'const CENTER_FIELD_FORCE = 155000;' "$app_file" || fail "center field force missing"
grep -q 'const WIN_SCORE = 7;' "$app_file" || fail "win score missing"
grep -q 'function applyPlayerMagnet(dt, side, mode)' "$app_file" || fail "player magnet logic missing"
grep -q 'function applyCenterField(dt)' "$app_file" || fail "center field logic missing"
grep -q 'state.mode = "1p";' "$app_file" || fail "single-player mode missing"
grep -q 'state.mode = "2p";' "$app_file" || fail "two-player mode missing"
grep -q 'AI_REACTION = 0.09' "$app_file" || fail "ai tuning missing"
grep -q 'Q 吸引, E 排斥' "$app_file" || fail "left controls missing"
grep -q '右侧: ↑ / ↓ 移动' "$app_file" || fail "right movement controls missing"
grep -q 'BracketLeft' "$app_file" || fail "right attract key binding missing"
grep -q 'BracketRight' "$app_file" || fail "right repel key binding missing"
grep -q 'requestAnimationFrame(tick);' "$app_file" || fail "animation loop missing"

printf 'magnetic pong smoke test passed\n'
