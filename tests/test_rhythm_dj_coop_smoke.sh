#!/usr/bin/env bash

set -euo pipefail

root_dir="$(cd "$(dirname "$0")/.." && pwd)"
app_file="$root_dir/rhythm-dj-coop/index.html"

fail() {
  printf 'FAIL: %s\n' "$1" >&2
  exit 1
}

[ -f "$app_file" ] || fail "rhythm-dj-coop/index.html is missing"

grep -q '<title>节奏色块：合作打碟机</title>' "$app_file" || fail "page title missing"
grep -q 'keys: \["a", "s", "d", "f"\]' "$app_file" || fail "left player key bindings missing"
grep -q 'keys: \["j", "k", "l", ";"\]' "$app_file" || fail "right player key bindings missing"
grep -q 'perfectWindow: 60' "$app_file" || fail "perfect window missing"
grep -q 'goodWindow: 130' "$app_file" || fail "good window missing"
grep -q 'state.mode === "solo-left"' "$app_file" || fail "single-player left mode missing"
grep -q 'state.mode === "solo-right"' "$app_file" || fail "single-player right mode missing"
grep -q 'createOscillator' "$app_file" || fail "web audio synthesis missing"
grep -q 'function spawnBeatPattern(beatTime)' "$app_file" || fail "beat-driven spawning missing"
grep -q 'function judgePress(side, lane, pressedAt)' "$app_file" || fail "judgement handler missing"
grep -q 'Perfect' "$app_file" || fail "perfect feedback missing"
grep -q 'Good' "$app_file" || fail "good feedback missing"
grep -q 'Miss' "$app_file" || fail "miss feedback missing"
grep -q 'state.visualLevel >= 3' "$app_file" || fail "visual escalation tier missing"

printf 'rhythm dj coop smoke test passed\n'
