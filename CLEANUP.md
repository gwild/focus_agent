# Cleanup Instructions

## If xtask submodule was partially added

**From your repo directory** (`/Users/gregorywildes/stringdriver`):

```bash
# Remove xtask from git index
git rm --cached xtask

# Remove .git/modules/xtask if it exists
rm -rf .git/modules/xtask

# Remove xtask directory
rm -rf xtask

# Remove from .gitmodules if present
git rm --cached .gitmodules 2>/dev/null || true
rm -f .gitmodules

# Clean up any partial commits
git reset HEAD~1 2>/dev/null || true
```

## Clean One-Liner (After Cleanup)

**From your repo directory:**

```bash
git submodule add git@github.com:gwild/xtask-policy.git xtask && git submodule update --init xtask && (grep -q '"xtask"' Cargo.toml || (echo "" >> Cargo.toml && echo "[workspace]" >> Cargo.toml && echo 'members = ["xtask"]' >> Cargo.toml)) && cargo run -p xtask -- analyze
```

## Complete Cleanup + Add (All-in-One)

```bash
git rm --cached xtask 2>/dev/null; rm -rf xtask .git/modules/xtask; git submodule add git@github.com:gwild/xtask-policy.git xtask && git submodule update --init xtask && (grep -q '"xtask"' Cargo.toml || (echo "" >> Cargo.toml && echo "[workspace]" >> Cargo.toml && echo 'members = ["xtask"]' >> Cargo.toml)) && cargo run -p xtask -- analyze
```

