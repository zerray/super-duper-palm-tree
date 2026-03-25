#!/usr/bin/env bash

set -euo pipefail

root_dir="$(cd "$(dirname "$0")/.." && pwd)"
app_file="$root_dir/stardust-factory/index.html"
index_file="$root_dir/index.html"

fail() {
  printf 'FAIL: %s\n' "$1" >&2
  exit 1
}

[ -f "$app_file" ] || fail "stardust-factory/index.html is missing"

grep -q '<canvas id="factory-canvas"' "$app_file" || fail "factory canvas missing"
grep -q 'const STORAGE_KEY = "stardust-factory-save-v1"' "$app_file" || fail "storage key missing"
grep -q 'const OFFLINE_CAP_SECONDS = 28800;' "$app_file" || fail "offline cap missing"
grep -q 'const collectorDefs = \[' "$app_file" || fail "collector definitions missing"
grep -q 'const furnaceDefs = \[' "$app_file" || fail "furnace definitions missing"
grep -q 'applyOfflineProgress' "$app_file" || fail "offline progress logic missing"
grep -q 'simulateSeconds' "$app_file" || fail "simulation helper missing"
grep -q 'localStorage' "$app_file" || fail "localStorage persistence missing"
grep -q 'setInterval(runTick, TICK_MS);' "$app_file" || fail "tick interval missing"
grep -q 'setInterval(saveGame, AUTO_SAVE_MS);' "$app_file" || fail "autosave interval missing"
grep -q 'id="offline-modal"' "$app_file" || fail "offline modal missing"
grep -q 'drawTechTreeLinks' "$app_file" || fail "tech tree renderer missing"
grep -q '微尘网' "$app_file" || fail "collector tier one missing"
grep -q '光谱钩阵' "$app_file" || fail "collector tier two missing"
grep -q '引力花冠' "$app_file" || fail "collector tier three missing"
grep -q '琥珀熔炉' "$app_file" || fail "furnace tier one missing"
grep -q '玫晶熔炉' "$app_file" || fail "furnace tier two missing"
grep -q '虚空棱镜炉' "$app_file" || fail "furnace tier three missing"
grep -q '星尘工厂：放置增长模拟' "$app_file" || fail "game title missing"

grep -q '59 playable games' "$index_file" || fail "root game count not updated"
grep -q 'slug: "stardust-factory"' "$index_file" || fail "root index entry missing"

printf 'stardust factory smoke test passed\n'
