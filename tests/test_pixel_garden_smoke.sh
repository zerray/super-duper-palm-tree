#!/usr/bin/env bash

set -euo pipefail

root_dir="$(cd "$(dirname "$0")/.." && pwd)"
app_file="$root_dir/pixel-garden/index.html"

fail() {
  printf 'FAIL: %s\n' "$1" >&2
  exit 1
}

[ -f "$app_file" ] || fail "pixel-garden/index.html is missing"

grep -q '<canvas id="garden-canvas"' "$app_file" || fail "garden canvas missing"
grep -q 'const gardenGrid = Array.from' "$app_file" || fail "garden grid model missing"
grep -q 'const plantTypes = {' "$app_file" || fail "plant type definitions missing"
grep -q 'sunflower' "$app_file" || fail "sunflower plant missing"
grep -q 'rose' "$app_file" || fail "rose plant missing"
grep -q 'vine' "$app_file" || fail "vine plant missing"
grep -q 'mushroom' "$app_file" || fail "mushroom plant missing"
grep -q 'weed' "$app_file" || fail "weed plant missing"
grep -q 'const stageNames = \["种子", "幼苗", "成熟", "开花"\]' "$app_file" || fail "four visual stages missing"
grep -q 'data-speed="4"' "$app_file" || fail "time acceleration controls missing"
grep -q 'simulationInterval = setInterval(simulateTick, baseTickMs / simulationSpeed)' "$app_file" || fail "idle simulation loop missing"
grep -q 'localStorage.setItem(storageKey, JSON.stringify(payload))' "$app_file" || fail "local save missing"
grep -q 'const saved = localStorage.getItem(storageKey)' "$app_file" || fail "local restore missing"
grep -q 'canvas.toDataURL("image/png")' "$app_file" || fail "PNG export missing"
grep -q 'neighbor.type === "weed"' "$app_file" || fail "competition rule missing"
grep -q 'cell.type === "vine" && cell.stage >= 2' "$app_file" || fail "vine spread rule missing"
grep -q 'cell.type === "mushroom"' "$app_file" || fail "mushroom interaction rule missing"
grep -q 'cell.type === "sunflower" && neighbor.type === "rose"' "$app_file" || fail "symbiosis rule missing"
grep -q 'requestAnimationFrame(animationLoop)' "$app_file" || fail "smooth animation loop missing"

printf 'pixel garden smoke test passed\n'
