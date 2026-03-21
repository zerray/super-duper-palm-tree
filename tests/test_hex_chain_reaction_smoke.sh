#!/usr/bin/env bash

set -euo pipefail

root_dir="$(cd "$(dirname "$0")/.." && pwd)"
app_file="$root_dir/hex-chain-reaction/index.html"

fail() {
  printf 'FAIL: %s\n' "$1" >&2
  exit 1
}

[ -f "$app_file" ] || fail "hex-chain-reaction/index.html is missing"

grep -q 'Hex Chain Reaction' "$app_file" || fail "title missing"
grep -q 'const DEFAULT_RADIUS = 7;' "$app_file" || fail "default radius missing"
grep -q 'const ANIMATION_STEP_MS = 160;' "$app_file" || fail "animation timing missing"
grep -q 'const RTC_CONFIG = {' "$app_file" || fail "rtc config missing"
grep -q 'gridRadius: DEFAULT_RADIUS' "$app_file" || fail "configurable radius state missing"
grep -q 'board: new Map()' "$app_file" || fail "Map-backed board state missing"
grep -q 'matchMode: "local"' "$app_file" || fail "match mode state missing"
grep -q 'localPlayer: PLAYER_ONE' "$app_file" || fail "local player state missing"
grep -q 'function axialToCube' "$app_file" || fail "cube coordinate helper missing"
grep -q 'function isWithinRadius' "$app_file" || fail "hex radius bounds missing"
grep -q 'function getNeighborsFromBoard' "$app_file" || fail "neighbor lookup missing"
grep -q 'cell.count > getNeighborCount(cell, board)' "$app_file" || fail "overflow threshold missing"
grep -q 'id="sizeSelect"' "$app_file" || fail "board size control missing"
grep -q 'id="hostSessionButton"' "$app_file" || fail "host session control missing"
grep -q 'id="joinSessionButton"' "$app_file" || fail "join session control missing"
grep -q 'Manual WebRTC pairing for two browsers' "$app_file" || fail "online pairing copy missing"
grep -q 'new RTCPeerConnection(RTC_CONFIG)' "$app_file" || fail "peer connection missing"
grep -q 'type: "state-sync"' "$app_file" || fail "state sync message missing"
grep -q 'Only Blue host can reset or resize an online match.' "$app_file" || fail "host-only reset guard missing"
grep -q 'async function resolveChainReaction' "$app_file" || fail "animated chain reaction missing"
grep -q 'New Game' "$app_file" || fail "restart control missing"
grep -q 'Move:' "$app_file" || fail "move counter missing"
grep -q 'Take turns placing tokens on a hex grid' "$app_file" || fail "rules copy missing"
grep -q 'last player with tokens on the board' "$app_file" || fail "win condition text missing"

printf 'hex chain reaction smoke test passed\n'
