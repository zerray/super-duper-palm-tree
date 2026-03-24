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
grep -q 'A / D 调整底部发射角度，W 发射' "$app_file" || fail "player 1 controls missing"
grep -q '← / → 调整顶部发射角度，↑ 发射' "$app_file" || fail "player 2 controls missing"
grep -q '让自己的弹珠穿过对方底线即可得分，60 秒结束时分高者获胜' "$app_file" || fail "win condition text missing"
grep -q 'const MATCH_DURATION = 60;' "$app_file" || fail "match timer missing"
grep -q 'goal-top' "$app_file" || fail "top goal missing"
grep -q 'goal-bottom' "$app_file" || fail "bottom goal missing"
grep -q 'const MAGNET_RANGE = 260;' "$app_file" || fail "magnet range missing"
grep -q 'const MAX_ACTIVE_MARBLES = 6;' "$app_file" || fail "marble cap missing"
grep -q 'const marbleTypes = \[' "$app_file" || fail "marble types missing"
grep -q "label: \"中性\"" "$app_file" || fail "neutral marble missing"
grep -q 'const bumpers = \[' "$app_file" || fail "bumpers missing"
grep -q 'const blockers = \[' "$app_file" || fail "blockers missing"
grep -q 'const fieldMagnets = \[' "$app_file" || fail "field magnets missing"
grep -q 'function fireShot(playerId)' "$app_file" || fail "launch logic missing"
grep -q 'function handleScoring(playerId, marble)' "$app_file" || fail "score logic missing"
grep -q 'function endMatch()' "$app_file" || fail "end match logic missing"
grep -q 'function applyMagneticForces()' "$app_file" || fail "magnet update missing"
grep -q 'function drawMagneticLinks()' "$app_file" || fail "magnetic link renderer missing"
grep -q 'Engine.update(engine, dt \* 1000);' "$app_file" || fail "physics update missing"
grep -q 'function drawParticles()' "$app_file" || fail "particle renderer missing"
grep -q 'globalCompositeOperation = "lighter"' "$app_file" || fail "trail effect missing"
grep -q '按 W / ↑ 可一键重开' "$app_file" || fail "restart hint missing"
grep -q 'requestAnimationFrame(frame);' "$app_file" || fail "animation loop missing"

grep -q 'slug: "magnetic-pinball-duel"' "$index_file" || fail "showcase entry missing"
grep -q 'title: "磁力弹珠台：双人同屏对撞"' "$index_file" || fail "showcase title missing"

printf 'magnetic pinball duel smoke test passed\n'
