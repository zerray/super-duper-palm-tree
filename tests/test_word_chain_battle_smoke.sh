#!/usr/bin/env bash

set -euo pipefail

root_dir="$(cd "$(dirname "$0")/.." && pwd)"
app_file="$root_dir/word-chain-battle/index.html"
index_file="$root_dir/index.html"

fail() {
  printf 'FAIL: %s\n' "$1" >&2
  exit 1
}

[ -f "$app_file" ] || fail "word-chain-battle/index.html is missing"

grep -q '<title>词语接龙擂台</title>' "$app_file" || fail "page title missing"
grep -q 'start-hotseat' "$app_file" || fail "hotseat start control missing"
grep -q 'start-ai' "$app_file" || fail "AI start control missing"
grep -q 'Round Timer' "$app_file" || fail "timer UI missing"
grep -q 'requestAnimationFrame(tickTimer)' "$app_file" || fail "countdown loop missing"
grep -q 'const ENGLISH_WORDS = \[' "$app_file" || fail "english dictionary missing"
grep -q 'const CHINESE_WORDS = \[' "$app_file" || fail "chinese dictionary missing"
grep -q 'getValidWordsForCurrentTurn' "$app_file" || fail "AI candidate lookup missing"
grep -q '接龙失败' "$app_file" || fail "invalid chain feedback missing"
grep -q '词语链' "$app_file" || fail "chain visualization copy missing"

grep -q 'slug: "word-chain-battle"' "$index_file" || fail "root index card missing"
grep -q '46 playable games' "$index_file" || fail "root game count not updated"

printf 'word chain battle smoke test passed\n'
