# Final Clean One-Liner

## The Issue

Your `stringdriver` repo has a dependency on `audmon` submodule that needs to be initialized first, or the cargo command will fail.

## Solution: Initialize Required Submodules First

**From `/Users/gregorywildes/stringdriver`:**

```bash
git rm --cached xtask 2>/dev/null; rm -rf xtask .git/modules/xtask; git submodule add git@github.com:gwild/xtask-policy.git xtask && git submodule update --init xtask audmon && (grep -q '"xtask"' Cargo.toml || (echo "" >> Cargo.toml && echo "[workspace]" >> Cargo.toml && echo 'members = ["xtask"]' >> Cargo.toml)) && cargo run -p xtask -- analyze
```

**Change**: Added `audmon` to `--init` so both submodules are initialized.

## Or: Skip Cargo Check If Audmon Not Ready

```bash
git rm --cached xtask 2>/dev/null; rm -rf xtask .git/modules/xtask; git submodule add git@github.com:gwild/xtask-policy.git xtask && git submodule update --init xtask && (grep -q '"xtask"' Cargo.toml || (echo "" >> Cargo.toml && echo "[workspace]" >> Cargo.toml && echo 'members = ["xtask"]' >> Cargo.toml)) && echo "✅ xtask added. Initialize audmon submodule, then run: cargo run -p xtask -- analyze"
```

## Step-by-Step (Safest)

```bash
# 1. Clean up
git rm --cached xtask 2>/dev/null
rm -rf xtask .git/modules/xtask

# 2. Add xtask submodule
git submodule add git@github.com:gwild/xtask-policy.git xtask

# 3. Initialize xtask (and audmon if needed)
git submodule update --init xtask audmon

# 4. Add to workspace
grep -q '"xtask"' Cargo.toml || (echo "" >> Cargo.toml && echo "[workspace]" >> Cargo.toml && echo 'members = ["xtask"]' >> Cargo.toml)

# 5. Run analysis
cargo run -p xtask -- analyze
```

