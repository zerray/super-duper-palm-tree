#!/usr/bin/env bash

set -euo pipefail

root_dir="$(cd "$(dirname "$0")/.." && pwd)"
app_file="$root_dir/rhythm-doodle/index.html"

fail() {
  printf 'FAIL: %s\n' "$1" >&2
  exit 1
}

[ -f "$app_file" ] || fail "rhythm-doodle/index.html is missing"

grep -q '<title>节奏涂鸦：音乐驱动的生成画布</title>' "$app_file" || fail "page title missing"
grep -q '<canvas id="art-canvas"' "$app_file" || fail "art canvas missing"
grep -q 'window.AudioContext || window.webkitAudioContext' "$app_file" || fail "web audio setup missing"
grep -q 'function scheduler()' "$app_file" || fail "beat scheduler missing"
grep -q 'const scheduleAheadTime = 0.18;' "$app_file" || fail "look-ahead scheduling missing"
grep -q 'const bpm = 120;' "$app_file" || fail "bpm loop missing"
grep -q 'data-mode="radial"' "$app_file" || fail "radial symmetry control missing"
grep -q 'data-mode="mirror"' "$app_file" || fail "mirror symmetry control missing"
grep -q 'data-mode="translate"' "$app_file" || fail "translate symmetry control missing"
grep -q 'const paletteOptions = \[' "$app_file" || fail "palette options missing"
grep -q 'name: "Neon"' "$app_file" || fail "palette preset missing"
grep -q 'name: "Ocean"' "$app_file" || fail "five-palette set incomplete"
grep -q 'id="shape-rule"' "$app_file" || fail "shape rule select missing"
grep -q 'function queueUserHit' "$app_file" || fail "manual hit insertion missing"
grep -q 'event.code !== "Space"' "$app_file" || fail "space hit control missing"
grep -q 'canvas.addEventListener("pointerdown", handlePointerDown);' "$app_file" || fail "canvas click input missing"
grep -q 'canvas.addEventListener("pointermove", handlePointerMove);' "$app_file" || fail "drag input missing"
grep -q 'function saveImage()' "$app_file" || fail "save handler missing"
grep -q 'canvas.toDataURL("image/png")' "$app_file" || fail "png export missing"
grep -q 'const MAX_ELEMENTS = 720;' "$app_file" || fail "element cap missing"

printf 'rhythm doodle smoke test passed\n'
