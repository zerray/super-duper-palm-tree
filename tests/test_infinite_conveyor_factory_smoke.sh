#!/usr/bin/env bash

set -euo pipefail

root_dir="$(cd "$(dirname "$0")/.." && pwd)"
app_file="$root_dir/infinite-conveyor-factory/index.html"
index_file="$root_dir/index.html"
readme_file="$root_dir/README.md"

fail() {
  printf 'FAIL: %s\n' "$1" >&2
  exit 1
}

[ -f "$app_file" ] || fail "infinite-conveyor-factory/index.html is missing"

grep -q '<!DOCTYPE html>' "$app_file" || fail "html doctype missing"
grep -q '无限工厂传送带' "$app_file" || fail "game title missing"
grep -q 'const STORAGE_KEY = "infinite-conveyor-factory-save"' "$app_file" || fail "storage key missing"
grep -q 'const GRID_SIZE = 16;' "$app_file" || fail "grid size missing"
grep -q 'const toolDefs = \[' "$app_file" || fail "tool definitions missing"
grep -q 'const PROCESSOR_UNLOCK_GOLD = 40;' "$app_file" || fail "unlock threshold missing"
grep -q 'localStorage' "$app_file" || fail "localStorage persistence missing"
grep -q 'requestAnimationFrame(frame);' "$app_file" || fail "animation loop missing"
grep -q 'function runTick()' "$app_file" || fail "tick simulation missing"
grep -q 'function produceFromMachines()' "$app_file" || fail "machine production missing"
grep -q 'canvas.addEventListener("pointermove"' "$app_file" || fail "pointer placement missing"
grep -q 'id="factory-canvas"' "$app_file" || fail "factory canvas missing"
grep -q 'id="tool-grid"' "$app_file" || fail "build panel missing"
grep -q 'id="clear-map-button"' "$app_file" || fail "clear map control missing"
grep -q 'id="restart-button"' "$app_file" || fail "restart control missing"

grep -q 'infinite-conveyor-factory' "$index_file" || fail "root index entry missing"
grep -q '无限工厂传送带' "$readme_file" || fail "README entry missing"

printf 'infinite conveyor factory smoke test passed\n'
