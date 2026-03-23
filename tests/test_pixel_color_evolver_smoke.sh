#!/usr/bin/env bash

set -euo pipefail

root_dir="$(cd "$(dirname "$0")/.." && pwd)"
app_file="$root_dir/pixel-color-evolver/index.html"

fail() {
  printf 'FAIL: %s\n' "$1" >&2
  exit 1
}

[ -f "$app_file" ] || fail "pixel-color-evolver/index.html is missing"

grep -q '<!DOCTYPE html>' "$app_file" || fail "html doctype missing"
grep -q '像素调色进化器' "$app_file" || fail "game title missing"
grep -q 'GRID_SIZE = 8' "$app_file" || fail "8x8 grid config missing"
grep -q 'localStorage' "$app_file" || fail "localStorage persistence missing"
grep -q 'simulateSeconds' "$app_file" || fail "offline simulation helper missing"
grep -q 'SUCCESS_THRESHOLD' "$app_file" || fail "success threshold missing"
grep -q 'PRIMARY_COLORS' "$app_file" || fail "primary color injection missing"
grep -q 'mixColors' "$app_file" || fail "color mixing helper missing"
grep -q '当前目标色' "$app_file" || fail "target color UI missing"

printf 'pixel color evolver smoke test passed\n'
