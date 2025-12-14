# focus

A Rust workspace with mechanical enforcement of architectural invariants to prevent LLM coding assistants (and humans) from introducing architectural violations.

## Core Principle

**"If a rule is not enforced by the compiler or CI, it is not a rule."**

## Architecture

### Workspace Structure

- **`xtask/`** - Policy enforcement agent (runs `cargo xtask policy`)
- **`core/`** - Pure state machine (NO tokio, NO std::sync, NO async, NO I/O)
- **`runtime/`** - All side effects (threads, async, sockets, serial I/O)

### Single Source of Truth (SSOT)

- `MachineState` is **private** - cannot be named outside `core/src/state.rs`
- All mutation via `Command` enum
- All reads via `Snapshot`/`Event` types
- Runtime uses `StateOwner` handle, never directly accesses `MachineState`

### Enforcement Rules

The policy checker (`cargo xtask policy`) enforces:

1. **No locks outside allowlist** (`runtime/`, `drivers/`, `xtask/`, `tests/`)
2. **No spawning outside allowlist** (`runtime/scheduler.rs`, `runtime/main.rs`)
3. **No `MachineState` references outside owner module**

## Usage

### Run Policy Check

```bash
# Quick check (exits with error code on violations)
cargo run -p xtask

# Or explicitly:
cargo run -p xtask -- check
```

### Generate Cleanup Plan

For existing repos, generate a detailed cleanup plan:

```bash
cargo run -p xtask -- analyze

# Or specify output file:
cargo run -p xtask -- analyze --output my-plan.md
```

This creates a markdown file with:
- Violation summary
- Prioritized recommendations
- Detailed violation list
- Next steps

The policy checker reads configuration from `xtask/policy.toml`. Customize this file to match your repo structure.

### Installing in Other Repos

This enforcement system can be installed in any Rust workspace. See `INSTALL.md` for detailed instructions.

**Quick install:**
1. Copy `xtask/` crate to your repo
2. Add `xtask` to your workspace `Cargo.toml`
3. Customize `xtask/policy.toml` for your structure
4. Add `cargo run -p xtask` to your CI

### Build

```bash
cargo build
```

### Test

```bash
cargo test
```

### Format

```bash
cargo fmt
```

### Lint

```bash
cargo clippy --all-targets --all-features -- -D warnings
```

## CI/CD

GitHub Actions workflow (`.github/workflows/ci.yml`) runs:

1. Policy gate (`cargo run -p xtask`)
2. Format check (`cargo fmt --check`)
3. Clippy (`cargo clippy --all-targets --all-features -- -D warnings`)
4. Tests (`cargo test --all-features`)
5. Cargo deny (`cargo deny check`)

**CI is required for merge** (enforced by branch protection).

## Architecture Decision Records

See `docs/adr/` for documented architectural decisions:

- `0001-state-owner.md` - Single Source of Truth pattern
- `0002-telemetry-policy.md` - Queue policies for GUI/logging/control
- `0003-config-policy.md` - Configuration centralization

## Protected Paths

Changes to these paths require CODEOWNERS approval:

- `/xtask/` - Policy enforcement agent
- `/docs/adr/` - Architecture Decision Records
- `/runtime/scheduler.rs` - Concurrency choke point
- `/Cargo.toml` - Dependency configuration
- `/deny.toml` - Cargo deny configuration

## Next Steps

Once the cage is built, you can:

1. Implement `MachineState` with actual fields
2. Add `Command` variants for your domain
3. Build state transition logic
4. Wire up runtime with channels and actors
5. Add GUI, logging, hardware drivers within constraints

**Remember**: You're building the constitution first, then the robot.

## References

See `PLAN.md` for the full implementation plan and `focus_agent` for the original conversation that inspired this architecture.
