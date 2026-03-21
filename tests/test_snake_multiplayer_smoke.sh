#!/usr/bin/env bash

set -euo pipefail

root_dir="$(cd "$(dirname "$0")/.." && pwd)"
game_file="$root_dir/snake-game/multiplayer.html"

fail() {
  printf 'FAIL: %s\n' "$1" >&2
  exit 1
}

[ -f "$game_file" ] || fail "snake-game/multiplayer.html is missing"

grep -q '<title>贪吃蛇双人联网版</title>' "$game_file" || fail "multiplayer title missing"
grep -q 'new RTCPeerConnection' "$game_file" || fail "WebRTC peer connection missing"
grep -q 'createDataChannel("snake-sync")' "$game_file" || fail "data channel setup missing"
grep -q 'stun:stun.l.google.com:19302' "$game_file" || fail "stun server missing"
grep -q 'id="role-select"' "$game_file" || fail "role selector missing"
grep -q 'id="local-signal"' "$game_file" || fail "local signal textarea missing"
grep -q 'id="remote-signal"' "$game_file" || fail "remote signal textarea missing"
grep -q 'const WIN_SCORE = 50;' "$game_file" || fail "win score missing"
grep -q 'function tickHost()' "$game_file" || fail "host simulation loop missing"
grep -q 'type: "state"' "$game_file" || fail "state sync messages missing"
grep -q 'type: "input"' "$game_file" || fail "input sync messages missing"

printf 'snake multiplayer smoke test passed\n'
