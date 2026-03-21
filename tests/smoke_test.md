# Smoke Test

- Issue: `test: end-to-end loop smoke test`
- Purpose: Minimal proof that the planner -> worker -> verifier loop executed end-to-end.
- Timestamp: `2026-03-19T00:00:00Z`
- Manual smoke target: `hex-chain-reaction/index.html`
- Manual smoke steps: switch to `Remote`, create a host offer, join from a second browser with the pasted offer, return the generated answer to the host, then verify Blue/Red turns, reset sync, and move sync across both clients.
