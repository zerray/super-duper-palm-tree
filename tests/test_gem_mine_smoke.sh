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
grep -q 'localStorage' "$app_file" || fail "localStorage persistence missing"
grep -q 'requestAnimationFrame(step)' "$app_file" || fail "requestAnimationFrame loop missing"
grep -q 'spawnParticleBurst' "$app_file" || fail "particle burst effect missing"
grep -q 'spawnFloater' "$app_file" || fail "rising number feedback missing"
grep -q 'prestigeButton' "$app_file" || fail "prestige control missing"
grep -q 'Reinforced Pickaxe' "$app_file" || fail "click upgrade missing"
grep -q 'Gem Drill' "$app_file" || fail "passive upgrade missing"
grep -q 'Mining Crew' "$app_file" || fail "second passive upgrade missing"

printf 'gem mine smoke test passed\n'
