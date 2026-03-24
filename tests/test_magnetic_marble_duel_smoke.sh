#!/usr/bin/env bash

set -euo pipefail

root_dir="$(cd "$(dirname "$0")/.." && pwd)"
app_file="$root_dir/magnetic-marble-duel/index.html"
index_file="$root_dir/index.html"
readme_file="$root_dir/README.md"

fail() {
  printf 'FAIL: %s\n' "$1" >&2
  exit 1
}

[ -f "$app_file" ] || fail "magnetic-marble-duel/index.html is missing"
[ -f "$index_file" ] || fail "index.html is missing"
[ -f "$readme_file" ] || fail "README.md is missing"

grep -q '<!DOCTYPE html>' "$app_file" || fail "doctype missing"
grep -q '<canvas id="game"' "$app_file" || fail "canvas missing"
grep -q 'const magneticMarbleDuel = (() => {' "$app_file" || fail "game module missing"
grep -q '磁力弹珠双人对战台' "$app_file" || fail "title missing"
grep -q 'WASD + 空格' "$app_file" || fail "player 1 controls missing"
grep -q '方向键 + Enter' "$app_file" || fail "player 2 controls missing"
grep -q '先到 5 分获胜' "$app_file" || fail "target score text missing"
grep -q 'const FIXED_DT = 1 / 60;' "$app_file" || fail "fixed timestep missing"
grep -q 'const TARGET_SCORE = 5;' "$app_file" || fail "target score constant missing"
grep -q 'const MAGNET_RANGE = 220;' "$app_file" || fail "magnet range missing"
grep -q 'const BOARD_CONFIG = {' "$app_file" || fail "board config missing"
grep -q 'const tableBounds = {' "$app_file" || fail "table bounds missing"
grep -q 'magnetBoost' "$app_file" || fail "magnet boost zone missing"
grep -q 'repulsePulse' "$app_file" || fail "repulse field missing"
grep -q 'slowZone' "$app_file" || fail "slow zone missing"
grep -q 'const goals = \[' "$app_file" || fail "goal zones missing"
grep -q 'function fireTurn()' "$app_file" || fail "launch logic missing"
grep -q 'function applyMagneticForces(dt)' "$app_file" || fail "magnet logic missing"
grep -q 'function applyFieldEffects(dt)' "$app_file" || fail "field effect logic missing"
grep -q 'function resolveMarbleCollisions()' "$app_file" || fail "collision logic missing"
grep -q 'function handleGoals()' "$app_file" || fail "goal scoring logic missing"
grep -q 'function checkTurnEnd()' "$app_file" || fail "turn flow missing"
grep -q 'showOverlay(' "$app_file" || fail "turn overlay missing"
grep -q 'drawMagnetLinks()' "$app_file" || fail "magnetic effect rendering missing"
grep -q 'requestAnimationFrame(frame);' "$app_file" || fail "animation loop missing"

grep -q 'slug: "magnetic-marble-duel"' "$index_file" || fail "showcase entry missing"
grep -q 'title: "磁力弹珠双人对战台"' "$index_file" || fail "showcase title missing"
grep -q '## 磁力弹珠双人对战台' "$readme_file" || fail "README section missing"

printf 'magnetic marble duel smoke test passed\n'
