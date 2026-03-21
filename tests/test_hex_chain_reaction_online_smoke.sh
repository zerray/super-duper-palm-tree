#!/usr/bin/env bash

set -euo pipefail

root_dir="$(cd "$(dirname "$0")/.." && pwd)"
app_file="$root_dir/hex-chain-reaction-online/index.html"

fail() {
  printf 'FAIL: %s\n' "$1" >&2
  exit 1
}

[ -f "$app_file" ] || fail "hex-chain-reaction-online/index.html is missing"

grep -q 'Hex Chain Reaction Online' "$app_file" || fail "online title missing"
grep -q 'new RTCPeerConnection()' "$app_file" || fail "webrtc peer connection missing"
grep -q 'createDataChannel("hex-chain-reaction")' "$app_file" || fail "data channel missing"
grep -q 'id="createOfferButton"' "$app_file" || fail "create offer control missing"
grep -q 'id="joinOfferButton"' "$app_file" || fail "join offer control missing"
grep -q 'id="acceptAnswerButton"' "$app_file" || fail "accept answer control missing"
grep -q 'Host is Blue and guest is Red' "$app_file" || fail "network role copy missing"
grep -q 'type: "move"' "$app_file" || fail "move sync missing"
grep -q 'type: "reset"' "$app_file" || fail "reset sync missing"
grep -q 'type: "sync"' "$app_file" || fail "state sync missing"

printf 'hex chain reaction online smoke test passed\n'
