# One-Liner: Add xtask as Submodule

## Option 1: If xtask repo already exists

```bash
git submodule add git@github.com:gwild/xtask-policy.git xtask && git submodule update --init --recursive && (grep -q '"xtask"' Cargo.toml || (echo "" >> Cargo.toml && echo "[workspace]" >> Cargo.toml && echo 'members = ["xtask"]' >> Cargo.toml)) && cargo run -p xtask -- analyze
```

## Option 2: Create xtask repo first, then add as submodule

```bash
cd /tmp && git clone --depth 1 git@github.com:gwild/focus_agent.git focus-temp && cd focus-temp && git subtree push --prefix=xtask origin xtask-standalone 2>/dev/null || (cd .. && mkdir -p xtask-policy && cd xtask-policy && git init && cp -r ../focus-temp/xtask/* . && git add . && git commit -m "Initial xtask" && git remote add origin git@github.com:gwild/xtask-policy.git && git push -u origin main) && cd - && git submodule add git@github.com:gwild/xtask-policy.git xtask && git submodule update --init --recursive && (grep -q '"xtask"' Cargo.toml || (echo "" >> Cargo.toml && echo "[workspace]" >> Cargo.toml && echo 'members = ["xtask"]' >> Cargo.toml)) && cargo run -p xtask -- analyze
```

## Option 3: Use focus repo directly (brings everything, not recommended)

```bash
git submodule add git@github.com:gwild/focus_agent.git focus-temp && git submodule update --init --recursive && cp -r focus-temp/xtask . && rm -rf focus-temp .git/modules/focus-temp && git rm --cached focus-temp 2>/dev/null; git submodule add git@github.com:gwild/focus_agent.git xtask --depth 1 && git submodule update --init --recursive && (grep -q '"xtask"' Cargo.toml || (echo "" >> Cargo.toml && echo "[workspace]" >> Cargo.toml && echo 'members = ["xtask"]' >> Cargo.toml)) && cargo run -p xtask -- analyze
```

## Recommended: Two-Step Process

**Step 1: Create xtask repo (one-time, from focus repo):**
```bash
cd /tmp && git clone git@github.com:gwild/focus_agent.git focus-temp && cd focus-temp && git subtree push --prefix=xtask origin xtask-standalone || (cd .. && mkdir xtask-policy && cd xtask-policy && git init && cp -r ../focus-temp/xtask/* . && git add . && git commit -m "Initial" && git remote add origin git@github.com:gwild/xtask-policy.git && git push -u origin main)
```

**Step 2: Add to your repo (one-liner):**
```bash
git submodule add git@github.com:gwild/xtask-policy.git xtask && git submodule update --init --recursive && (grep -q '"xtask"' Cargo.toml || (echo "" >> Cargo.toml && echo "[workspace]" >> Cargo.toml && echo 'members = ["xtask"]' >> Cargo.toml)) && cargo run -p xtask -- analyze
```

