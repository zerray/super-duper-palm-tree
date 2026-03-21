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
grep -q 'new RTCPeerConnection' "$app_file" || fail "WebRTC connection missing"
grep -q 'Host as Blue' "$app_file" || fail "host control missing"
grep -q 'Join as Red' "$app_file" || fail "join control missing"
grep -q 'exchange WebRTC session text once' "$app_file" || fail "webrtc session copy missing"
grep -q 'const SESSION_MOVE = "move";' "$app_file" || fail "session move sync missing"
grep -q 'const SESSION_RESET = "reset";' "$app_file" || fail "session reset sync missing"

printf 'hex chain reaction online smoke test passed\n'
