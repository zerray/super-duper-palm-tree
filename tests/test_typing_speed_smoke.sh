#!/usr/bin/env bash

set -euo pipefail

root_dir="$(cd "$(dirname "$0")/.." && pwd)"
app_file="$root_dir/typing-speed-test/index.html"

fail() {
  printf 'FAIL: %s\n' "$1" >&2
  exit 1
}

[ -f "$app_file" ] || fail "typing-speed-test/index.html is missing"

passage_count="$(grep -c '^      "' "$app_file" || true)"
[ "$passage_count" -ge 15 ] || fail "expected at least 15 embedded passages"
grep -q 'BEST_WPM_KEY = "typing-speed-test-best-wpm"' "$app_file" || fail "best WPM storage key missing"
grep -q 'window.localStorage' "$app_file" || fail "localStorage support missing"
grep -q 'calculateStats' "$app_file" || fail "live stats calculation missing"
grep -q 'class="char' "$app_file" || fail "character highlighting markup missing"
grep -q 'Retry Passage' "$app_file" || fail "retry action missing"
grep -q 'New Passage' "$app_file" || fail "new passage action missing"
grep -q 'peerjs@1.5.5' "$app_file" || fail "peerjs dependency missing"
grep -q 'Create Room' "$app_file" || fail "create room control missing"
grep -q 'function createHostPeer()' "$app_file" || fail "host room logic missing"
grep -q 'function joinHostPeer()' "$app_file" || fail "join room logic missing"
grep -q 'id="opponent-progress"' "$app_file" || fail "opponent progress UI missing"

printf 'typing speed smoke test passed\n'
