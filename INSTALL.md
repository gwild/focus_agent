# Installing Policy Enforcement in Other Repos

The policy enforcement system can be installed in any Rust workspace. Here's how:

## Status

**Note**: `xtask` is currently in development and will become a git submodule for easier sharing.

## Quick Install (Current: Copy Method)

1. **Copy the `xtask` crate** to your repo:
   ```bash
   cp -r focus/xtask /path/to/your/repo/
   ```

## Future: Submodule Method

Once `xtask` is stable, it will be available as a git submodule:

```bash
git submodule add <xtask-repo-url> xtask
git submodule update --init --recursive
```

Then customize `xtask/policy.toml` for your repo structure.

2. **Add `xtask` to your workspace** (`Cargo.toml`):
   ```toml
   [workspace]
   members = ["xtask", "your_other_crates"]
   ```

3. **Customize `xtask/policy.toml`** for your repo structure:
   - Update `lock_allowed` paths
   - Update `spawn_allowed` paths  
   - Update `ssot_allowed` paths
   - Update `ssot_types` if you use different state type names

4. **Add to CI** (`.github/workflows/ci.yml`):
   ```yaml
   - name: Policy gate
     run: cargo run -p xtask
   ```

5. **Optional: Add pre-commit hook**:
   ```bash
   cp focus/.git/hooks/pre-commit /path/to/your/repo/.git/hooks/
   chmod +x /path/to/your/repo/.git/hooks/pre-commit
   ```

## Configuration

Edit `xtask/policy.toml` to match your repo structure:

### Example: Different Crate Names

If your state is in `app/src/state.rs` instead of `core/src/state.rs`:

```toml
[allowlists]
ssot_allowed = [
    "app/src/state.rs",
    "xtask/",
    "tests/",
]
```

### Example: Different State Type Names

If you use `AppState` instead of `MachineState`:

```toml
[patterns]
ssot_types = [
    "AppState",
    "GlobalState",
]
```

### Example: Different Concurrency Model

If you use a different async runtime or spawn pattern:

```toml
[patterns]
spawn_patterns = [
    r"async_std::task::spawn",
    r"smol::spawn",
    # Add your patterns here
]
```

## Minimal Example

For a simple single-crate repo:

```toml
[allowlists]
lock_allowed = ["src/transport.rs", "xtask/", "tests/"]
spawn_allowed = ["src/main.rs", "xtask/", "tests/"]
ssot_allowed = ["src/state.rs", "xtask/", "tests/"]

[patterns]
lock_patterns = [
    r"std::sync::Mutex",
    r"tokio::sync::Mutex",
]
spawn_patterns = [
    r"std::thread::spawn",
    r"tokio::spawn",
]
ssot_types = ["AppState"]
```

## Testing

After installation, test it:

```bash
# Should pass (no violations)
cargo run -p xtask

# Should fail (if you have violations)
# Fix violations, then re-run
```

## Requirements

- Rust workspace
- `ripgrep` (rg) - installed automatically in CI, required locally for policy checks
- `cargo` in PATH

## Troubleshooting

### "Failed to load policy config"

Make sure `xtask/policy.toml` exists and is valid TOML.

### Policy check passes but shouldn't

1. Check that `ripgrep` is installed: `which rg`
2. Verify patterns match your code: `rg "std::sync::Mutex" .`
3. Check allowlist paths are correct

### Policy check fails incorrectly

1. Add the path to the appropriate allowlist in `policy.toml`
2. Re-run: `cargo run -p xtask`

## Advanced: Multiple State Types

If you have multiple state owners (not recommended, but supported):

```toml
[patterns]
ssot_types = [
    "MachineState",
    "ConfigState", 
    "SessionState",
]

[allowlists]
ssot_allowed = [
    "core/src/machine_state.rs",
    "config/src/state.rs",
    "session/src/state.rs",
    "xtask/",
    "tests/",
]
```

## Integration with Existing CI

The policy checker is just a Rust binary. It integrates with any CI:

**GitHub Actions:**
```yaml
- run: cargo run -p xtask
```

**GitLab CI:**
```yaml
policy:
  script:
    - cargo run -p xtask
```

**Jenkins:**
```groovy
sh 'cargo run -p xtask'
```

## Benefits

- ✅ Prevents architectural violations before merge
- ✅ Works with any Rust workspace structure
- ✅ Configurable for your specific needs
- ✅ Fast (ripgrep-based, runs in seconds)
- ✅ Deterministic (same results every time)

