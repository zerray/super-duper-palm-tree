#!/usr/bin/env bash

set -euo pipefail

root_dir="$(cd "$(dirname "$0")/.." && pwd)"
app_file="$root_dir/rhythm-block-relay/index.html"
index_file="$root_dir/index.html"

fail() {
  printf 'FAIL: %s\n' "$1" >&2
  exit 1
}

[ -f "$app_file" ] || fail "rhythm-block-relay/index.html is missing"

grep -q '<title>节奏色块记忆接力</title>' "$app_file" || fail "page title missing"
grep -q 'const storageKey = "rhythm-block-relay-best-round";' "$app_file" || fail "best round storage key missing"
grep -q 'const initialSequenceLength = 3;' "$app_file" || fail "initial sequence length missing"
grep -q 'data-player-count="2"' "$app_file" || fail "2-player option missing"
grep -q 'data-player-count="3"' "$app_file" || fail "3-player option missing"
grep -q 'data-player-count="4"' "$app_file" || fail "4-player option missing"
grep -q 'id="mute-button"' "$app_file" || fail "mute button missing"
grep -q 'id="restart-button"' "$app_file" || fail "restart button missing"
grep -q 'window.AudioContext || window.webkitAudioContext' "$app_file" || fail "web audio setup missing"
grep -q 'function createPlayers(count)' "$app_file" || fail "player setup missing"
grep -q 'async function playbackSequence(token)' "$app_file" || fail "sequence playback missing"
grep -q 'async function handleSuccessfulTurn()' "$app_file" || fail "success flow missing"
grep -q 'async function handleElimination(player)' "$app_file" || fail "elimination flow missing"
grep -q 'localStorage.setItem(storageKey, String(bestRound))' "$app_file" || fail "best round persistence missing"
grep -q 'navigator.vibrate' "$app_file" || fail "failure vibration feedback missing"
grep -q 'Q / W / E / A / S / D' "$app_file" || fail "keyboard hint missing"

grep -q 'slug: "rhythm-block-relay"' "$index_file" || fail "root index metadata missing"

printf 'rhythm block relay smoke test passed\n'
