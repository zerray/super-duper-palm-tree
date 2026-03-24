#!/usr/bin/env bash

set -euo pipefail

root_dir="$(cd "$(dirname "$0")/.." && pwd)"
app_file="$root_dir/rhythm-color-party/index.html"
index_file="$root_dir/index.html"

fail() {
  printf 'FAIL: %s\n' "$1" >&2
  exit 1
}

[ -f "$app_file" ] || fail "rhythm-color-party/index.html is missing"
[ -f "$index_file" ] || fail "index.html is missing"

grep -q '节奏色块派对' "$app_file" || fail "title missing"
grep -q 'requestAnimationFrame' "$app_file" || fail "animation loop missing"
grep -q 'const MODES = \[' "$app_file" || fail "mode config missing"
grep -q 'title: "Chill"' "$app_file" || fail "chill mode missing"
grep -q 'title: "Standard"' "$app_file" || fail "standard mode missing"
grep -q 'title: "Frantic"' "$app_file" || fail "frantic mode missing"
grep -q 'const PLAYERS = \[' "$app_file" || fail "player config missing"
grep -q 'D / F' "$app_file" || fail "player 1 binding missing"
grep -q 'J / K' "$app_file" || fail "player 2 binding missing"
grep -q '← / →' "$app_file" || fail "player 3 binding missing"
grep -q '1 / 2' "$app_file" || fail "player 4 binding missing"
grep -q 'const PERFECT_WINDOW = 100;' "$app_file" || fail "perfect window missing"
grep -q 'const GOOD_WINDOW = 200;' "$app_file" || fail "good window missing"
grep -q 'ROUND_DURATION_MS = 75_000' "$app_file" || fail "round duration missing"
grep -q 'JSON 数组' "$app_file" || fail "json beat pattern copy missing"
grep -q 'rhythm-color-party' "$index_file" || fail "root index entry missing"
grep -q '节奏色块派对' "$index_file" || fail "root index title missing"

printf 'rhythm color party smoke test passed\n'
