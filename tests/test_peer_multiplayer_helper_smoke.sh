#!/usr/bin/env bash

set -euo pipefail

root_dir="$(cd "$(dirname "$0")/.." && pwd)"
helper_file="$root_dir/shared/peer-multiplayer.js"

fail() {
  printf 'FAIL: %s\n' "$1" >&2
  exit 1
}

[ -f "$helper_file" ] || fail "shared/peer-multiplayer.js is missing"

grep -q 'window.createPeerMultiplayer' "$helper_file" || fail "factory export missing"
grep -q 'Create Room' "$helper_file" || fail "create room control missing"
grep -q 'Join' "$helper_file" || fail "join control missing"
grep -q 'window.Peer' "$helper_file" || fail "PeerJS integration missing"

printf 'peer multiplayer helper smoke test passed\n'
