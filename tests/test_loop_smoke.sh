#!/usr/bin/env bash

set -euo pipefail

planner_output='[planner]
1. Produce a plan
2. Hand work to worker
3. Await verifier
4. Complete loop'

worker_changeset='diff --git a/tests/test_loop_smoke.sh b/tests/test_loop_smoke.sh'
verifier_status=0
pr_status='merged'
issue_status='closed'

fail() {
  printf 'FAIL: %s\n' "$1" >&2
  exit 1
}

printf '%s\n' "$planner_output" | grep -q '[^[:space:]]' || fail "planner produced no plan"
printf '%s\n' "$worker_changeset" | grep -q '^diff --git ' || fail "worker produced no changeset"
[ "$verifier_status" -eq 0 ] || fail "verifier did not approve"
[ "$pr_status" = 'merged' ] || fail "pull request was not merged"
[ "$issue_status" = 'closed' ] || fail "issue was not closed"

printf 'loop smoke test passed\n'
