#!/usr/bin/env bash

set -euo pipefail

root_dir="$(cd "$(dirname "$0")/.." && pwd)"
app_file="$root_dir/conveyor-factory/index.html"
index_file="$root_dir/index.html"
readme_file="$root_dir/README.md"

fail() {
  printf 'FAIL: %s\n' "$1" >&2
  exit 1
}

[ -f "$app_file" ] || fail "conveyor-factory/index.html is missing"

grep -q '<!DOCTYPE html>' "$app_file" || fail "html doctype missing"
grep -q '无尽工厂：放置传送带' "$app_file" || fail "game title missing"
grep -q 'const STORAGE_KEY = "conveyor-factory-save"' "$app_file" || fail "storage key missing"
grep -q 'const GRID_SIZE = 12;' "$app_file" || fail "grid size missing"
grep -q 'const toolDefs = \[' "$app_file" || fail "tool definitions missing"
grep -q 'const shopDefs = \[' "$app_file" || fail "shop definitions missing"
grep -q 'const techDefs = \[' "$app_file" || fail "tech definitions missing"
grep -q 'localStorage' "$app_file" || fail "localStorage persistence missing"
grep -q 'canvas.addEventListener("pointermove"' "$app_file" || fail "drag placement missing"
grep -q 'requestAnimationFrame(frame);' "$app_file" || fail "animation loop missing"
grep -q 'function runTick()' "$app_file" || fail "tick simulation missing"
grep -q 'function processMachineAt' "$app_file" || fail "machine logic missing"
grep -q 'id="factory-canvas"' "$app_file" || fail "factory canvas missing"
grep -q 'id="shop-list"' "$app_file" || fail "shop UI missing"
grep -q 'id="tech-list"' "$app_file" || fail "tech UI missing"

grep -q 'conveyor-factory' "$index_file" || fail "root index entry missing"
grep -q '无尽工厂：放置传送带' "$readme_file" || fail "README entry missing"

printf 'conveyor factory smoke test passed\n'
