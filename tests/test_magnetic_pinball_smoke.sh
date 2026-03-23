#!/usr/bin/env bash

set -euo pipefail

root_dir="$(cd "$(dirname "$0")/.." && pwd)"
app_file="$root_dir/magnetic-pinball/index.html"

fail() {
  printf 'FAIL: %s\n' "$1" >&2
  exit 1
}

[ -f "$app_file" ] || fail "magnetic-pinball/index.html is missing"

grep -q '<canvas id="magnetic-pinball-canvas"' "$app_file" || fail "canvas missing"
grep -q 'const magneticPinball = (() => {' "$app_file" || fail "game module missing"
grep -q 'const MAGNET_STRENGTH = 200000;' "$app_file" || fail "magnet force constant missing"
grep -q 'const levels = \[' "$app_file" || fail "level definitions missing"
grep -q 'type: "attract"' "$app_file" || fail "attract magnet missing"
grep -q 'type: "repel"' "$app_file" || fail "repel magnet missing"
grep -q 'function computeMagnetAcceleration(x, y)' "$app_file" || fail "magnet physics missing"
grep -q 'function handlePointerDown(event)' "$app_file" || fail "drag handling missing"
grep -q 'state.magnetsLocked = true;' "$app_file" || fail "launch lock missing"
grep -q 'function awardZone(zone)' "$app_file" || fail "zone scoring missing"
grep -q 'if (state.zones.every((item) => item.scored))' "$app_file" || fail "level clear detection missing"
grep -q 'id="launch-button"' "$app_file" || fail "launch button missing"
grep -q 'id="power-slider"' "$app_file" || fail "power slider missing"
grep -q 'requestAnimationFrame(tick);' "$app_file" || fail "animation loop missing"

printf 'magnetic pinball smoke test passed\n'
