#!/usr/bin/env bash

set -euo pipefail

root_dir="$(cd "$(dirname "$0")/.." && pwd)"
app_file="$root_dir/rhythm-dj-coop/index.html"
index_file="$root_dir/index.html"
readme_file="$root_dir/README.md"

fail() {
  printf 'FAIL: %s\n' "$1" >&2
  exit 1
}

[ -f "$app_file" ] || fail "rhythm-dj-coop/index.html is missing"

grep -q '<!DOCTYPE html>' "$app_file" || fail "doctype missing"
grep -q '<title>节奏色块：合作打碟小游戏</title>' "$app_file" || fail "page title missing"
grep -q 'id="game-canvas"' "$app_file" || fail "canvas missing"
grep -q 'const PERFECT_WINDOW_MS = 50;' "$app_file" || fail "perfect window missing"
grep -q 'const GOOD_WINDOW_MS = 120;' "$app_file" || fail "good window missing"
grep -q 'const GAME_DURATION_MS = 45000;' "$app_file" || fail "game duration missing"
grep -q 'const LANE_KEYS = \["d", "f", "j", "k"\];' "$app_file" || fail "lane key mapping missing"
grep -q 'solo: "单人：一人负责全部四键' "$app_file" || fail "solo mode copy missing"
grep -q 'coop: "双人合作：P1 负责左半边 D / F，P2 负责右半边 J / K' "$app_file" || fail "coop mode copy missing"
grep -q 'createOscillator' "$app_file" || fail "web audio synthesis missing"
grep -q 'function judgeLanePress(lane, pressedAt)' "$app_file" || fail "judgement handler missing"
grep -q 'function triggerComboFx()' "$app_file" || fail "combo effect handler missing"
grep -q 'Perfect' "$app_file" || fail "perfect feedback missing"
grep -q 'Good' "$app_file" || fail "good feedback missing"
grep -q 'Miss' "$app_file" || fail "miss feedback missing"
grep -q 'id="final-score"' "$app_file" || fail "final score output missing"
grep -q 'id="final-max-combo"' "$app_file" || fail "final max combo output missing"

size_bytes="$(wc -c < "$app_file")"
[ "$size_bytes" -gt 5000 ] || fail "app file too small"

grep -q 'slug: "rhythm-dj-coop"' "$index_file" || fail "root index entry missing"
grep -q 'title: "节奏色块：合作打碟小游戏"' "$index_file" || fail "root index title missing"
grep -q '## 节奏色块：合作打碟小游戏' "$readme_file" || fail "README entry missing"

printf 'rhythm dj coop smoke test passed\n'
