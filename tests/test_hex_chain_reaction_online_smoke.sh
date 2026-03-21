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
grep -q 'const SIGNAL_OFFER = "offer";' "$app_file" || fail "offer signaling missing"
grep -q 'const SIGNAL_ANSWER = "answer";' "$app_file" || fail "answer signaling missing"
grep -q 'new RTCPeerConnection' "$app_file" || fail "webrtc peer connection missing"
grep -q 'stun:stun.l.google.com:19302' "$app_file" || fail "stun server missing"
grep -q 'createDataChannel("moves")' "$app_file" || fail "data channel setup missing"
grep -q 'Host as Blue' "$app_file" || fail "host control missing"
grep -q 'Join as Red' "$app_file" || fail "join control missing"
grep -q 'Only the Blue host may change board size' "$app_file" || fail "host-only board size guard missing"
grep -q 'sendMessage({ type: SESSION_RESET' "$app_file" || fail "remote reset sync missing"
grep -q 'type: SESSION_MOVE' "$app_file" || fail "remote move sync missing"

printf 'hex chain reaction online smoke test passed\n'
