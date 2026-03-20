#!/usr/bin/env bash

set -euo pipefail

root_dir="$(cd "$(dirname "$0")/.." && pwd)"
app_file="$root_dir/gem-mine-clicker/index.html"

fail() {
  printf 'FAIL: %s\n' "$1" >&2
  exit 1
}

[ -f "$app_file" ] || fail "gem-mine-clicker/index.html is missing"

grep -q '<!DOCTYPE html>' "$app_file" || fail "html doctype missing"
grep -q 'window.localStorage' "$app_file" || fail "localStorage persistence missing"
grep -q 'window.requestAnimationFrame' "$app_file" || fail "requestAnimationFrame loop missing"
grep -q 'particle' "$app_file" || fail "particle effect missing"
grep -q 'Prestige' "$app_file" || fail "prestige UI missing"
grep -q 'Better Pickaxe' "$app_file" || fail "click upgrade missing"
grep -q 'Auto-Miner I' "$app_file" || fail "passive upgrade missing"
grep -q 'Gem Forge' "$app_file" || fail "third upgrade missing"

printf 'gem mine smoke test passed\n'
