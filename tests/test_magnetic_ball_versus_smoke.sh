#!/usr/bin/env bash

set -euo pipefail

root_dir="$(cd "$(dirname "$0")/.." && pwd)"
app_file="$root_dir/magnetic-ball-versus/index.html"
index_file="$root_dir/index.html"
readme_file="$root_dir/README.md"

fail() {
  printf 'FAIL: %s\n' "$1" >&2
  exit 1
}

[ -f "$app_file" ] || fail "magnetic-ball-versus/index.html is missing"
[ -f "$index_file" ] || fail "index.html is missing"
[ -f "$readme_file" ] || fail "README.md is missing"

grep -q '<!DOCTYPE html>' "$app_file" || fail "doctype missing"
grep -q '<canvas id="game"' "$app_file" || fail "canvas missing"
grep -q 'const magneticBallVersus = (() => {' "$app_file" || fail "game module missing"
grep -q '双人磁力弹球对战' "$app_file" || fail "title missing"
grep -q '玩家 1 使用 W / S 移动，按住 Q 吸引、按住 E 排斥。玩家 2 使用方向键移动，按住 &lt; / &gt; 施加磁力。' "$app_file" || fail "status controls missing"
grep -q 'W / S 移动。按住 Q 吸引，按住 E 排斥。磁场持续输出 2 秒后会过热冷却。' "$app_file" || fail "player 1 controls missing"
grep -q '方向键移动。按住 &lt; / &gt; 吸引或排斥。冷却时只能等待能量条恢复。' "$app_file" || fail "player 2 controls missing"
grep -q '场地会随机刷新反转磁极、加速球、临时护盾三类道具' "$app_file" || fail "power-up text missing"
grep -q '先到 5 分获胜并显示结算画面' "$app_file" || fail "win condition text missing"
grep -q 'const TARGET_SCORE = 5;' "$app_file" || fail "target score constant missing"
grep -q 'const MAGNET_RANGE = 260;' "$app_file" || fail "magnet range missing"
grep -q 'const ENERGY_MAX = 2;' "$app_file" || fail "energy system missing"
grep -q 'const COOLDOWN_TIME = 1;' "$app_file" || fail "cooldown timing missing"
grep -q 'function applyPlayerMagnetism(ball, dt)' "$app_file" || fail "magnet logic missing"
grep -q 'function spawnPowerUp()' "$app_file" || fail "power-up spawn logic missing"
grep -q 'function applyPowerUp(type)' "$app_file" || fail "power-up effect logic missing"
grep -q 'function handleShields(ball)' "$app_file" || fail "shield logic missing"
grep -q 'function handlePlayerCollisions(ball)' "$app_file" || fail "player collision logic missing"
grep -q 'function handleScoring(ball)' "$app_file" || fail "score logic missing"
grep -q 'function drawEnergyBars()' "$app_file" || fail "energy bar renderer missing"
grep -q 'function drawTrails()' "$app_file" || fail "trail renderer missing"
grep -q 'function drawMagneticLinks()' "$app_file" || fail "field line renderer missing"
grep -q 'function drawPlayers()' "$app_file" || fail "player renderer missing"
grep -q 'globalCompositeOperation = "lighter"' "$app_file" || fail "neon blend missing"
grep -q 'requestAnimationFrame(frame);' "$app_file" || fail "animation loop missing"

grep -q 'slug: "magnetic-ball-versus"' "$index_file" || fail "showcase entry missing"
grep -q 'title: "双人磁力弹球对战"' "$index_file" || fail "showcase title missing"
grep -q '## 双人磁力弹球对战' "$readme_file" || fail "README section missing"
grep -q '玩家 1 使用 `W / S` 移动并按住 `Q / E` 吸引或排斥' "$readme_file" || fail "README controls missing"
grep -q '磁铁带有能量条' "$readme_file" || fail "README energy bar missing"
grep -q '反转磁极、加速球、临时护盾' "$readme_file" || fail "README power-up copy missing"

printf 'magnetic ball versus smoke test passed\n'
