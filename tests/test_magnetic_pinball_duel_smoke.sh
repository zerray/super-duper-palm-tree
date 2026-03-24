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
grep -q 'W / S 调整角度，空格发射' "$app_file" || fail "player 1 controls missing"
grep -q '↑ / ↓ 调整角度，Enter 发射' "$app_file" || fail "player 2 controls missing"
grep -q '玩家 1 磁力按钮' "$app_file" || fail "player 1 magnet button missing"
grep -q '玩家 2 磁力按钮' "$app_file" || fail "player 2 magnet button missing"
grep -q '弹珠触及对方底线计 1 分，先到 7 分获胜' "$app_file" || fail "win condition text missing"
grep -q 'const GRAVITY = 540;' "$app_file" || fail "gravity missing"
grep -q 'const MAGNET_DURATION = 0.8;' "$app_file" || fail "magnet duration missing"
grep -q 'const MAGNET_COOLDOWN = 3;' "$app_file" || fail "magnet cooldown missing"
grep -q 'const TARGET_SCORE = 7;' "$app_file" || fail "target score missing"
grep -q 'const bumpers = \[' "$app_file" || fail "bumpers missing"
grep -q 'const blockers = \[' "$app_file" || fail "blockers missing"
grep -q 'function fireLauncher(playerId)' "$app_file" || fail "launch logic missing"
grep -q 'function activateMagnet(playerId)' "$app_file" || fail "magnet logic missing"
grep -q 'function awardPoint(playerId, marble)' "$app_file" || fail "score logic missing"
grep -q 'function applyMagnetFields(dt)' "$app_file" || fail "magnet update missing"
grep -q 'function updateMarbles(dt)' "$app_file" || fail "physics update missing"
grep -q 'function drawParticles()' "$app_file" || fail "particle renderer missing"
grep -q 'globalCompositeOperation = "lighter"' "$app_file" || fail "trail effect missing"
grep -q 'requestAnimationFrame(frame);' "$app_file" || fail "animation loop missing"

grep -q 'slug: "magnetic-pinball-duel"' "$index_file" || fail "showcase entry missing"
grep -q 'title: "磁力弹珠台 - 同屏双人对战"' "$index_file" || fail "showcase title missing"

printf 'magnetic pinball duel smoke test passed\n'
