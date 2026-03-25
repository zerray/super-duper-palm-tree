#!/usr/bin/env bash

set -euo pipefail

root_dir="$(cd "$(dirname "$0")/.." && pwd)"
app_file="$root_dir/rhythm-block-relay/index.html"
index_file="$root_dir/index.html"
readme_file="$root_dir/README.md"

fail() {
  printf 'FAIL: %s\n' "$1" >&2
  exit 1
}

[ -f "$app_file" ] || fail "rhythm-block-relay/index.html is missing"

grep -q '<title>节奏色块接力</title>' "$app_file" || fail "page title missing"
grep -q 'A / S / D / F' "$app_file" || fail "player 1 keys missing"
grep -q 'J / K / L / ;' "$app_file" || fail "player 2 keys missing"
grep -q '±50ms Perfect，±120ms Good，其余 Miss' "$app_file" || fail "judgement windows missing"
grep -q 'const PERFECT_MS = 50;' "$app_file" || fail "perfect timing constant missing"
grep -q 'const GOOD_MS = 120;' "$app_file" || fail "good timing constant missing"
grep -q 'const MAX_LEVEL = 5;' "$app_file" || fail "max level constant missing"
grep -q 'const LEVEL_INTERVAL_MS = 30000;' "$app_file" || fail "difficulty interval missing"
grep -q 'const STORAGE_KEY = "rhythm-block-relay-best-run";' "$app_file" || fail "best run storage key missing"
grep -q 'window.AudioContext || window.webkitAudioContext' "$app_file" || fail "web audio setup missing"
grep -q 'function getTravelMs(level)' "$app_file" || fail "travel timing function missing"
grep -q 'function getSpawnIntervalMs(level)' "$app_file" || fail "spawn interval function missing"
grep -q 'function spawnBlock(now)' "$app_file" || fail "block spawning logic missing"
grep -q 'function applyHit(block, deltaMs, now)' "$app_file" || fail "hit handling missing"
grep -q 'function applyMiss(block, reason, now)' "$app_file" || fail "miss handling missing"
grep -q 'function endGame(now)' "$app_file" || fail "game over logic missing"
grep -q '双方共享一条生命值' "$app_file" || fail "shared hp copy missing"
grep -q '双人合计得分' "$app_file" || fail "game over stats copy missing"
grep -q 'canvas id="game"' "$app_file" || fail "canvas missing"

grep -q 'slug: "rhythm-block-relay"' "$index_file" || fail "root index metadata missing"
grep -q 'title: "节奏色块接力"' "$index_file" || fail "root index title missing"
grep -q 'shared HP' "$index_file" || fail "root index description not updated"
grep -q '## 节奏色块接力' "$readme_file" || fail "readme section missing"
grep -q 'rhythm-block-relay/index.html' "$readme_file" || fail "readme file reference missing"

printf 'rhythm block relay smoke test passed\n'
