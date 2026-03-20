#!/usr/bin/env bash

set -euo pipefail

root_dir="$(cd "$(dirname "$0")/.." && pwd)"
app_file="$root_dir/kaleidoscope/index.html"

fail() {
  printf 'FAIL: %s\n' "$1" >&2
  exit 1
}

[ -f "$app_file" ] || fail "kaleidoscope/index.html is missing"

grep -q '<canvas id="kaleidoscope-canvas"' "$app_file" || fail "canvas element missing"
grep -q 'id="symmetry-slider"' "$app_file" || fail "symmetry slider missing"
grep -q 'id="brush-slider"' "$app_file" || fail "brush slider missing"
grep -q 'id="stroke-color"' "$app_file" || fail "stroke color input missing"
grep -q 'id="background-color"' "$app_file" || fail "background color input missing"
grep -q 'id="clear-button"' "$app_file" || fail "clear button missing"
grep -q 'id="export-button"' "$app_file" || fail "export button missing"
grep -q 'canvas.toDataURL("image/png")' "$app_file" || fail "PNG export missing"
grep -q 'canvas.addEventListener("pointerdown", beginStroke)' "$app_file" || fail "pointerdown handler missing"
grep -q 'canvas.addEventListener("pointermove", extendStroke)' "$app_file" || fail "pointermove handler missing"
grep -q 'function drawSegment' "$app_file" || fail "segment drawing function missing"
grep -q 'segments.push(segment)' "$app_file" || fail "stroke segment storage missing"

printf 'kaleidoscope smoke test passed\n'
