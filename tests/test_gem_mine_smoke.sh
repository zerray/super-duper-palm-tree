#!/usr/bin/env bash

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TARGET="$ROOT_DIR/gem-mine-clicker/index.html"

[[ -f "$TARGET" ]]

grep -q "<!DOCTYPE html>" "$TARGET"
grep -q "localStorage" "$TARGET"
grep -q "requestAnimationFrame" "$TARGET"
grep -qi "prestige" "$TARGET"
grep -qi "particle" "$TARGET"

echo "gem mine smoke test passed"
