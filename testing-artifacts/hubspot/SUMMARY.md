# HubSpot Trigger — Action-Level Verification Summary

**Scope:** All 41 remote functions across 7 service groups generated for the `hubspot`
webhook trigger (`CompanyService`, `ContactService`, `ConversationService`, `DealService`,
`TicketService`, `ProductService`, `LineItemService`).

**Method:** Attached all 7 generated service types to a single listener instance (harness in
`harness/`, copied verbatim from the shipped `asyncapi-triggers/asyncapi/hubspot/` connector
code — no generator/DSL changes), then sent one real HTTP POST per `subscriptionType` — a
single-element JSON event array, valid `X-HubSpot-Signature-v3` (HMAC-SHA256, base64,
`"POST" + callbackURL + payload.toString() + timestamp`, matching the connector's real
`validateSignature` logic) and a fresh `X-HubSpot-Request-Timestamp` — and confirmed via log
output that exactly the expected remote function fired. See `action_matrix.csv` for the full
per-action result (columns: `Tested`, `CodegenOK`, `Issue`).

**Payload source:** all 41 fixtures are schema-derived synthetic payloads (`payloads/`),
generated directly from the connector's `WebhookEvent` record (`data_types.bal`). Unlike
GitHub — where payload shape varies wildly per event and real `octokit/webhooks` fixtures were
used for the majority — HubSpot uses one uniform flat payload schema for every event type, so
synthetic generation covering the base fields plus each event family's extra fields
(`propertyChange`, `associationChange`, `merge`, `newMessage`) is representative; there's no
open-source corpus of real HubSpot webhook payloads to draw from as an alternative.

## Result: 41 / 41 pass

Every one of the 41 `subscriptionType` values dispatched to exactly the expected
`ServiceGroup::RemoteFunction`, with no misses, no misroutes, and no duplicate firings. No bugs
found in HubSpot's dispatch/signature-verification logic under this harness.

This differs from the GitHub trigger harness result (256/265, with 9 confirmed dispatch
failures caused by a composite event-identifier bug for action-less events). HubSpot's
dispatcher doesn't use the same composite `eventType_action` identifier scheme — it discriminates
purely on the body's `subscriptionType` field — so that entire bug class doesn't apply here.

## Notable implementation detail hit while building this harness

The connector's `validateSignature` hashes `payload.toString()` on the **re-parsed** `json`
value (parsed once via `request.getJsonPayload()`), not the raw request bytes. Confirmed via a
throwaway `.bal` script that Ballerina's `json:toString()` reproduces compact JSON
byte-for-byte for our fixture shape, so the driver hashes the literal fixture file content
directly — no separate canonicalization step was needed in the end, but this was verified
rather than assumed.

One iteration bug in the test driver itself (not the connector): the first pass at computing
the Unix-epoch-millis timestamp used `Get-Date "1970-01-01T00:00:00Z"` in Windows PowerShell
5.1, which silently parses the literal as **local** time (not UTC) despite the `Z` suffix,
producing timestamps off by the local UTC offset (+05:30, i.e. 19.8M ms) — comfortably outside
the connector's 5-minute freshness tolerance, so every request failed with `Request timeout
failure!` (HTTP 406) before signature verification was even reached. Fixed by switching to
`[DateTimeOffset]::UtcNow.ToUnixTimeMilliseconds()`.

## Files in this directory

- `action_matrix.csv` — full 41-row tracking sheet
- `payloads/` — one JSON payload per `subscriptionType` (41 files, single-element arrays)
- `test_results.csv` — raw HTTP status per request from the harness run
- `run_hubspot_harness.ps1` — the driver script (signs and POSTs each payload)
- `harness/` — the copied Ballerina connector package (all 7 services on one listener +
  `harness_services.bal` logging shim) + `harness_run.log` (full listener console output)
