#!/usr/bin/env bash

set -euo pipefail

root_dir="$(cd "$(dirname "$0")/.." && pwd)"
app_file="$root_dir/magnetic-marble-arena/index.html"
index_file="$root_dir/index.html"

fail() {
  printf 'FAIL: %s\n' "$1" >&2
  exit 1
}

[ -f "$app_file" ] || fail "magnetic-marble-arena/index.html is missing"
[ -f "$index_file" ] || fail "index.html is missing"

grep -q '<!DOCTYPE html>' "$app_file" || fail "doctype missing"
grep -q '<canvas id="game"' "$app_file" || fail "canvas missing"
grep -q 'const magneticMarbleArena = (() => {' "$app_file" || fail "game module missing"
grep -q 'WASD + 空格' "$app_file" || fail "player 1 controls missing"
grep -q '方向键 + Enter' "$app_file" || fail "player 2 controls missing"
grep -q 'A/D 切换磁极' "$app_file" || fail "player 1 polarity hint missing"
grep -q '←/→ 切换磁极' "$app_file" || fail "player 2 polarity hint missing"
grep -q '双人磁力弹珠竞技场' "$app_file" || fail "title missing"
grep -q '圆形撞柱 + 矩形反弹墙 + 三角折射板' "$app_file" || fail "obstacle text missing"
grep -q '先到 5 分者获胜' "$app_file" || fail "win condition missing"
grep -q 'const FIXED_DT = 1 / 60;' "$app_file" || fail "fixed timestep missing"
grep -q 'const WIN_SCORE = 5;' "$app_file" || fail "win score missing"
grep -q 'const mapPresets = \[' "$app_file" || fail "map presets missing"
grep -q 'applyMagneticForces(dt)' "$app_file" || fail "magnetic force update missing"
grep -q 'collideCircleWithTriangle' "$app_file" || fail "triangle collision missing"
grep -q 'collideCircleWithRect' "$app_file" || fail "rectangle collision missing"
grep -q 'collideCircleWithBumper' "$app_file" || fail "circle bumper collision missing"
grep -q 'function launchRound()' "$app_file" || fail "launch logic missing"
grep -q 'function scoreGoal' "$app_file" || fail "score logic missing"
grep -q 'requestAnimationFrame(tick);' "$app_file" || fail "animation loop missing"
grep -q 'fpsLabel.textContent' "$app_file" || fail "fps label missing"

grep -q 'slug: "magnetic-marble-arena"' "$index_file" || fail "showcase entry missing"
grep -q 'title: "双人磁力弹珠竞技场"' "$index_file" || fail "showcase title missing"

printf 'magnetic marble arena smoke test passed\n'
