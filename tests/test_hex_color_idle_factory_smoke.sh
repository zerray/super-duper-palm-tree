#!/usr/bin/env bash

set -euo pipefail

root_dir="$(cd "$(dirname "$0")/.." && pwd)"
app_file="$root_dir/hex-color-idle-factory/index.html"

fail() {
  printf 'FAIL: %s\n' "$1" >&2
  exit 1
}

[ -f "$app_file" ] || fail "hex-color-idle-factory/index.html is missing"

grep -q '<!DOCTYPE html>' "$app_file" || fail "html doctype missing"
grep -q 'Hex Color Idle Factory' "$app_file" || fail "title text missing"
grep -q 'const primaryColors =' "$app_file" || fail "primary generator config missing"
grep -q 'const secondaryRecipes =' "$app_file" || fail "secondary mixing config missing"
grep -q 'const upgradeDefs =' "$app_file" || fail "upgrade definitions missing"
grep -q 'localStorage' "$app_file" || fail "localStorage persistence missing"
grep -q 'requestAnimationFrame(step);' "$app_file" || fail "animation loop missing"
grep -q 'function unlockMix()' "$app_file" || fail "mixing flow missing"
grep -q 'function fillOrder()' "$app_file" || fail "order system missing"
grep -q 'id="primary-generators"' "$app_file" || fail "factory generator UI missing"
grep -q 'id="fill-order-button"' "$app_file" || fail "order action missing"
grep -q 'id="reset-button"' "$app_file" || fail "reset control missing"

printf 'hex color idle factory smoke test passed\n'
