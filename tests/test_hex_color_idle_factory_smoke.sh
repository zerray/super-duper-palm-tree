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
grep -q 'Hex Color Idle Factory' "$app_file" || fail "game title missing"
grep -q 'localStorage' "$app_file" || fail "localStorage persistence missing"
grep -q 'requestAnimationFrame(step)' "$app_file" || fail "requestAnimationFrame loop missing"
grep -q 'MIX_RECIPES' "$app_file" || fail "mixing system missing"
grep -q 'Primary Pumps' "$app_file" || fail "first upgrade missing"
grep -q 'Mixer Catalysts' "$app_file" || fail "second upgrade missing"
grep -q 'Conveyor Logistics' "$app_file" || fail "third upgrade missing"
grep -q 'fillOrderButton' "$app_file" || fail "order system control missing"
grep -q '@media (max-width: 640px)' "$app_file" || fail "mobile responsive rule missing"

printf 'hex color idle factory smoke test passed\n'
