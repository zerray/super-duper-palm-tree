#!/usr/bin/env bash

set -euo pipefail

root_dir="$(cd "$(dirname "$0")/.." && pwd)"
app_file="$root_dir/rhythm-color-factory/index.html"
index_file="$root_dir/index.html"
readme_file="$root_dir/README.md"

fail() {
  printf 'FAIL: %s\n' "$1" >&2
  exit 1
}

[ -f "$app_file" ] || fail "rhythm-color-factory/index.html is missing"

grep -q '<!DOCTYPE html>' "$app_file" || fail "html doctype missing"
grep -q '节奏色块工厂：音乐驱动的 Idle 色块生产线' "$app_file" || fail "game title missing"
grep -q 'const STORAGE_KEY = "rhythm-color-factory-save-v1";' "$app_file" || fail "storage key missing"
grep -q 'const AudioContextClass = window.AudioContext || window.webkitAudioContext;' "$app_file" || fail "web audio setup missing"
grep -q 'const COLORS = \["#ff5d73", "#ff975d", "#ffd15d", "#6ef3a1", "#5dd9ff", "#8a7dff"\];' "$app_file" || fail "color palette missing"
grep -q 'function getMusicLayers()' "$app_file" || fail "music layering logic missing"
grep -q 'function triggerBeat(beatIndex)' "$app_file" || fail "beat trigger missing"
grep -q 'function playBeatSound(beatIndex)' "$app_file" || fail "beat audio missing"
grep -q 'function purchaseSpeedUpgrade()' "$app_file" || fail "speed upgrade missing"
grep -q 'function purchaseColorUpgrade()' "$app_file" || fail "color upgrade missing"
grep -q 'function saveState(reason = "自动保存")' "$app_file" || fail "save helper missing"
grep -q 'localStorage.setItem(STORAGE_KEY, JSON.stringify(state));' "$app_file" || fail "localStorage persistence missing"
grep -q 'canvas id="factory-canvas"' "$app_file" || fail "factory canvas missing"
grep -q 'id="track-lead"' "$app_file" || fail "third music layer indicator missing"
grep -q 'window.requestAnimationFrame(frame);' "$app_file" || fail "animation loop missing"

grep -q 'slug: "rhythm-color-factory"' "$index_file" || fail "root index card missing"
grep -q '节奏色块工厂：音乐驱动的 Idle 色块生产线' "$readme_file" || fail "README entry missing"

printf 'rhythm color factory smoke test passed\n'
