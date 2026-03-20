#!/usr/bin/env bash

set -euo pipefail

root_dir="$(cd "$(dirname "$0")/.." && pwd)"
app_file="$root_dir/idle-ecosystem/index.html"

fail() {
  printf 'FAIL: %s\n' "$1" >&2
  exit 1
}

[ -f "$app_file" ] || fail "idle-ecosystem/index.html is missing"

grep -q '<!DOCTYPE html>' "$app_file" || fail "html doctype missing"
grep -q 'Idle Ecosystem' "$app_file" || fail "game title missing"
grep -q 'localStorage' "$app_file" || fail "localStorage persistence missing"
grep -q 'simulateSeconds' "$app_file" || fail "offline simulation helper missing"
grep -q 'requestAnimationFrame(frame)' "$app_file" || fail "animation frame loop missing"
grep -q 'Introduce Grazers' "$app_file" || fail "herbivore tier missing"
grep -q 'Introduce Predators' "$app_file" || fail "predator tier missing"
grep -q 'Predator pressure is high' "$app_file" || fail "population dynamics messaging missing"
grep -q 'Reset Ecosystem' "$app_file" || fail "prestige reset missing"
grep -q 'STORAGE_KEY = "idle-ecosystem-save"' "$app_file" || fail "save key missing"

printf 'idle ecosystem smoke test passed\n'
