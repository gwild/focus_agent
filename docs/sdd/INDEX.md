# Milton-specs → SDD-Text index

**This PR is a slice only** ([focus_agent#2](https://github.com/gwild/focus_agent/pull/2)): SDD-Text for **#22 / #32 / #33**.
Canonical home: **gwild/focus_agent** `docs/sdd/` (not Milton). Shape: Milton `docs/sdd/template.sdd`.

## What counts as a focus_agent rule

Per counsel: a focus_agent **rule** = SDD **plus** a fail-closed executable check (compiler or CI/xtask).
SDD + journey/reviewer-reject alone = **aspirational at focus_agent** (Milton may still bind via review).
Do not mark a row DONE until the enforcer exists.

| # | Title (short) | SDD path | Status | Enforcement notes |
|---|---|---|---|---|
| 1 | The PostgreSQL DB is the sole source of truth. | — | deferred — owner pipeline; tracking [focus_agent#1](https://github.com/gwild/focus_agent/issues/1); reason=out-of-slice for [PR #2](https://github.com/gwild/focus_agent/pull/2) | not in #22/#32/#33 slice |
| 2 | `fuckyou.fuckyou` = bootstrap structure ONLY. | — | deferred — owner pipeline; tracking [focus_agent#1](https://github.com/gwild/focus_agent/issues/1); reason=out-of-slice for [PR #2](https://github.com/gwild/focus_agent/pull/2) | not in #22/#32/#33 slice |
| 3 | NO seed. | — | deferred — owner pipeline; tracking [focus_agent#1](https://github.com/gwild/focus_agent/issues/1); reason=out-of-slice for [PR #2](https://github.com/gwild/focus_agent/pull/2) | not in #22/#32/#33 slice |
| 4 | Local per-agent DB-transport broker (LDB) — the ONLY DB path (revised 2026-08-11). | [`docs/sdd/004-broker-only-db-path.sdd`](004-broker-only-db-path.sdd) | SDD drafted; enforcer deferred | SDD drafted; focus_agent enforcer DEFERRED (review≠rule). Milton broker+connector gates until CI/xtask. |
| 5 | Each agent's `.env` holds ONLY its DB pass | [`docs/sdd/005-env-holds-only-db-pass.sdd`](005-env-holds-only-db-pass.sdd) | SDD drafted; enforcer deferred | SDD drafted; focus_agent enforcer DEFERRED. Clarified by #30. |
| 6 | `deploy-agent.sh <agent>` is THE provisioner. | — | deferred — owner pipeline; tracking [focus_agent#1](https://github.com/gwild/focus_agent/issues/1); reason=out-of-slice for [PR #2](https://github.com/gwild/focus_agent/pull/2) | not in #22/#32/#33 slice |
| 7 | Deploy is READ-ONLY against the DB. | — | deferred — owner pipeline; tracking [focus_agent#1](https://github.com/gwild/focus_agent/issues/1); reason=out-of-slice for [PR #2](https://github.com/gwild/focus_agent/pull/2) | not in #22/#32/#33 slice |
| 8 | Agents are pure consumers. | — | deferred — owner pipeline; tracking [focus_agent#1](https://github.com/gwild/focus_agent/issues/1); reason=out-of-slice for [PR #2](https://github.com/gwild/focus_agent/pull/2) | not in #22/#32/#33 slice |
| 9 | linux-only. | — | deferred — owner pipeline; tracking [focus_agent#1](https://github.com/gwild/focus_agent/issues/1); reason=out-of-slice for [PR #2](https://github.com/gwild/focus_agent/pull/2) | not in #22/#32/#33 slice |
| 10 | Bot reviewers are not SOT. | — | deferred — owner pipeline; tracking [focus_agent#1](https://github.com/gwild/focus_agent/issues/1); reason=out-of-slice for [PR #2](https://github.com/gwild/focus_agent/pull/2) | not in #22/#32/#33 slice |
| 11 | Two identity classes, never conflated: AGENTS vs SERVICES. | — | deferred — owner pipeline; tracking [focus_agent#1](https://github.com/gwild/focus_agent/issues/1); reason=out-of-slice for [PR #2](https://github.com/gwild/focus_agent/pull/2) | not in #22/#32/#33 slice |
| 12 | `service-identity` is a DB role | — | deferred — owner pipeline; tracking [focus_agent#1](https://github.com/gwild/focus_agent/issues/1); reason=out-of-slice for [PR #2](https://github.com/gwild/focus_agent/pull/2) | not in #22/#32/#33 slice |
| 13 | `services` is a REAL AGENT that runs the beelink daemons (and holds `service-… | — | deferred — owner pipeline; tracking [focus_agent#1](https://github.com/gwild/focus_agent/issues/1); reason=out-of-slice for [PR #2](https://github.com/gwild/focus_agent/pull/2) | not in #22/#32/#33 slice |
| 14 | NO service/daemon may be named "secretary". | — | deferred — owner pipeline; tracking [focus_agent#1](https://github.com/gwild/focus_agent/issues/1); reason=out-of-slice for [PR #2](https://github.com/gwild/focus_agent/pull/2) | not in #22/#32/#33 slice |
| 15 | The config↔DB merge pattern is DEAD — there is NO going back (Gregory, 2026-0… | — | deferred — owner pipeline; tracking [focus_agent#1](https://github.com/gwild/focus_agent/issues/1); reason=out-of-slice for [PR #2](https://github.com/gwild/focus_agent/pull/2) | not in #22/#32/#33 slice |
| 16 | Agent ↔ host is DECOUPLED — ownership is local-broker PRESENCE, not a `hostna… | — | deferred — owner pipeline; tracking [focus_agent#1](https://github.com/gwild/focus_agent/issues/1); reason=out-of-slice for [PR #2](https://github.com/gwild/focus_agent/pull/2) | not in #22/#32/#33 slice |
| 17 | This contract is enforced BEFORE model work starts, on ALL provider runtimes … | — | deferred — owner pipeline; tracking [focus_agent#1](https://github.com/gwild/focus_agent/issues/1); reason=out-of-slice for [PR #2](https://github.com/gwild/focus_agent/pull/2) | not in #22/#32/#33 slice |
| 18 | The config-as-baseline READERS #15 condemned are STILL IN THE CODE and ARE th… | — | deferred — owner pipeline; tracking [focus_agent#1](https://github.com/gwild/focus_agent/issues/1); reason=out-of-slice for [PR #2](https://github.com/gwild/focus_agent/pull/2) | not in #22/#32/#33 slice |
| 19 | NO silent, unbounded self-relaunch. A supervisor that keeps respawning a fail… | — | deferred — owner pipeline; tracking [focus_agent#1](https://github.com/gwild/focus_agent/issues/1); reason=out-of-slice for [PR #2](https://github.com/gwild/focus_agent/pull/2) | not in #22/#32/#33 slice |
| 20 | This is a DEV fleet, not live production — a self-healing transitional window… | — | deferred — owner pipeline; tracking [focus_agent#1](https://github.com/gwild/focus_agent/issues/1); reason=out-of-slice for [PR #2](https://github.com/gwild/focus_agent/pull/2) | not in #22/#32/#33 slice |
| 21 | A merge that needs post-merge followup MUST carry a reviewed Deployment plan … | — | deferred — owner pipeline; tracking [focus_agent#1](https://github.com/gwild/focus_agent/issues/1); reason=out-of-slice for [PR #2](https://github.com/gwild/focus_agent/pull/2) | not in #22/#32/#33 slice |
| 22 | Reuse the existing method — a new function id requires Gregory's EXPRESS perm… | [`docs/sdd/022-stable-id-reuse-existing.sdd`](022-stable-id-reuse-existing.sdd) | SDD drafted; enforcer deferred | SDD drafted; focus_agent enforcer DEFERRED (review≠rule). Milton reviewer+ldb_ops until CI/xtask gate. |
| 23 | Terminal commands posted for Gregory to paste MUST be short-line form — long … | — | deferred — owner pipeline; tracking [focus_agent#1](https://github.com/gwild/focus_agent/issues/1); reason=out-of-slice for [PR #2](https://github.com/gwild/focus_agent/pull/2) | not in #22/#32/#33 slice |
| 24 | Providers and their model catalogs are DB-ONLY — never fuckyou.fuckyou (Grego… | — | deferred — owner pipeline; tracking [focus_agent#1](https://github.com/gwild/focus_agent/issues/1); reason=out-of-slice for [PR #2](https://github.com/gwild/focus_agent/pull/2) | not in #22/#32/#33 slice |
| 25 | Naming: `fleet_config` is SOT — never "override" (Gregory, 2026-08-27). | — | deferred — owner pipeline; tracking [focus_agent#1](https://github.com/gwild/focus_agent/issues/1); reason=out-of-slice for [PR #2](https://github.com/gwild/focus_agent/pull/2) | not in #22/#32/#33 slice |
| 26 | Complete fuckyou.fuckyou purge — bootstrap only (Gregory, 2026-08-27; epic #3… | — | deferred — owner pipeline; tracking [focus_agent#1](https://github.com/gwild/focus_agent/issues/1); reason=out-of-slice for [PR #2](https://github.com/gwild/focus_agent/pull/2) | not in #22/#32/#33 slice |
| 27 | Channel assignments are DB-only (Gregory, 2026-08-27). | — | deferred — owner pipeline; tracking [focus_agent#1](https://github.com/gwild/focus_agent/issues/1); reason=out-of-slice for [PR #2](https://github.com/gwild/focus_agent/pull/2) | not in #22/#32/#33 slice |
| 28 | Secrets never in fuckyou.fuckyou (Gregory, 2026-08-27). | [`docs/sdd/028-no-secrets-in-yaml.sdd`](028-no-secrets-in-yaml.sdd) | SDD drafted; enforcer deferred | SDD drafted; focus_agent enforcer DEFERRED. Milton bootstrap/content-yaml gates until CI/xtask. |
| 29 | No agent chat tokens (Gregory, 2026-08-27). | [`docs/sdd/029-no-agent-chat-tokens.sdd`](029-no-agent-chat-tokens.sdd) | SDD drafted; enforcer deferred | SDD drafted; focus_agent enforcer DEFERRED. Milton chat-token architecture gate until CI/xtask. |
| 30 | Agent `.env` is PG pass only (Gregory, 2026-08-27; clarifies #5). | [`docs/sdd/030-env-pg-user-password-only.sdd`](030-env-pg-user-password-only.sdd) | SDD drafted; enforcer deferred | SDD drafted; focus_agent enforcer DEFERRED. Exact `PG_USER`+`PG_PASSWORD` allowlist. |
| 31 | Shared OAuth across live seats is a KNOWN REGRESSION TRAP — single refresher … | — | deferred — owner pipeline; tracking [focus_agent#1](https://github.com/gwild/focus_agent/issues/1); reason=out-of-slice for [PR #2](https://github.com/gwild/focus_agent/pull/2) | not in #22/#32/#33 slice |
| 32 | NO POLLERS — event-driven only; and NEVER revive a mechanism under active rep… | [`docs/sdd/032-no-pollers-event-driven.sdd`](032-no-pollers-event-driven.sdd) | **RULE** (SDD + fail-closed gate) | focus_agent RULE via Milton consumer: check-no-pollers + mkpr + specs-rules-gates (fail-closed). |
| 33 | HAND-ROLLING IS FORBIDDEN — use the canonical skill / hook / script, ALWAYS (… | [`docs/sdd/033-canonical-skill-hook-script.sdd`](033-canonical-skill-hook-script.sdd) | SDD drafted; enforcer deferred | SDD drafted; focus_agent enforcer DEFERRED (review≠rule). Milton reviewer reject until CI/xtask gate. |
| 34 | LOCAL QWEN / LOCAL GGUF IS NOT SITED THROUGH CODEX — EVER (Gregory, 2026-08-3… | — | deferred — owner pipeline; tracking [focus_agent#1](https://github.com/gwild/focus_agent/issues/1); reason=out-of-slice for [PR #2](https://github.com/gwild/focus_agent/pull/2) | not in #22/#32/#33 slice |
| 35 | Bootstrap file (`fuckyou.fuckyou` / `CONFIG_FILE`) is LAST RESORT when invest… | — | deferred — owner pipeline; tracking [focus_agent#1](https://github.com/gwild/focus_agent/issues/1); reason=out-of-slice for [PR #2](https://github.com/gwild/focus_agent/pull/2) | not in #22/#32/#33 slice |
| 36 | Bootstrap file (`fuckyou.fuckyou` / `CONFIG_FILE`) — ONE read-only loader, ON… | — | deferred — owner pipeline; tracking [focus_agent#1](https://github.com/gwild/focus_agent/issues/1); reason=out-of-slice for [PR #2](https://github.com/gwild/focus_agent/pull/2) | not in #22/#32/#33 slice |
| 37 | NO new content-yaml — subsystem data lives in the DB, PERIOD (Gregory, 2026-0… | — | deferred — owner pipeline; tracking [focus_agent#1](https://github.com/gwild/focus_agent/issues/1); reason=out-of-slice for [PR #2](https://github.com/gwild/focus_agent/pull/2) | not in #22/#32/#33 slice |
| 38 | Every work completion needs JEV and Attractor receipts (Gregory, 2026-10-06; … | — | deferred — owner pipeline; tracking [focus_agent#1](https://github.com/gwild/focus_agent/issues/1); reason=out-of-slice for [PR #2](https://github.com/gwild/focus_agent/pull/2) | not in #22/#32/#33 slice |
| 39 | Fleet agents do not create draft pull requests (Gregory, 2026-10-06). | — | deferred — owner pipeline; tracking [focus_agent#1](https://github.com/gwild/focus_agent/issues/1); reason=out-of-slice for [PR #2](https://github.com/gwild/focus_agent/pull/2) | not in #22/#32/#33 slice |

## Slice owners

- Mike — draft #22/#32/#33 + INDEX
- Rebecca — rule-language / what counts as a rule
- Elliot — integrator; fold Ivy drafts onto this branch
- Ivy — #4/#5/#28–30 security draft + review

