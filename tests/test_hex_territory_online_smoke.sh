#!/usr/bin/env bash

set -euo pipefail

root_dir="$(cd "$(dirname "$0")/.." && pwd)"
app_file="$root_dir/hex-territory-online/index.html"

fail() {
  printf 'FAIL: %s\n' "$1" >&2
  exit 1
}

[ -f "$app_file" ] || fail "hex-territory-online/index.html is missing"

grep -q 'Hex Territory Online' "$app_file" || fail "title missing"
grep -q 'new version of Hex Territory' "$app_file" && fail "unexpected placeholder text present"
grep -q 'new-game' "$app_file" || fail "new match button missing"
grep -q 'RTCPeerConnection' "$app_file" || fail "webrtc connection missing"
grep -q 'createDataChannel("hex-territory-online")' "$app_file" || fail "data channel missing"
grep -q 'function exportSnapshot()' "$app_file" || fail "snapshot sync missing"
grep -q 'function handlePeerMessage(message)' "$app_file" || fail "peer message handler missing"
grep -q 'Host Match' "$app_file" || fail "host button missing"
grep -q 'Join Match' "$app_file" || fail "join button missing"
grep -q 'captured and changes color' "$app_file" || fail "capture rules text missing"

printf 'hex territory online smoke test passed\n'
