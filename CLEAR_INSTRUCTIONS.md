# Clear Instructions: Adding xtask to Your Repo

## What This Does

Adds the `xtask` policy enforcement system to your Rust workspace as a git submodule.

## Prerequisites

1. **You must be in your target repo directory** (e.g., `/Users/gregorywildes/stringdriver`)
2. **The `xtask-policy` GitHub repo must exist** at `git@github.com:gwild/xtask-policy.git`
3. **Your repo must be a git repository** (already initialized)

## Step-by-Step

### Step 1: Create xtask-policy repo on GitHub

1. Go to https://github.com/new
2. Repository name: `xtask-policy`
3. **DO NOT** initialize with README, .gitignore, or license
4. Click "Create repository"
5. Copy the SSH URL: `git@github.com:gwild/xtask-policy.git`

### Step 2: Create and push xtask-policy repo (one-time setup)

Run this **from anywhere** (creates the xtask-policy repo):

```bash
cd /tmp && \
rm -rf focus-temp xtask-policy && \
git clone --depth 1 git@github.com:gwild/focus_agent.git focus-temp && \
mkdir -p xtask-policy && \
cd xtask-policy && \
git init && \
cp -r ../focus-temp/xtask/* . && \
git add . && \
git commit -m "Initial xtask policy enforcement" && \
git remote add origin git@github.com:gwild/xtask-policy.git && \
git push -u origin master && \
cd /tmp && \
rm -rf focus-temp
```

**Expected output**: Should push successfully to GitHub.

### Step 3: Add to your repo (run from YOUR repo directory)

**IMPORTANT**: Run this **from inside your target repo** (e.g., `stringdriver`):

```bash
cd /Users/gregorywildes/stringdriver && \
git submodule add git@github.com:gwild/xtask-policy.git xtask && \
git submodule update --init --recursive && \
(grep -q '"xtask"' Cargo.toml || (echo "" >> Cargo.toml && echo "[workspace]" >> Cargo.toml && echo 'members = ["xtask"]' >> Cargo.toml)) && \
cargo run -p xtask -- analyze
```

**What each part does:**
- `cd /Users/gregorywildes/stringdriver` - Go to YOUR repo
- `git submodule add ...` - Add xtask as submodule
- `git submodule update --init --recursive` - Initialize submodule
- `(grep -q ...)` - Add xtask to workspace Cargo.toml if not present
- `cargo run -p xtask -- analyze` - Run analysis

## Troubleshooting

### "Repository not found"
- The `xtask-policy` repo doesn't exist on GitHub yet
- Create it first (Step 1)

### "destination path 'xtask' already exists"
- You already have an `xtask` directory
- Remove it first: `rm -rf xtask`

### Stuck cloning submodules
- Your repo might have other submodules that are slow to clone
- The `--recursive` flag clones all submodules
- You can skip: `git submodule update --init` (without `--recursive`)

### Wrong directory
- Make sure you're in YOUR repo directory, not `/tmp` or focus repo
- Check: `pwd` should show your repo path

## Verification

After running, you should have:
- `xtask/` directory in your repo
- `.gitmodules` file updated
- `Cargo.toml` with `xtask` in workspace members
- `cleanup-plan.md` generated

## One-Liner (After xtask-policy repo exists)

**From your repo directory:**

```bash
git submodule add git@github.com:gwild/xtask-policy.git xtask && git submodule update --init && (grep -q '"xtask"' Cargo.toml || (echo "" >> Cargo.toml && echo "[workspace]" >> Cargo.toml && echo 'members = ["xtask"]' >> Cargo.toml)) && cargo run -p xtask -- analyze
```

**Note**: Removed `--recursive` to avoid cloning other submodules.

