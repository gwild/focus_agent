# Sharing Policy Enforcement Across Repos

There are several ways to share the `xtask` policy enforcement system across multiple repositories:

## Option 1: Copy (Current Approach)

**Pros:**
- Simple, no git complexity
- Each repo can customize independently
- No dependency on external repos

**Cons:**
- Updates must be copied manually
- No automatic sync

**Usage:**
```bash
cp -r focus/xtask /path/to/other/repo/
```

## Option 2: Git Submodule

Share `xtask` as a submodule so multiple repos can reference the same source.

### Setup

1. **Create a separate repo for xtask** (if not already):
   ```bash
   cd /tmp
   git clone <focus-repo-url> focus-xtask
   cd focus-xtask
   git subtree push --prefix=xtask origin xtask-standalone
   # Or create a new repo just for xtask
   ```

2. **Add as submodule in other repos**:
   ```bash
   cd /path/to/other/repo
   git submodule add <xtask-repo-url> xtask
   ```

3. **Initialize in cloned repos**:
   ```bash
   git submodule update --init --recursive
   ```

**Pros:**
- Single source of truth
- Easy to update: `git submodule update --remote`
- Version controlled

**Cons:**
- Git submodule complexity
- Must remember to update submodules
- Each repo still needs its own `policy.toml`

## Option 3: Published Crate

Publish `xtask` as a crate on crates.io or private registry.

### Setup

1. **Make xtask a standalone crate** with config file support
2. **Publish to crates.io** (or private registry)
3. **Add to other repos**:
   ```toml
   [dependencies]
   focus-xtask = "0.1.0"
   ```

**Pros:**
- Versioned releases
- Easy to use: just add dependency
- Automatic updates via `cargo update`

**Cons:**
- Requires publishing/maintenance
- Less flexible (config file location might differ)
- Versioning complexity

## Option 4: Git Subtree

Merge `xtask` into other repos as a subtree.

### Setup

```bash
cd /path/to/other/repo
git subtree add --prefix=xtask <focus-repo-url> main --squash
```

**Pros:**
- No submodule complexity
- History preserved
- Can push changes back

**Cons:**
- More complex than copy
- Merge conflicts possible
- Updates require subtree pull

## Recommendation

**For most cases: Use Option 1 (Copy)**

Reasons:
- Policy enforcement is repo-specific
- Each repo needs its own `policy.toml` anyway
- Simplicity wins
- Easy to customize per repo

**For many repos with same structure: Use Option 2 (Submodule)**

If you have 10+ repos with identical structure:
- Create `xtask-policy` repo
- Add as submodule
- Share common patterns, customize `policy.toml` per repo

**For public distribution: Use Option 3 (Published Crate)**

If you want to share with the community:
- Publish as `cargo-xtask-policy` or similar
- Others can `cargo install` or add as dependency

## Current Status

The `xtask` crate in this repo is **not** a submodule - it's a regular workspace member. To share it:

1. **Copy approach** (simplest): Just copy the `xtask/` directory
2. **Submodule approach**: Extract to separate repo, add as submodule
3. **Crate approach**: Refactor to be installable, publish

## Making xtask a Submodule (If You Want)

If you want to convert this to use a submodule:

```bash
# 1. Create separate repo for xtask
cd /tmp
git clone <this-repo-url> xtask-repo
cd xtask-repo
git filter-branch --subdirectory-filter xtask -- --all
# Push to new repo

# 2. Remove xtask from this repo
cd /path/to/focus
git rm -r xtask
git commit -m "Remove xtask, will add as submodule"

# 3. Add as submodule
git submodule add <xtask-repo-url> xtask
git commit -m "Add xtask as submodule"
```

But honestly, **copying is simpler** unless you have many repos to maintain.

