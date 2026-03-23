#!/usr/bin/env bash

set -euo pipefail

root_dir="$(cd "$(dirname "$0")/.." && pwd)"
app_file="$root_dir/pixel-ecosystem-tank/index.html"

fail() {
  printf 'FAIL: %s\n' "$1" >&2
  exit 1
}

[ -f "$app_file" ] || fail "pixel-ecosystem-tank/index.html is missing"

grep -q '<canvas id="tank-canvas"' "$app_file" || fail "tank canvas missing"
grep -q 'const ECOLOGY_TICK_MS = 900;' "$app_file" || fail "ecology tick config missing"
grep -q 'calculateShannonDiversity' "$app_file" || fail "Shannon diversity logic missing"
grep -q 'state.tool === "food"' "$app_file" || fail "food click interaction missing"
grep -q 'addCreature(state.tool' "$app_file" || fail "spawn click interaction missing"
grep -q 'findNearestPrey' "$app_file" || fail "food chain targeting missing"
grep -q 'findPredator' "$app_file" || fail "flee behavior missing"
grep -q 'key: "coral"' "$app_file" || fail "coral species missing"
grep -q 'key: "bigFish"' "$app_file" || fail "big fish species missing"
grep -q 'unlockAt: 1.34' "$app_file" || fail "species unlock threshold missing"
grep -q 'id="collapse-overlay"' "$app_file" || fail "collapse overlay missing"
grep -q 'requestAnimationFrame(frame)' "$app_file" || fail "animation loop missing"

printf 'pixel ecosystem tank smoke test passed\n'
