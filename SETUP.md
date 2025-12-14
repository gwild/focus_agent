# Setup Instructions

## Prerequisites

- Rust toolchain (stable)
- `ripgrep` (rg) - for policy checks

### Install ripgrep

**macOS:**
```bash
brew install ripgrep
```

**Linux:**
```bash
sudo apt-get install ripgrep
# or
sudo yum install ripgrep
```

**Windows:**
```bash
choco install ripgrep
# or download from https://github.com/BurntSushi/ripgrep/releases
```

## Initial Setup

1. **Clone the repository**
   ```bash
   git clone <repo-url>
   cd focus
   ```

2. **Verify workspace builds**
   ```bash
   cargo check
   ```

3. **Run policy check**
   ```bash
   cargo run -p xtask
   ```
   
   If ripgrep is not installed, you'll see warnings but the check will still compile.

4. **Install pre-commit hook** (if not already installed)
   ```bash
   chmod +x .git/hooks/pre-commit
   ```

## Development Workflow

### Before Committing

The pre-commit hook automatically runs policy checks. To run manually:

```bash
cargo run -p xtask
```

### Before Pushing

Ensure all checks pass:

```bash
cargo fmt --check
cargo clippy --all-targets --all-features -- -D warnings
cargo test
cargo run -p xtask
```

### CI/CD

GitHub Actions will run all checks automatically on:
- Pull requests
- Pushes to `main` branch

**CI must pass before merge** (enforced by branch protection).

## Troubleshooting

### Policy check fails locally

1. Check which rule failed (see output)
2. Fix the violation:
   - Move locks to allowed modules (`runtime/`, `drivers/`)
   - Move thread spawning to `runtime/scheduler.rs`
   - Remove `MachineState` references outside `core/src/state.rs`
3. Re-run: `cargo run -p xtask`

### Pre-commit hook not running

Check if hook is executable:
```bash
ls -la .git/hooks/pre-commit
```

If missing or not executable:
```bash
chmod +x .git/hooks/pre-commit
```

### ripgrep not found

Install ripgrep (see Prerequisites). Policy checks will still compile but won't scan code.

## Next Steps

Once setup is complete:

1. Review Architecture Decision Records in `docs/adr/`
2. Understand the enforcement rules in `PLAN.md`
3. Start implementing your domain logic within the constraints

