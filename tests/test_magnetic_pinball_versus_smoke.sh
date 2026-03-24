#!/usr/bin/env bash

set -euo pipefail

root_dir="$(cd "$(dirname "$0")/.." && pwd)"
app_file="$root_dir/magnetic-pinball-versus/index.html"
index_file="$root_dir/index.html"
readme_file="$root_dir/README.md"

fail() {
  printf 'FAIL: %s\n' "$1" >&2
  exit 1
}

[ -f "$app_file" ] || fail "magnetic-pinball-versus/index.html is missing"
[ -f "$index_file" ] || fail "index.html is missing"
[ -f "$readme_file" ] || fail "README.md is missing"

grep -q '<!DOCTYPE html>' "$app_file" || fail "doctype missing"
grep -q '<canvas id="game"' "$app_file" || fail "canvas missing"
grep -q 'const magneticPinballVersus = (() => {' "$app_file" || fail "game module missing"
grep -q '玩家 1: W / S' "$app_file" || fail "player 1 control badge missing"
grep -q '玩家 2: ↑ / ↓' "$app_file" || fail "player 2 control badge missing"
grep -q '先让对方漏球 5 次获胜' "$app_file" || fail "win condition badge missing"
grep -q 'const TARGET_SCORE = 5;' "$app_file" || fail "target score constant missing"
grep -q 'const MAGNET_RANGE = 160;' "$app_file" || fail "magnet range missing"
grep -q 'const POWERUP_INTERVAL = 6.5;' "$app_file" || fail "powerup timer missing"
grep -q 'function flipPolarity(playerIndex)' "$app_file" || fail "flip logic missing"
grep -q 'function spawnPowerup()' "$app_file" || fail "powerup spawn missing"
grep -q 'function applyMagneticForce(dt)' "$app_file" || fail "magnet force missing"
grep -q 'function handlePaddleCollisions()' "$app_file" || fail "paddle collisions missing"
grep -q 'function handleScoring()' "$app_file" || fail "scoring missing"
grep -q 'function drawTrails()' "$app_file" || fail "trail renderer missing"
grep -q 'function drawFieldLinks()' "$app_file" || fail "field line renderer missing"
grep -q 'globalCompositeOperation = "lighter"' "$app_file" || fail "particle blend missing"
grep -q 'requestAnimationFrame(frame);' "$app_file" || fail "animation loop missing"

grep -q 'slug: "magnetic-pinball-versus"' "$index_file" || fail "showcase entry missing"
grep -q 'title: "磁力弹球对战：同屏双人磁铁弹球竞技"' "$index_file" || fail "showcase title missing"
grep -q '## 磁力弹球对战：同屏双人磁铁弹球竞技' "$readme_file" || fail "README section missing"

printf 'magnetic pinball versus smoke test passed\n'
