# Adding xtask as a Git Submodule

## Prerequisites

First, create a separate repository for `xtask`:

```bash
# From focus repo
cd /tmp
git clone <focus-repo-url> xtask-temp
cd xtask-temp
git subtree push --prefix=xtask origin xtask-standalone

# Or create fresh repo:
mkdir xtask-policy && cd xtask-policy
git init
cp -r <path-to-focus>/xtask/* .
git add .
git commit -m "Initial xtask policy enforcement"
git remote add origin <your-xtask-repo-url>
git push -u origin main
```

## One-Liner (From Target Repo)

```bash
git submodule add <xtask-repo-url> xtask && git submodule update --init --recursive && (grep -q '"xtask"' Cargo.toml || (echo "" >> Cargo.toml && echo "[workspace]" >> Cargo.toml && echo 'members = ["xtask"]' >> Cargo.toml)) && cargo run -p xtask -- analyze
```

Or use the script:

```bash
# Copy script to target repo first, or run directly:
/path/to/focus/scripts/add-submodule.sh <xtask-repo-url>
```

## Step-by-Step

```bash
# 1. Add submodule
git submodule add <xtask-repo-url> xtask

# 2. Initialize
git submodule update --init --recursive

# 3. Add to workspace (edit Cargo.toml manually or use script)
# Add "xtask" to [workspace] members

# 4. Customize policy
# Edit xtask/policy.toml

# 5. Analyze
cargo run -p xtask -- analyze

# 6. Commit
git add . && git commit -m "Add xtask policy enforcement submodule"
```

## Updating Submodule

```bash
# Update to latest
cd xtask
git pull origin main
cd ..
git add xtask
git commit -m "Update xtask submodule"
```

## Cloning Repo with Submodule

```bash
# Clone repo
git clone <repo-url>

# Initialize submodules
git submodule update --init --recursive
```

