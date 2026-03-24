#!/usr/bin/env bash

set -euo pipefail

root_dir="$(cd "$(dirname "$0")/.." && pwd)"
app_file="$root_dir/rhythm-palette/index.html"

fail() {
  printf 'FAIL: %s\n' "$1" >&2
  exit 1
}

[ -f "$app_file" ] || fail "rhythm-palette/index.html is missing"

grep -q '<canvas id="art-canvas"' "$app_file" || fail "art canvas missing"
grep -q 'id="preset-select"' "$app_file" || fail "preset select missing"
grep -q 'id="save-button"' "$app_file" || fail "save button missing"
grep -q 'const presets = \[' "$app_file" || fail "preset data missing"
grep -q 'window.AudioContext || window.webkitAudioContext' "$app_file" || fail "audio context setup missing"
grep -q 'createAnalyser' "$app_file" || fail "analyser node missing"
grep -q 'canvas.toDataURL("image/png")' "$app_file" || fail "png export missing"
grep -q 'canvas.addEventListener("pointerdown", handlePointerDown)' "$app_file" || fail "pointerdown handler missing"
grep -Fq 'state.targetSymmetry = symmetryOptions[nextIndex]' "$app_file" || fail "symmetry cycling missing"
grep -q 'state.currentHue = lerp(state.currentHue, state.targetHue, 0.08)' "$app_file" || fail "smooth hue interpolation missing"

printf 'rhythm palette smoke test passed\n'
