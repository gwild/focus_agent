#!/bin/bash
# One-liner deployment script for policy enforcement
# Usage: ./deploy.sh /path/to/target/repo

set -e

TARGET_REPO="${1:-.}"
FOCUS_REPO="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

if [ ! -d "$TARGET_REPO" ]; then
    echo "Error: Target repo '$TARGET_REPO' does not exist"
    exit 1
fi

echo "Deploying policy enforcement to: $TARGET_REPO"

# Copy xtask
cp -r "$FOCUS_REPO/xtask" "$TARGET_REPO/"

# Add to workspace Cargo.toml if it exists
if [ -f "$TARGET_REPO/Cargo.toml" ]; then
    if ! grep -q '"xtask"' "$TARGET_REPO/Cargo.toml"; then
        # Add xtask to workspace members
        if grep -q '\[workspace\]' "$TARGET_REPO/Cargo.toml"; then
            # Workspace exists, add member
            sed -i.bak '/\[workspace\]/,/members = \[/ {
                /members = \[/ a\
    "xtask",
            }' "$TARGET_REPO/Cargo.toml"
            rm -f "$TARGET_REPO/Cargo.toml.bak"
        else
            # No workspace, create one
            echo "" >> "$TARGET_REPO/Cargo.toml"
            echo "[workspace]" >> "$TARGET_REPO/Cargo.toml"
            echo 'members = ["xtask"]' >> "$TARGET_REPO/Cargo.toml"
        fi
        echo "✅ Added xtask to workspace"
    else
        echo "ℹ️  xtask already in workspace"
    fi
else
    echo "⚠️  No Cargo.toml found - you'll need to add xtask to workspace manually"
fi

echo ""
echo "✅ Deployment complete!"
echo ""
echo "Next steps:"
echo "1. Customize $TARGET_REPO/xtask/policy.toml for your repo structure"
echo "2. Run: cd $TARGET_REPO && cargo run -p xtask -- analyze"
echo "3. Review cleanup-plan.md and fix violations"
echo "4. Add to CI: cargo run -p xtask"

