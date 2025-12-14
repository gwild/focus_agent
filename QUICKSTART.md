# Quick Start: Deploy to Another Repo

## One-Liner

```bash
# From the focus repo directory:
./scripts/deploy.sh /path/to/target/repo
```

Or manually:

```bash
# Copy xtask and add to workspace
cp -r focus/xtask /path/to/target/repo/ && \
cd /path/to/target/repo && \
# Add "xtask" to [workspace] members in Cargo.toml, then:
cargo run -p xtask -- analyze
```

## Even Simpler (if target repo is current directory)

```bash
cp -r /path/to/focus/xtask . && \
# Edit Cargo.toml to add "xtask" to workspace members, then:
cargo run -p xtask -- analyze
```

## What It Does

1. Copies `xtask/` crate to target repo
2. Adds `xtask` to workspace `Cargo.toml` (if workspace exists)
3. You customize `xtask/policy.toml` for your structure
4. Run `cargo run -p xtask -- analyze` to see violations
5. Fix violations or adjust allowlists
6. Add `cargo run -p xtask` to CI

## Minimal Manual Steps

```bash
# 1. Copy
cp -r focus/xtask /path/to/repo/

# 2. Add to Cargo.toml workspace members
# Edit Cargo.toml: add "xtask" to members array

# 3. Customize policy
# Edit xtask/policy.toml - update allowlists

# 4. Analyze
cd /path/to/repo && cargo run -p xtask -- analyze

# 5. Review cleanup-plan.md and fix violations
```

That's it!

