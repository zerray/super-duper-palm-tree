#!/usr/bin/env bash

set -euo pipefail

root_dir="$(cd "$(dirname "$0")/.." && pwd)"
app_file="$root_dir/word-chain-battle/index.html"

fail() {
  printf 'FAIL: %s\n' "$1" >&2
  exit 1
}

[ -f "$app_file" ] || fail "word-chain-battle/index.html is missing"

grep -q '<title>词语接龙擂台</title>' "$app_file" || fail "page title missing"
grep -q 'const englishWords = `' "$app_file" || fail "english dictionary missing"
grep -q 'const chineseWords = `' "$app_file" || fail "chinese dictionary missing"
grep -q 'function chooseAiWord' "$app_file" || fail "AI move picker missing"
grep -q 'function validateWord' "$app_file" || fail "validation logic missing"
grep -q 'function getRoundDuration' "$app_file" || fail "round timer scaling missing"
grep -q 'function renderChain' "$app_file" || fail "chain rendering missing"
grep -q 'AI 没有找到未使用且合法的接龙词' "$app_file" || fail "AI defeat copy missing"
grep -q '玩家 1 先手，可以先输入任意内置词。' "$app_file" || fail "start status missing"

printf 'word chain battle smoke test passed\n'
