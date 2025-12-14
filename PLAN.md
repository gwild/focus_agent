# Focus: Architectural Enforcement System Plan

## Overview
Build a Rust workspace with mechanical enforcement of architectural invariants to prevent LLM coding assistants (and humans) from introducing architectural violations.

**Core Principle**: "If a rule is not enforced by the compiler or CI, it is not a rule."

## Architecture Invariants

### 1. Single Source of Truth (SSOT)
- One authoritative `MachineState` owner
- State type is **private** - cannot be named outside its module
- All mutation via `Command` enum
- All reads via `Snapshot`/`Event` types
- No direct state access from other modules

### 2. No Locks in Core
- `core` crate: no `std::sync`, no `tokio`, no async, no I/O
- Pure state transitions only
- Locks allowed only in `runtime/` and `drivers/` (enforced by policy)

### 3. Controlled Concurrency
- Only one module can spawn threads/tasks (`runtime/scheduler.rs`)
- No ad-hoc thread spawning elsewhere
- Bounded channels only (no unbounded queues)

### 4. Centralized Configuration
- All tunable parameters come from `Config` struct
- No hardcoded "knobs" (FFT sizes, sample rates, queue capacities)
- Fail fast if config missing

## Implementation Sequence

### Phase 1: Foundation (Cage First)
**Goal**: Build the enforcement mechanism before any application code

1. **Create workspace structure**
   - Root `Cargo.toml` with workspace members: `xtask`, `core`, `runtime`
   - This separation is the first architectural constraint

2. **Create `xtask` crate FIRST** (non-negotiable)
   - Purpose: policy enforcement agent
   - No production logic
   - Will be protected by CODEOWNERS later

3. **Implement `cargo xtask policy`**
   - Ripgrep-based policy scanner
   - Checks:
     - No locks outside allowlist (`runtime/`, `drivers/`, `xtask/`, `tests/`)
     - No spawning outside allowlist (`runtime/scheduler.rs`, `runtime/main.rs`)
     - No `MachineState` references outside owner module
     - Optional: no magic number literals outside `config/knobs.rs`
   - Exits non-zero on violations

4. **Create `core` crate**
   - Pure state machine
   - No dependencies on: `tokio`, `std::sync`, `parking_lot`
   - Contains: `MachineState` (private), `Command`, `Snapshot`, `Event` (public)
   - Single function: `apply_command(&mut self, cmd: Command) -> Vec<Event>`

5. **Create `runtime` crate**
   - All side effects live here
   - Depends on `core`, not vice versa
   - Owns: threads, async, sockets, serial I/O
   - Runs state owner loop

### Phase 2: CI & Enforcement
**Goal**: Make violations impossible to merge

6. **GitHub Actions CI workflow**
   - Runs: `cargo xtask policy`
   - Runs: `cargo fmt --check`
   - Runs: `cargo clippy --all-targets --all-features -- -D warnings`
   - Runs: `cargo test`
   - Runs: `cargo deny check`
   - **Required for merge** (branch protection)

7. **cargo deny configuration**
   - Ban unwanted crates (e.g., `parking_lot` if standardizing on `tokio`)
   - Enforce license policy
   - Dependency allowlist/denylist

8. **Pre-commit hook**
   - Local fast feedback
   - Runs policy check before commit
   - Prevents "I didn't notice" violations

### Phase 3: Documentation
**Goal**: Make architectural decisions explicit and reviewable

9. **Architecture Decision Records (ADRs)**
   - `docs/adr/0001-state-owner.md`
   - `docs/adr/0002-telemetry-policy.md`
   - `docs/adr/0003-config-policy.md`
   - Any PR adding locks/second state owner/new config path must update ADRs

10. **CODEOWNERS file**
    - Protect: `xtask/`, `docs/adr/`, `runtime/`, `Cargo.toml`
    - Changes to policy require explicit approval

## Policy Rules (Enforced by xtask)

### Lock Policy
**Forbidden patterns** (outside allowlist):
- `std::sync::Mutex`
- `std::sync::RwLock`
- `tokio::sync::Mutex`
- `tokio::sync::RwLock`
- `parking_lot::Mutex`
- `parking_lot::RwLock`
- `\.lock\(\)\.await`

**Allowed in**: `runtime/`, `drivers/`, `xtask/`, `tests/`

### Spawning Policy
**Forbidden patterns** (outside allowlist):
- `std::thread::spawn`
- `tokio::spawn`
- `tokio::task::spawn`

**Allowed in**: `runtime/scheduler.rs`, `runtime/main.rs`, `xtask/`, `tests/`

### SSOT Policy
**Forbidden**: `MachineState` identifier outside owner module

**Allowed in**: `state_owner.rs`, `state/`, `xtask/`, `tests/`

## Directory Structure

```
focus/
├── Cargo.toml          # Workspace root
├── xtask/              # Policy enforcement agent
│   ├── Cargo.toml
│   └── src/
│       └── main.rs     # Policy checker
├── core/               # Pure state machine
│   ├── Cargo.toml     # No tokio, no std::sync
│   └── src/
│       ├── lib.rs
│       └── state.rs    # MachineState (private), Command/Snapshot/Event (public)
├── runtime/            # All side effects
│   ├── Cargo.toml     # Depends on core
│   └── src/
│       ├── main.rs
│       └── scheduler.rs # Only place that spawns threads/tasks
├── .github/
│   └── workflows/
│       └── ci.yml      # Policy gate + standard checks
├── docs/
│   └── adr/           # Architecture Decision Records
├── deny.toml          # cargo deny config
└── README.md
```

## Success Criteria

1. ✅ `cargo xtask policy` runs and catches violations
2. ✅ CI fails if policy violations exist
3. ✅ Cannot add `Mutex` to `core` crate (compile error + policy violation)
4. ✅ Cannot reference `MachineState` outside owner module (policy violation)
5. ✅ Cannot spawn threads outside `runtime/scheduler.rs` (policy violation)
6. ✅ Branch protection requires CI to pass before merge

## Next Steps After Foundation

Once the cage is built:
- Implement `MachineState` with actual fields
- Add `Command` variants for your domain
- Build state transition logic
- Wire up runtime with channels and actors
- Add GUI, logging, hardware drivers within constraints

**Remember**: You're building the constitution first, then the robot.

