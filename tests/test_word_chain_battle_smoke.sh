#!/usr/bin/env bash

set -euo pipefail

root_dir="$(cd "$(dirname "$0")/.." && pwd)"
app_file="$root_dir/word-chain-battle/index.html"

fail() {
  printf 'FAIL: %s\n' "$1" >&2
  exit 1
}

[ -f "$app_file" ] || fail "word-chain-battle/index.html is missing"

grep -q '<title>词语接龙擂台</title>' "$app_file" || fail "title missing"
grep -q 'data-mode="hotseat"' "$app_file" || fail "hotseat mode toggle missing"
grep -q 'data-mode="ai"' "$app_file" || fail "ai mode toggle missing"
grep -q 'data-language="zh"' "$app_file" || fail "chinese language toggle missing"
grep -q 'data-language="en"' "$app_file" || fail "english language toggle missing"
grep -q 'const ENGLISH_WORDS = \[' "$app_file" || fail "english lexicon missing"
grep -q 'const CHINESE_WORDS = \[' "$app_file" || fail "chinese lexicon missing"
grep -q 'requestAnimationFrame(tickTimer)' "$app_file" || fail "countdown loop missing"
grep -q 'Repeated word, immediate loss' "$app_file" || fail "duplicate rejection copy missing"
grep -q 'AI has no valid reply' "$app_file" || fail "ai fallback missing"
grep -q 'function renderChain' "$app_file" || fail "chain renderer missing"
grep -q 'function validateWord' "$app_file" || fail "validation logic missing"

printf 'word chain battle smoke test passed\n'
