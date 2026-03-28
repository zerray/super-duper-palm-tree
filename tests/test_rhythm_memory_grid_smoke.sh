#!/usr/bin/env bash

set -euo pipefail

root_dir="$(cd "$(dirname "$0")/.." && pwd)"
app_file="$root_dir/rhythm-memory-grid/index.html"

fail() {
  printf 'FAIL: %s\n' "$1" >&2
  exit 1
}

[ -f "$app_file" ] || fail "rhythm-memory-grid/index.html is missing"

grep -q '<title>节奏色块记忆挑战</title>' "$app_file" || fail "page title missing"
grep -q 'grid-template-columns: repeat(4, minmax(0, 1fr));' "$app_file" || fail "4x4 grid layout missing"
grep -q 'const START_SEQUENCE_LENGTH = 3;' "$app_file" || fail "initial sequence length missing"
grep -q 'const MAX_SEQUENCE_LENGTH = 12;' "$app_file" || fail "max sequence length missing"
grep -q 'window.AudioContext || window.webkitAudioContext' "$app_file" || fail "web audio setup missing"
grep -q 'flashDistraction' "$app_file" || fail "distraction logic missing"
grep -q 'showCorrectSequenceComparison' "$app_file" || fail "correct sequence replay missing"
grep -q 'playerSequenceLabel' "$app_file" || fail "player comparison output missing"
grep -q 'correctSequenceLabel' "$app_file" || fail "correct comparison output missing"
grep -q '玩家 2 挑战同一序列' "$app_file" || fail "hot-seat turn handoff missing"
grep -q 'armInputDeadline' "$app_file" || fail "beat deadline logic missing"

printf 'rhythm memory grid smoke test passed\n'
