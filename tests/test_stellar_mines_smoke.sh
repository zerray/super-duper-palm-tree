#!/usr/bin/env bash

set -euo pipefail

root_dir="$(cd "$(dirname "$0")/.." && pwd)"
app_file="$root_dir/stellar-mines/index.html"
index_file="$root_dir/index.html"

fail() {
  printf 'FAIL: %s\n' "$1" >&2
  exit 1
}

[ -f "$app_file" ] || fail "stellar-mines/index.html is missing"

grep -q '<canvas id="star-map"' "$app_file" || fail "star map canvas missing"
grep -q 'const STORAGE_KEY = "stellar-mines-save-v1"' "$app_file" || fail "storage key missing"
grep -q 'simulateSeconds' "$app_file" || fail "offline simulation helper missing"
grep -q 'applyOfflineProgress' "$app_file" || fail "offline progress logic missing"
grep -q 'localStorage' "$app_file" || fail "localStorage persistence missing"
grep -q 'unlockTech' "$app_file" || fail "tech tree action missing"
grep -q 'deployDrone' "$app_file" || fail "drone deployment missing"
grep -q 'respawnNode' "$app_file" || fail "ore respawn logic missing"
grep -q '星际矿脉' "$app_file" || fail "game title missing"
grep -q '普通矿脉' "$app_file" || fail "common rarity label missing"
grep -q '稀有矿脉' "$app_file" || fail "rare rarity label missing"
grep -q '史诗矿脉' "$app_file" || fail "epic rarity label missing"
grep -q 'id="offline-modal"' "$app_file" || fail "offline modal missing"

grep -q '50 playable games' "$index_file" || fail "root game count not updated"
grep -q 'slug: "stellar-mines"' "$index_file" || fail "root card metadata missing"

printf 'stellar mines smoke test passed\n'
