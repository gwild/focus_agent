# Pushing to Remote for First Time

## Step 1: Create Remote Repository

Create an empty repository on your Git hosting service:

**GitHub:**
1. Go to https://github.com/new
2. Repository name: `focus` (or your choice)
3. Description: "Policy enforcement system for architectural invariants"
4. Choose public/private
5. **Do NOT** initialize with README, .gitignore, or license
6. Click "Create repository"

**GitLab:**
1. Go to your GitLab project page
2. Click "New project" → "Create blank project"
3. Fill in project name
4. **Do NOT** initialize with README
5. Click "Create project"

## Step 2: Add Remote and Push

Once you have the repository URL, run:

```bash
# Add remote (replace with your actual URL)
git remote add origin <your-repo-url>

# Push to remote
git push -u origin master
# or if your default branch is 'main':
git push -u origin master:main
```

## One-Liner (After Creating Remote)

```bash
git remote add origin <your-repo-url> && git push -u origin master
```

## Common URLs

**GitHub SSH:**
```bash
git remote add origin git@github.com:yourusername/focus.git
```

**GitHub HTTPS:**
```bash
git remote add origin https://github.com/yourusername/focus.git
```

**GitLab SSH:**
```bash
git remote add origin git@gitlab.com:yourusername/focus.git
```

## Verify

```bash
# Check remote
git remote -v

# Should show:
# origin  <your-repo-url> (fetch)
# origin  <your-repo-url> (push)
```

## If Branch Name Mismatch

If remote uses `main` but local uses `master`:

```bash
# Option 1: Rename local branch
git branch -M main
git push -u origin main

# Option 2: Push master to main
git push -u origin master:main
```

