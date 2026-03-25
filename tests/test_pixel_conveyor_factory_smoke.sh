#!/usr/bin/env bash

set -euo pipefail

root_dir="$(cd "$(dirname "$0")/.." && pwd)"
app_file="$root_dir/pixel-conveyor-factory/index.html"
index_file="$root_dir/index.html"
readme_file="$root_dir/README.md"

fail() {
  printf 'FAIL: %s\n' "$1" >&2
  exit 1
}

[ -f "$app_file" ] || fail "pixel-conveyor-factory/index.html is missing"

grep -q '<!DOCTYPE html>' "$app_file" || fail "html doctype missing"
grep -q '像素工厂传送带' "$app_file" || fail "game title missing"
grep -q 'id="factory-canvas"' "$app_file" || fail "factory canvas missing"
grep -q 'const GRID_WIDTH = 14;' "$app_file" || fail "grid width missing"
grep -q 'const toolDefs = \[' "$app_file" || fail "tool definitions missing"
grep -q 'const keyboardToolOrder = \["belt", "processor", "collector", "erase"\];' "$app_file" || fail "keyboard tool order missing"
grep -q 'function advanceSimulation()' "$app_file" || fail "simulation loop missing"
grep -q 'function maybeSpawnItems()' "$app_file" || fail "spawn logic missing"
grep -q 'function placeTool(' "$app_file" || fail "placement logic missing"
grep -q 'requestAnimationFrame(render);' "$app_file" || fail "render loop missing"
grep -q 'upgradeBeltsButton.addEventListener("click"' "$app_file" || fail "belt upgrade missing"
grep -q 'upgradeProcessorsButton.addEventListener("click"' "$app_file" || fail "processor upgrade missing"
grep -q 'document.addEventListener("keydown"' "$app_file" || fail "dual player keyboard controls missing"
grep -q 'canvas.addEventListener("pointerdown"' "$app_file" || fail "mouse placement missing"

grep -q 'pixel-conveyor-factory' "$index_file" || fail "root index entry missing"
grep -q '像素工厂传送带' "$readme_file" || fail "README entry missing"

printf 'pixel conveyor factory smoke test passed\n'
