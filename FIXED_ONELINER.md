# Fixed One-Liner (Uses master branch)

## Corrected Version

```bash
cd /tmp && git clone --depth 1 git@github.com:gwild/focus_agent.git focus-temp && mkdir -p xtask-policy && cd xtask-policy && git init && cp -r ../focus-temp/xtask/* . && git add . && git commit -m "Initial" && git remote add origin git@github.com:gwild/xtask-policy.git && git push -u origin master && cd - && git submodule add git@github.com:gwild/xtask-policy.git xtask && git submodule update --init --recursive && (grep -q '"xtask"' Cargo.toml || (echo "" >> Cargo.toml && echo "[workspace]" >> Cargo.toml && echo 'members = ["xtask"]' >> Cargo.toml)) && cargo run -p xtask -- analyze
```

**Change**: `main` → `master`

## If Remote Repo Doesn't Exist Yet

**First create the repo on GitHub**, then run:

```bash
cd /tmp && git clone --depth 1 git@github.com:gwild/focus_agent.git focus-temp && mkdir -p xtask-policy && cd xtask-policy && git init && cp -r ../focus-temp/xtask/* . && git add . && git commit -m "Initial" && git remote add origin git@github.com:gwild/xtask-policy.git && git push -u origin master && cd - && git submodule add git@github.com:gwild/xtask-policy.git xtask && git submodule update --init --recursive && (grep -q '"xtask"' Cargo.toml || (echo "" >> Cargo.toml && echo "[workspace]" >> Cargo.toml && echo 'members = ["xtask"]' >> Cargo.toml)) && cargo run -p xtask -- analyze
```

## For Your Current Situation

Since you're already in `/tmp/xtask-policy` with the repo initialized:

```bash
git push -u origin master
```

Then continue with adding to your repo:

```bash
cd /path/to/your/repo && git submodule add git@github.com:gwild/xtask-policy.git xtask && git submodule update --init --recursive && (grep -q '"xtask"' Cargo.toml || (echo "" >> Cargo.toml && echo "[workspace]" >> Cargo.toml && echo 'members = ["xtask"]' >> Cargo.toml)) && cargo run -p xtask -- analyze
```

