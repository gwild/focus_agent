# ADR 0001: Single Source of Truth (SSOT) State Owner

## Status
Accepted

## Context
Without a clear "source of truth," concurrency becomes a pile of ad hoc queues and locks. LLM coding assistants (and humans) will steadily reintroduce hardcoded values, incidental locks, duplicated state, and one-off threading.

## Decision
We adopt an actor-style StateOwner pattern:

- One authoritative owner of state (`MachineState`)
- State type is **private** - cannot be named outside its module
- All mutation via `Command` enum
- All reads via `Snapshot`/`Event` types
- No direct state access from other modules

## Implementation
- `core` crate contains `MachineState` (private struct)
- `core` crate exposes `Command`, `Snapshot`, `Event` (public types)
- `core` crate exposes `StateOwner` (public handle)
- `runtime` crate uses `StateOwner`, never directly accesses `MachineState`

## Enforcement
- Compiler: `MachineState` is private, cannot be imported elsewhere
- Policy: `cargo xtask policy` scans for `MachineState` references outside allowed modules
- CI: Policy check required for merge

## Consequences
- **Positive**: Eliminates lock contention, prevents state duplication, makes policies enforceable
- **Negative**: Requires discipline to use `Command`/`Snapshot` API instead of direct access
- **Risk**: If policy is bypassed or not enforced, architectural drift resumes

## Notes
- This is enforced mechanically, not by convention
- Any PR adding a second "state owner" must update this ADR and justify the exception

