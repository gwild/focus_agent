# Final One-Liner Using focus_agent

## Option 1: Use focus_agent repo directly (copy xtask out)

```bash
git submodule add git@github.com:gwild/focus_agent.git focus-temp && git submodule update --init --recursive && cp -r focus-temp/xtask . && rm -rf focus-temp .git/modules/focus-temp && git rm --cached focus-temp 2>/dev/null; (grep -q '"xtask"' Cargo.toml || (echo "" >> Cargo.toml && echo "[workspace]" >> Cargo.toml && echo 'members = ["xtask"]' >> Cargo.toml)) && cargo run -p xtask -- analyze
```

## Option 2: Clone, extract, create separate repo, then submodule

```bash
cd /tmp && git clone --depth 1 git@github.com:gwild/focus_agent.git focus-temp && mkdir -p xtask-policy && cd xtask-policy && git init && cp -r ../focus-temp/xtask/* . && git add . && git commit -m "Initial" && git remote add origin git@github.com:gwild/xtask-policy.git && git push -u origin master && cd - && git submodule add git@github.com:gwild/xtask-policy.git xtask && git submodule update --init --recursive && (grep -q '"xtask"' Cargo.toml || (echo "" >> Cargo.toml && echo "[workspace]" >> Cargo.toml && echo 'members = ["xtask"]' >> Cargo.toml)) && cargo run -p xtask -- analyze
```

## Simplest: Just copy (no submodule)

```bash
cd /tmp && git clone --depth 1 git@github.com:gwild/focus_agent.git focus-temp && cd - && cp -r /tmp/focus-temp/xtask . && rm -rf /tmp/focus-temp && (grep -q '"xtask"' Cargo.toml || (echo "" >> Cargo.toml && echo "[workspace]" >> Cargo.toml && echo 'members = ["xtask"]' >> Cargo.toml)) && cargo run -p xtask -- analyze
```

