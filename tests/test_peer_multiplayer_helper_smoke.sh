#!/usr/bin/env bash

set -euo pipefail

root_dir="$(cd "$(dirname "$0")/.." && pwd)"
helper_file="$root_dir/shared/peer-multiplayer.js"

fail() {
  printf 'FAIL: %s\n' "$1" >&2
  exit 1
}

[ -f "$helper_file" ] || fail "shared/peer-multiplayer.js is missing"

grep -q 'createPeerMultiplayer' "$helper_file" || fail "factory export missing"
grep -q 'global.Peer' "$helper_file" || fail "PeerJS integration missing"
grep -q 'sync-request' "$helper_file" || fail "sync request message missing"
grep -q 'snapshot' "$helper_file" || fail "snapshot sync support missing"

printf 'peer multiplayer helper smoke test passed\n'
