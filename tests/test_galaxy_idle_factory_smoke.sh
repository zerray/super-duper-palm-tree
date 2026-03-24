#!/usr/bin/env bash

set -euo pipefail

root_dir="$(cd "$(dirname "$0")/.." && pwd)"
app_file="$root_dir/galaxy-idle-factory/index.html"

fail() {
  printf 'FAIL: %s\n' "$1" >&2
  exit 1
}

[ -f "$app_file" ] || fail "galaxy-idle-factory/index.html is missing"

grep -q '<!DOCTYPE html>' "$app_file" || fail "html doctype missing"
grep -q '闲置星系工厂' "$app_file" || fail "game title missing"
grep -q 'id="galaxy-svg"' "$app_file" || fail "svg galaxy view missing"
grep -q 'const STORAGE_KEY = "galaxy-idle-factory-save"' "$app_file" || fail "storage key missing"
grep -q 'const OFFLINE_CAP_SECONDS = 300;' "$app_file" || fail "offline cap missing"
grep -q 'const PLANET_COUNT = 5;' "$app_file" || fail "planet count missing"
grep -q 'const planetDefs = \[' "$app_file" || fail "planet definitions missing"
grep -q 'unlockCost' "$app_file" || fail "planet unlock costs missing"
grep -q 'localStorage' "$app_file" || fail "localStorage persistence missing"
grep -q 'simulateSeconds' "$app_file" || fail "offline simulation helper missing"
grep -q 'setInterval(tick, 1000);' "$app_file" || fail "setInterval tick loop missing"
grep -q 'function formatNumber(value)' "$app_file" || fail "number formatting helper missing"
grep -q 'K' "$app_file" || fail "K suffix formatting missing"
grep -q 'M' "$app_file" || fail "M suffix formatting missing"
grep -q 'B' "$app_file" || fail "B suffix formatting missing"
grep -q '全部 5 颗星球已解锁' "$app_file" || fail "victory text missing"

printf 'galaxy idle factory smoke test passed\n'
