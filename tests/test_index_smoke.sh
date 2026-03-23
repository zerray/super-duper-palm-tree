#!/usr/bin/env bash

set -euo pipefail

root_dir="$(cd "$(dirname "$0")/.." && pwd)"
index_file="$root_dir/index.html"

fail() {
  printf 'FAIL: %s\n' "$1" >&2
  exit 1
}

[ -f "$index_file" ] || fail "root index.html is missing"

grep -q '<title>Agent Factory Arcade</title>' "$index_file" || fail "page title missing"
grep -q 'const games = \[' "$index_file" || fail "games metadata array missing"
grep -q '45 playable games' "$index_file" || fail "game count summary missing"
grep -q 'slug: "rhythm-dj-coop"' "$index_file" || fail "rhythm-dj-coop metadata missing"
grep -q 'slug: "magnetic-pong"' "$index_file" || fail "magnetic-pong metadata missing"
grep -q 'slug: "game-of-life"' "$index_file" || fail "game-of-life metadata missing"
grep -q 'slug: "nie-xiaoqian-rpg"' "$index_file" || fail "nie-xiaoqian-rpg metadata missing"
grep -q 'slug: "waveform-dj"' "$index_file" || fail "waveform-dj metadata missing"
grep -q 'slug: "pixel-coop-puzzle"' "$index_file" || fail "pixel-coop-puzzle metadata missing"
grep -q 'slug: "pixel-palette-puzzle"' "$index_file" || fail "pixel-palette-puzzle metadata missing"
grep -q 'const gamePath = game.path ?? `${game.slug}/index.html`;' "$index_file" || fail "game path fallback missing"
grep -q 'link.href = `./${gamePath}`;' "$index_file" || fail "dynamic play link template missing"
grep -q 'path: "snake-game/multiplayer.html"' "$index_file" || fail "snake multiplayer path metadata missing"
grep -q 'renderFilters' "$index_file" || fail "category filter rendering missing"
grep -q 'featuredGames' "$index_file" || fail "featured section missing"

while IFS= read -r path; do
  rel_path="${path#$root_dir/}"
  slug="${rel_path%/index.html}"
  grep -q "slug: \"$slug\"" "$index_file" || fail "missing card metadata for ${rel_path}"
done < <(find "$root_dir" -mindepth 2 -maxdepth 2 -path "$root_dir/tests" -prune -o -name 'index.html' -print | sort)

printf 'index showcase smoke test passed\n'
