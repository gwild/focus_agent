# Deployment Checklist

Ready to deploy policy enforcement to an existing repo? Follow this checklist.

## ✅ Prerequisites

- [ ] Rust workspace (Cargo.toml with `[workspace]`)
- [ ] Git repository
- [ ] `ripgrep` installed (or will be installed in CI)

## 📦 Installation Steps

### 1. Copy xtask to Target Repo

```bash
cp -r focus/xtask /path/to/target/repo/
```

### 2. Add to Workspace

Edit `Cargo.toml` in target repo:

```toml
[workspace]
members = ["xtask", "your_existing_crates"]
```

### 3. Customize `xtask/policy.toml`

**CRITICAL**: Update allowlists to match your repo structure:

```toml
[allowlists]
# Update these paths to match YOUR repo:
lock_allowed = [
    "src/transport.rs",    # Where locks are allowed
    "src/drivers.rs",
    "xtask/",
    "tests/",
]

spawn_allowed = [
    "src/scheduler.rs",     # Where spawning is allowed
    "src/main.rs",
    "xtask/",
    "tests/",
]

ssot_allowed = [
    "src/state.rs",         # Where your state type lives
    "src/machine_state.rs",
    "xtask/",
    "tests/",
]

[patterns]
# Update state type names if different:
ssot_types = [
    "MachineState",         # Your state type name(s)
    # Add others if you have multiple
]
```

### 4. Generate Cleanup Plan (Recommended for Existing Repos)

For existing repos with violations, generate a cleanup plan:

```bash
cd /path/to/target/repo
cargo run -p xtask -- analyze
```

This creates `cleanup-plan.md` with:
- Summary of violations
- Prioritized recommendations
- Detailed violation list
- Next steps

**Example output:**
```bash
$ cargo run -p xtask -- analyze
Analyzing repository...
✅ Cleanup plan written to: cleanup-plan.md

Summary:
  Total violations: 15
  Files affected: 8

⚠️  Review cleanup-plan.md for detailed recommendations
```

### 5. Test Locally

```bash
cd /path/to/target/repo
cargo check -p xtask
cargo run -p xtask  # Quick check
cargo run -p xtask -- analyze  # Detailed plan
```

**Expected**: Should pass if no violations, or show violations to fix.

### 6. Add to CI

#### GitHub Actions

Add to `.github/workflows/ci.yml`:

```yaml
- name: Install ripgrep
  run: sudo apt-get update && sudo apt-get install -y ripgrep

- name: Policy gate
  run: cargo run -p xtask
```

#### GitLab CI

Add to `.gitlab-ci.yml`:

```yaml
policy:
  script:
    - apt-get update && apt-get install -y ripgrep
    - cargo run -p xtask
```

#### Other CI

Just run: `cargo run -p xtask` (ensure ripgrep is installed)

### 7. Optional: Pre-commit Hook

```bash
cp focus/.git/hooks/pre-commit /path/to/target/repo/.git/hooks/
chmod +x /path/to/target/repo/.git/hooks/pre-commit
```

**Note**: Edit the hook if your repo structure differs.

### 8. Fix Existing Violations

If policy check fails, you have violations. Options:

**Option A: Fix violations**
- Move locks to allowed paths
- Move spawning to allowed paths
- Remove SSOT type references from disallowed paths

**Option B: Temporarily adjust allowlists**
- Add paths to allowlists in `policy.toml`
- Commit the adjustment
- Document why in ADR or commit message

**Option C: Gradual rollout**
- Start with lenient allowlists
- Tighten over time as code is refactored

## 🔍 Common Issues

### Issue: "Failed to load policy config"

**Fix**: Ensure `xtask/policy.toml` exists and is valid TOML.

### Issue: Policy fails on existing code

**Fix**: 
1. Review violations
2. Decide: fix code or adjust allowlists
3. Document decision

### Issue: CI fails but local passes

**Fix**: 
- Check ripgrep is installed in CI
- Verify `policy.toml` is committed
- Check workspace includes `xtask`

### Issue: Wrong paths detected

**Fix**: Update `policy.toml` allowlists to match your structure.

## 📋 Pre-Deployment Checklist

Before deploying, verify:

- [ ] `xtask/policy.toml` customized for target repo
- [ ] `xtask` added to workspace `Cargo.toml`
- [ ] `cargo check -p xtask` passes
- [ ] `cargo run -p xtask` runs (may show violations)
- [ ] CI updated to run policy check
- [ ] Existing violations addressed (fix or allowlist)
- [ ] Team notified of new enforcement

## 🚀 Post-Deployment

After deployment:

1. **Monitor CI**: Ensure policy checks pass
2. **Document**: Update repo README with policy info
3. **Train**: Ensure team knows about enforcement
4. **Iterate**: Adjust `policy.toml` as needed

## ⚠️ Important Notes

1. **Each repo needs its own `policy.toml`** - don't share this file
2. **Allowlists are repo-specific** - customize for each repo
3. **Start lenient, tighten later** - easier adoption
4. **Document exceptions** - if you allowlist something, explain why

## 🎯 Quick Start for Common Structures

### Single Crate Repo

```toml
[allowlists]
lock_allowed = ["src/transport.rs", "xtask/", "tests/"]
spawn_allowed = ["src/main.rs", "xtask/", "tests/"]
ssot_allowed = ["src/state.rs", "xtask/", "tests/"]
```

### Multi-Crate Workspace (like focus)

```toml
[allowlists]
lock_allowed = ["runtime/", "drivers/", "xtask/", "tests/"]
spawn_allowed = ["runtime/scheduler.rs", "runtime/main.rs", "xtask/", "tests/"]
ssot_allowed = ["core/src/state.rs", "xtask/", "tests/"]
```

### Microservices Repo

```toml
[allowlists]
lock_allowed = ["services/*/transport.rs", "xtask/", "tests/"]
spawn_allowed = ["services/*/main.rs", "xtask/", "tests/"]
ssot_allowed = ["shared/state.rs", "xtask/", "tests/"]
```

## ✅ Ready to Deploy?

If you've completed the checklist above, **yes, it's ready!**

The system is:
- ✅ Functional and tested
- ✅ Configurable via `policy.toml`
- ✅ CI-ready
- ✅ Well-documented

Just customize `policy.toml` for your repo structure and you're good to go.

