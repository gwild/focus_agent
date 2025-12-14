# One-Liner to Add xtask to Your Repo

## Option 1: As Submodule (Recommended)

**First, create separate xtask repo:**
```bash
# From focus repo, extract xtask to new repo:
cd /tmp && git clone git@github.com:gwild/focus_agent.git xtask-temp && \
cd xtask-temp && git subtree push --prefix=xtask origin xtask-standalone || \
(echo "Creating new repo..." && mkdir -p ../xtask-policy && cd ../xtask-policy && \
git init && cp -r ../xtask-temp/xtask/* . && git add . && \
git commit -m "Initial xtask" && git remote add origin git@github.com:gwild/xtask-policy.git && \
git push -u origin main)
```

**Then in your repo:**
```bash
git submodule add git@github.com:gwild/xtask-policy.git xtask && git submodule update --init --recursive && (grep -q '"xtask"' Cargo.toml || (echo "" >> Cargo.toml && echo "[workspace]" >> Cargo.toml && echo 'members = ["xtask"]' >> Cargo.toml)) && cargo run -p xtask -- analyze
```

## Option 2: Copy Method (Simpler, No Submodule)

```bash
git clone git@github.com:gwild/focus_agent.git /tmp/focus-temp && cp -r /tmp/focus-temp/xtask . && rm -rf /tmp/focus-temp && (grep -q '"xtask"' Cargo.toml || (echo "" >> Cargo.toml && echo "[workspace]" >> Cargo.toml && echo 'members = ["xtask"]' >> Cargo.toml)) && cargo run -p xtask -- analyze
```

## Option 3: Direct Clone + Copy (Cleanest)

```bash
cd /tmp && git clone --depth 1 git@github.com:gwild/focus_agent.git focus-temp && cd - && cp -r /tmp/focus-temp/xtask . && rm -rf /tmp/focus-temp && (grep -q '"xtask"' Cargo.toml || (echo "" >> Cargo.toml && echo "[workspace]" >> Cargo.toml && echo 'members = ["xtask"]' >> Cargo.toml)) && cargo run -p xtask -- analyze
```

## Simplest (if you're in your repo directory):

```bash
cp -r <path-to-focus>/xtask . && (grep -q '"xtask"' Cargo.toml || (echo "" >> Cargo.toml && echo "[workspace]" >> Cargo.toml && echo 'members = ["xtask"]' >> Cargo.toml)) && cargo run -p xtask -- analyze
```

