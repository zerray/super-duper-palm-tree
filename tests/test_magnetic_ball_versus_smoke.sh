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
grep -q '玩家 1：W / S 调角，A / D 调力度，空格发射。玩家 2：← / → 调角，↑ / ↓ 调力度，回车发射。' "$app_file" || fail "status controls missing"
grep -q 'W / S 微调底部发射角，A / D 调整力度，空格发射青色磁力弹球。' "$app_file" || fail "player 1 controls missing"
grep -q '方向键瞄准顶部发射角与力度，回车发射粉色磁力弹球。' "$app_file" || fail "player 2 controls missing"
grep -q '每回合会在中央随机生成 1 到 3 个磁力障碍物' "$app_file" || fail "random obstacle text missing"
grep -q '先到 5 分显示胜利画面' "$app_file" || fail "win condition text missing"
grep -q 'const TARGET_SCORE = 5;' "$app_file" || fail "target score constant missing"
grep -q 'const SCORE_ZONE_WIDTH = 260;' "$app_file" || fail "score zone width missing"
grep -q 'function createRoundMagnets()' "$app_file" || fail "round obstacle generator missing"
grep -q 'function applyMagneticForces(ball, dt)' "$app_file" || fail "magnet logic missing"
grep -q 'function launchBall(player)' "$app_file" || fail "launch logic missing"
grep -q 'function handleScoring(ball)' "$app_file" || fail "score logic missing"
grep -q 'function drawLauncherGuides()' "$app_file" || fail "launcher guide renderer missing"
grep -q 'function drawTrails()' "$app_file" || fail "trail renderer missing"
grep -q 'function drawMagnets()' "$app_file" || fail "magnet renderer missing"
grep -q 'function drawBalls()' "$app_file" || fail "ball renderer missing"
grep -q 'globalCompositeOperation = "lighter"' "$app_file" || fail "neon blend missing"
grep -q 'requestAnimationFrame(frame);' "$app_file" || fail "animation loop missing"

grep -q 'slug: "magnetic-ball-versus"' "$index_file" || fail "showcase entry missing"
grep -q 'title: "双人磁力弹球对战"' "$index_file" || fail "showcase title missing"
grep -q '## 双人磁力弹球对战' "$readme_file" || fail "README section missing"
grep -q '玩家 1 使用 `W / S` 调整底部发射角、`A / D` 调整力度并按空格发射' "$readme_file" || fail "README controls missing"
grep -q '固定放置至少 2 个磁力点' "$readme_file" || fail "README fixed magnets missing"
grep -q '随机生成 `1-3` 个磁力障碍物' "$readme_file" || fail "README obstacles copy missing"

printf 'magnetic ball versus smoke test passed\n'
