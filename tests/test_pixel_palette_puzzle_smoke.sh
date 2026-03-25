#!/usr/bin/env bash

set -euo pipefail

root_dir="$(cd "$(dirname "$0")/.." && pwd)"
app_file="$root_dir/pixel-palette-puzzle/index.html"

fail() {
  printf 'FAIL: %s\n' "$1" >&2
  exit 1
}

[ -f "$app_file" ] || fail "pixel-palette-puzzle/index.html is missing"

grep -q '<title>像素调色板：合作拼图</title>' "$app_file" || fail "page title missing"
grep -q 'const PATTERNS = \[' "$app_file" || fail "pattern presets missing"
grep -q 'id: "heart-8"' "$app_file" || fail "heart preset missing"
grep -q 'id: "flower-8"' "$app_file" || fail "flower preset missing"
grep -q 'id: "kite-8"' "$app_file" || fail "kite preset missing"
grep -q 'id: "planet-12"' "$app_file" || fail "planet preset missing"
grep -q 'id: "castle-12"' "$app_file" || fail "castle preset missing"
grep -q '热座模式：两人轮流操作，每回合固定 15 秒。' "$app_file" || fail "hot-seat copy missing"
grep -q '同屏模式：玩家 1 用鼠标画左半边，玩家 2 用方向键和数字键画右半边。' "$app_file" || fail "same-screen copy missing"
grep -q '单人模式：直接使用全部 6 色，无需传色。' "$app_file" || fail "solo copy missing"
grep -q '评分 = 正确像素数 / 总像素数。' "$app_file" || fail "score formula copy missing"
grep -q 'const HOTSEAT_TURN_SECONDS = 15;' "$app_file" || fail "hot-seat timer constant missing"
grep -q 'function transferColor' "$app_file" || fail "transfer mechanic missing"
grep -q 'function animateTransfer' "$app_file" || fail "transfer animation missing"
grep -q 'function handleSameScreenKeys' "$app_file" || fail "same-screen keyboard controls missing"
grep -q 'function computeAccuracy' "$app_file" || fail "accuracy scoring missing"
grep -q 'id="target-canvas"' "$app_file" || fail "target canvas missing"
grep -q 'id="board-canvas"' "$app_file" || fail "board canvas missing"
grep -q 'id="transfer-layer"' "$app_file" || fail "transfer visual layer missing"
grep -q '<option value="hotseat">热座双人</option>' "$app_file" || fail "hot-seat mode option missing"
grep -q '<option value="same-screen">同屏双人</option>' "$app_file" || fail "same-screen mode option missing"
grep -q '<option value="solo">单人练习</option>' "$app_file" || fail "solo mode option missing"

printf 'pixel palette puzzle smoke test passed\n'
