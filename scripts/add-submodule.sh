#!/bin/bin/bash
# One-liner to add xtask as submodule from another repo
# Usage: Run from inside target repo: ./add-submodule.sh <xtask-repo-url>

set -e

XTASK_REPO_URL="${1:-git@github.com:yourusername/xtask-policy.git}"

if [ -d "xtask" ]; then
    echo "Error: xtask directory already exists"
    exit 1
fi

echo "Adding xtask as submodule from: $XTASK_REPO_URL"

# Add as submodule
git submodule add "$XTASK_REPO_URL" xtask

# Initialize
git submodule update --init --recursive

# Add to workspace Cargo.toml
if [ -f "Cargo.toml" ]; then
    if ! grep -q '"xtask"' Cargo.toml; then
        if grep -q '\[workspace\]' Cargo.toml; then
            # Add to existing workspace
            sed -i.bak '/\[workspace\]/,/members = \[/ {
                /members = \[/ a\
    "xtask",
            }' Cargo.toml
            rm -f Cargo.toml.bak
        else
            # Create workspace
            echo "" >> Cargo.toml
            echo "[workspace]" >> Cargo.toml
            echo 'members = ["xtask"]' >> Cargo.toml
        fi
        echo "✅ Added xtask to workspace"
    fi
fi

echo ""
echo "✅ Submodule added!"
echo ""
echo "Next steps:"
echo "1. Customize xtask/policy.toml for your repo structure"
echo "2. Run: cargo run -p xtask -- analyze"
echo "3. Commit: git add . && git commit -m 'Add xtask policy enforcement submodule'"

