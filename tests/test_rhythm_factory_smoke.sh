#!/usr/bin/env bash

set -euo pipefail

root_dir="$(cd "$(dirname "$0")/.." && pwd)"
app_file="$root_dir/rhythm-factory/index.html"
index_file="$root_dir/index.html"
readme_file="$root_dir/README.md"

fail() {
  printf 'FAIL: %s\n' "$1" >&2
  exit 1
}

[ -f "$app_file" ] || fail "rhythm-factory/index.html is missing"

grep -q '<!DOCTYPE html>' "$app_file" || fail "html doctype missing"
grep -q '节奏工厂：音乐驱动的 Idle 生产线' "$app_file" || fail "game title missing"
grep -q 'const STORAGE_KEY = "rhythm-factory-save-v1";' "$app_file" || fail "storage key missing"
grep -q 'AudioContextClass = window.AudioContext || window.webkitAudioContext' "$app_file" || fail "web audio setup missing"
grep -q 'localStorage' "$app_file" || fail "localStorage persistence missing"
grep -q 'function scheduler()' "$app_file" || fail "beat scheduler missing"
grep -q 'function scheduleBeat(beatTime, beatIndex)' "$app_file" || fail "beat event scheduling missing"
grep -q 'function judgeHit(lineId, pressedAt)' "$app_file" || fail "beat judgement missing"
grep -q 'function simulateSeconds(seconds)' "$app_file" || fail "offline earnings helper missing"
grep -q 'function applyOfflineProgress()' "$app_file" || fail "offline progress logic missing"
grep -q 'window.requestAnimationFrame(frame);' "$app_file" || fail "animation loop missing"
grep -q 'id="offline-modal"' "$app_file" || fail "offline modal missing"
grep -q 'id="visualizer-bars"' "$app_file" || fail "beat visualizer missing"
grep -q 'unlockLine("drum")' "$app_file" || fail "second line unlock missing"
grep -q 'unlockLine("lead")' "$app_file" || fail "third line unlock missing"

grep -q 'slug: "rhythm-factory"' "$index_file" || fail "root index card missing"
grep -q '51 playable games' "$index_file" || fail "root game count not updated"
grep -q '节奏工厂：音乐驱动的 Idle 生产线' "$readme_file" || fail "README entry missing"

printf 'rhythm factory smoke test passed\n'
