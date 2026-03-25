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
grep -q '玩家 1: W / S 移动 + Q 切极' "$app_file" || fail "player 1 control badge missing"
grep -q '玩家 2: ↑ / ↓ 移动 + / 切极' "$app_file" || fail "player 2 control badge missing"
grep -q '单人 vs AI' "$app_file" || fail "ai mode button missing"
grep -q '先到 7 分获胜' "$app_file" || fail "win condition badge missing"
grep -q 'const TARGET_SCORE = 7;' "$app_file" || fail "target score constant missing"
grep -q 'const MAGNET_RANGE = 210;' "$app_file" || fail "magnet range missing"
grep -q 'const POWERUP_INTERVAL = 5.2;' "$app_file" || fail "powerup timer missing"
grep -q 'const OBSTACLE_DURATION = 5;' "$app_file" || fail "obstacle duration missing"
grep -q 'function togglePolarity(playerIndex)' "$app_file" || fail "toggle logic missing"
grep -q 'function spawnPowerup()' "$app_file" || fail "powerup spawn missing"
grep -q 'function spawnObstacle()' "$app_file" || fail "obstacle spawn missing"
grep -q 'function applyMagneticForce(dt)' "$app_file" || fail "magnet force missing"
grep -q 'function handlePaddleCollisions()' "$app_file" || fail "paddle collisions missing"
grep -q 'function applyPowerup(type)' "$app_file" || fail "powerup application missing"
grep -q 'function handleScoring()' "$app_file" || fail "scoring missing"
grep -q 'function drawTrails()' "$app_file" || fail "trail renderer missing"
grep -q 'function drawFieldLinks()' "$app_file" || fail "field line renderer missing"
grep -q 'function drawObstacle()' "$app_file" || fail "obstacle renderer missing"
grep -q 'globalCompositeOperation = "lighter"' "$app_file" || fail "particle blend missing"
grep -q 'requestAnimationFrame(frame);' "$app_file" || fail "animation loop missing"
grep -q 'setMode("ai")' "$app_file" || fail "ai mode setup missing"

grep -q 'slug: "magnetic-pinball-versus"' "$index_file" || fail "showcase entry missing"
grep -q 'title: "磁力弹球对战：同屏双人磁铁弹球竞技"' "$index_file" || fail "showcase title missing"
grep -q 'race to seven' "$index_file" || fail "showcase description not updated"
grep -q '## 磁力弹球对战：同屏双人磁铁弹球竞技' "$readme_file" || fail "README section missing"
grep -q '支持单人 `vs AI` 模式' "$readme_file" || fail "README AI mode missing"
grep -q '先到 7 分显示胜利画面' "$readme_file" || fail "README win condition missing"

printf 'magnetic pinball versus smoke test passed\n'
