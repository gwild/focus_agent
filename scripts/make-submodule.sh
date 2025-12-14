#!/bin/bash
# Script to convert xtask to a git submodule
# Run this when ready to share xtask across repos

set -e

echo "Converting xtask to git submodule..."
echo ""
echo "This script will:"
echo "1. Create a backup of xtask/"
echo "2. Remove xtask from this repo"
echo "3. Guide you through creating the submodule"
echo ""
read -p "Continue? (y/N) " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "Aborted."
    exit 1
fi

# Step 1: Backup
BACKUP_DIR="xtask-backup-$(date +%Y%m%d-%H%M%S)"
echo "Creating backup in $BACKUP_DIR..."
cp -r xtask "$BACKUP_DIR"
echo "✓ Backup created"

# Step 2: Check if we're in a git repo
if ! git rev-parse --git-dir > /dev/null 2>&1; then
    echo "⚠ Not in a git repository. Skipping git operations."
    echo ""
    echo "Next steps:"
    echo "1. Create a new repo for xtask:"
    echo "   git init <path>/xtask-policy"
    echo "   cd <path>/xtask-policy"
    echo "   cp -r $BACKUP_DIR/* ."
    echo "   git add ."
    echo "   git commit -m 'Initial xtask policy enforcement'"
    echo "   git remote add origin <repo-url>"
    echo "   git push -u origin main"
    echo ""
    echo "2. Then in this repo:"
    echo "   git rm -r xtask"
    echo "   git commit -m 'Remove xtask, preparing for submodule'"
    echo "   git submodule add <xtask-repo-url> xtask"
    echo "   git commit -m 'Add xtask as submodule'"
    exit 0
fi

# Step 3: Check if xtask has uncommitted changes
if git status --short xtask/ | grep -q .; then
    echo "⚠ xtask/ has uncommitted changes:"
    git status --short xtask/
    echo ""
    read -p "Commit these changes first? (y/N) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        git add xtask/
        git commit -m "Update xtask before submodule conversion"
    else
        echo "Please commit or stash changes in xtask/ first."
        exit 1
    fi
fi

# Step 4: Instructions
echo ""
echo "Next steps:"
echo ""
echo "1. Create a new repository for xtask (on GitHub/GitLab/etc)"
echo "   Example: https://github.com/yourusername/xtask-policy"
echo ""
echo "2. Push xtask to the new repo:"
echo "   cd xtask"
echo "   git remote add origin <new-repo-url>"
echo "   git push -u origin main"
echo "   cd .."
echo ""
echo "3. Remove xtask from this repo and add as submodule:"
echo "   git rm -r xtask"
echo "   git commit -m 'Remove xtask, preparing for submodule'"
echo "   git submodule add <new-repo-url> xtask"
echo "   git commit -m 'Add xtask as submodule'"
echo ""
echo "4. In other repos, add as submodule:"
echo "   git submodule add <new-repo-url> xtask"
echo "   git submodule update --init --recursive"
echo ""
echo "Backup saved in: $BACKUP_DIR"
echo ""
echo "Run these commands manually, or press Enter to continue with step 3..."
read

# Step 5: Remove and prepare for submodule
echo "Removing xtask from this repo..."
git rm -r xtask
git commit -m "Remove xtask, preparing for submodule" || {
    echo "⚠ No changes to commit (xtask already removed?)"
}

echo ""
echo "✓ xtask removed from this repo"
echo ""
echo "Now add it as a submodule:"
echo "  git submodule add <new-repo-url> xtask"
echo "  git commit -m 'Add xtask as submodule'"

