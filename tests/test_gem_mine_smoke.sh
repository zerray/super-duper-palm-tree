#!/usr/bin/env bash

set -euo pipefail

root_dir="$(cd "$(dirname "$0")/.." && pwd)"
app_file="$root_dir/gem-mine-clicker/index.html"

fail() {
  printf 'FAIL: %s\n' "$1" >&2
  exit 1
}

[ -f "$app_file" ] || fail "gem-mine-clicker/index.html is missing"

grep -q '<!DOCTYPE html>' "$app_file" || fail "doctype missing"
grep -q 'const STORAGE_KEY = "gem-mine-clicker-state-v1";' "$app_file" || fail "storage key missing"
grep -q 'localStorage.getItem(STORAGE_KEY)' "$app_file" || fail "state load missing"
grep -q 'localStorage.setItem(STORAGE_KEY' "$app_file" || fail "state save missing"
grep -q 'requestAnimationFrame(loop);' "$app_file" || fail "animation frame loop missing"
grep -q 'className = "particle"' "$app_file" || fail "particle effect missing"
grep -q 'Prestige Reset' "$app_file" || fail "prestige control missing"
grep -q 'const UPGRADE_DEFS = \[' "$app_file" || fail "upgrade definitions missing"
grep -q 'buyUpgrade(upgrade.id)' "$app_file" || fail "upgrade purchase handler missing"

printf 'gem mine smoke test passed\n'
