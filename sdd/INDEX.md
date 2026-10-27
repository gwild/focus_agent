# Milton-specs → SDD-Text index

Canonical home for the generalized policy pattern: **this repo (`focus_agent`)**, not Milton.
Milton is a **consumer** of these contracts (gates, hooks, runtime).

Source of titles: `gwild/milton` `milton-specs.md` hard-rule list (rules 1–39).
Format: [SDD-Text 0.1](https://github.com/knutopia/Structured-Design-Documents).

| # | Title (short) | SDD path | Status | Primary enforcement (Milton consumer) |
|---|---|---|---|---|
| 1 | The PostgreSQL DB is the sole source of truth. | — (stub) | todo | — |
| 2 | `fuckyou.fuckyou` = bootstrap structure ONLY. | — (stub) | todo | — |
| 3 | NO seed. | — (stub) | todo | — |
| 4 | Local per-agent DB-transport broker (LDB) — the ONLY DB path (revised 2026-08-11). | — (stub) | todo | — |
| 5 | Each agent's `.env` holds ONLY its DB pass | — (stub) | todo | — |
| 6 | `deploy-agent.sh <agent>` is THE provisioner. | — (stub) | todo | — |
| 7 | Deploy is READ-ONLY against the DB. | — (stub) | todo | — |
| 8 | Agents are pure consumers. | — (stub) | todo | — |
| 9 | linux-only. | — (stub) | todo | — |
| 10 | Bot reviewers are not SOT. | — (stub) | todo | — |
| 11 | Two identity classes, never conflated: AGENTS vs SERVICES. | — (stub) | todo | — |
| 12 | `service-identity` is a DB role | — (stub) | todo | — |
| 13 | `services` is a REAL AGENT that runs the beelink daemons (and holds `service-identity`). | — (stub) | todo | — |
| 14 | NO service/daemon may be named "secretary". | — (stub) | todo | — |
| 15 | The config↔DB merge pattern is DEAD — there is NO going back (Gregory, 2026-08-11). | — (stub) | todo | — |
| 16 | Agent ↔ host is DECOUPLED — ownership is local-broker PRESENCE, not a `hostname` field … | — (stub) | todo | — |
| 17 | This contract is enforced BEFORE model work starts, on ALL provider runtimes (Gregory, … | — (stub) | todo | — |
| 18 | The config-as-baseline READERS #15 condemned are STILL IN THE CODE and ARE the current … | — (stub) | todo | — |
| 19 | NO silent, unbounded self-relaunch. A supervisor that keeps respawning a failing runtim… | — (stub) | todo | — |
| 20 | This is a DEV fleet, not live production — a self-healing transitional window is NOT a … | — (stub) | todo | — |
| 21 | A merge that needs post-merge followup MUST carry a reviewed Deployment plan — never im… | — (stub) | todo | — |
| 22 | Reuse the existing method — a new function id requires Gregory's EXPRESS permission and… | [`sdd/milton-specs/022-stable-id-reuse-existing.sdd`](milton-specs/022-stable-id-reuse-existing.sdd) | **drafted** (Mike cluster) | review + id system (`ldb_ops` / Op ids); #33 absolute form |
| 23 | Terminal commands posted for Gregory to paste MUST be short-line form — long one-liners… | — (stub) | todo | — |
| 24 | Providers and their model catalogs are DB-ONLY — never fuckyou.fuckyou (Gregory, 2026-0… | — (stub) | todo | — |
| 25 | Naming: `fleet_config` is SOT — never "override" (Gregory, 2026-08-27). | — (stub) | todo | — |
| 26 | Complete fuckyou.fuckyou purge — bootstrap only (Gregory, 2026-08-27; epic #3947). | — (stub) | todo | — |
| 27 | Channel assignments are DB-only (Gregory, 2026-08-27). | — (stub) | todo | — |
| 28 | Secrets never in fuckyou.fuckyou (Gregory, 2026-08-27). | — (stub) | todo | — |
| 29 | No agent chat tokens (Gregory, 2026-08-27). | — (stub) | todo | — |
| 30 | Agent `.env` is PG pass only (Gregory, 2026-08-27; clarifies #5). | — (stub) | todo | — |
| 31 | Shared OAuth across live seats is a KNOWN REGRESSION TRAP — single refresher + read-onl… | — (stub) | todo | — |
| 32 | NO POLLERS — event-driven only; and NEVER revive a mechanism under active replacement (… | [`sdd/milton-specs/032-no-pollers-event-driven.sdd`](milton-specs/032-no-pollers-event-driven.sdd) | **drafted** (Mike cluster) | `scripts/check-no-pollers.py` + mkpr + `specs-rules-gates` CI |
| 33 | HAND-ROLLING IS FORBIDDEN — use the canonical skill / hook / script, ALWAYS (Gregory, 2… | [`sdd/milton-specs/033-canonical-skill-hook-script.sdd`](milton-specs/033-canonical-skill-hook-script.sdd) | **drafted** (Mike cluster) | reviewer reject of hand-rolls; skills/hooks/scripts SSOT |
| 34 | LOCAL QWEN / LOCAL GGUF IS NOT SITED THROUGH CODEX — EVER (Gregory, 2026-08-31; reinfor… | — (stub) | todo | — |
| 35 | Bootstrap file (`fuckyou.fuckyou` / `CONFIG_FILE`) is LAST RESORT when investigating ag… | — (stub) | todo | — |
| 36 | Bootstrap file (`fuckyou.fuckyou` / `CONFIG_FILE`) — ONE read-only loader, ONE read at … | — (stub) | todo | — |
| 37 | NO new content-yaml — subsystem data lives in the DB, PERIOD (Gregory, 2026-09-14). | — (stub) | todo | — |
| 38 | Every work completion needs JEV and Attractor receipts (Gregory, 2026-10-06; issue #4409). | — (stub) | todo | — |
| 39 | Fleet agents do not create draft pull requests (Gregory, 2026-10-06). | — (stub) | todo | — |

## Cluster ownership (v1)

- **#22 / #32 / #33** — Mike draft; Rebecca reviews “what counts as a rule”; Elliot integrator.
- Remaining rows — fill as Phase 1 continues (CI-gated rules first per pipeline plan).

## Adoption note

A rule that is only prose in Milton and has no SDD here is **aspirational** until translated.
focus_agent principle: if it is not enforced by the compiler or CI, it is not a rule.

