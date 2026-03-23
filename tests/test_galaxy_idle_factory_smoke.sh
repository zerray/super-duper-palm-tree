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
grep -q '放置星系工厂' "$app_file" || fail "game title missing"
grep -q 'const STORAGE_KEY = "galaxy-idle-factory-save"' "$app_file" || fail "storage key missing"
grep -q 'const upgradeDefs = \[' "$app_file" || fail "upgrade definitions missing"
grep -q 'simulateSeconds' "$app_file" || fail "offline earnings helper missing"
grep -q 'localStorage' "$app_file" || fail "localStorage persistence missing"
grep -q 'requestAnimationFrame(frame);' "$app_file" || fail "animation loop missing"
grep -q 'handleAsteroidClick' "$app_file" || fail "click mining handler missing"
grep -q 'spawnParticles' "$app_file" || fail "particle feedback missing"
grep -q 'drawPlanets' "$app_file" || fail "procedural planet rendering missing"
grep -q 'drawStars' "$app_file" || fail "star layer rendering missing"
grep -q 'id="upgrade-list"' "$app_file" || fail "upgrade UI missing"
grep -q 'id="offline-modal"' "$app_file" || fail "offline modal missing"

printf 'galaxy idle factory smoke test passed\n'
