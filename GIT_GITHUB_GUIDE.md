# Git & GitHub — Complete Guide (Start to End)
> Works for any project — keep this as your reference.

---

## One-Time Setup (Do this once on your PC)

### 1. Install Git
- Download from **https://git-scm.com**
- Install with all default options

### 2. Set Your Identity
Open PowerShell and run:
```powershell
git config --global user.name "Your Name"
git config --global user.email "your@email.com"
```

### 3. Create a GitHub Account
- Go to **https://github.com**
- Sign up and verify your email

---

## Starting a New Project (Do this once per project)

### 4. Create Your Project Folder
```powershell
mkdir my-project
cd my-project
```

### 5. Initialize Git
```powershell
git init
```
> Creates a hidden `.git` folder. Git now watches this folder for changes.

### 6. Create a `.gitignore` File
In VS Code, create a file named `.gitignore` and add files you don't want Git to track:
```
*.log
*.env
node_modules/
Thumbs.db
.DS_Store
```

### 7. Stage All Your Files
```powershell
git add .
```
> The `.` means "add everything in this folder".

### 8. Create Your First Commit
```powershell
git commit -m "Initial commit"
```
> This saves a permanent snapshot of your project.

### 9. Create a Repo on GitHub
1. Go to **https://github.com**
2. Click **+** (top right) → **New repository**
3. Give it a name (same as your folder)
4. **Do NOT** check "Initialize with README"
5. Click **Create repository**
6. Copy the URL shown (e.g. `https://github.com/username/my-project.git`)

### 10. Connect Local Folder to GitHub
```powershell
git remote add origin https://github.com/USERNAME/my-project.git
git branch -M main
git push -u origin main
```
> Your code is now live on GitHub.

---

## Daily Workflow (Every Time You Make Changes)

```powershell
# Step 1 — Check what changed
git status

# Step 2 — Stage your changes
git add .

# Step 3 — Save a snapshot with a message
git commit -m "describe what you changed"

# Step 4 — Upload to GitHub
git push
```

> Repeat these 4 commands every time you finish working.

---

## Useful Commands Reference

| Command | What It Does |
|---|---|
| `git status` | Shows what files changed |
| `git log --oneline` | Shows all past commits (history) |
| `git diff` | Shows exact line changes before staging |
| `git add filename.txt` | Stage one specific file |
| `git add .` | Stage all changed files |
| `git commit -m "msg"` | Save a snapshot with a label |
| `git push` | Upload commits to GitHub |
| `git pull` | Download latest changes from GitHub |
| `git clone URL` | Copy a GitHub repo to your PC |

---

## Branching — Try New Things Safely

Use branches when you want to experiment without breaking your main code.

```powershell
# Create a new branch
git checkout -b feature-name

# Make changes, then stage and commit
git add .
git commit -m "trying new feature"

# Push the branch to GitHub
git push origin feature-name

# Switch back to main branch
git checkout main

# Merge the branch into main when ready
git merge feature-name

# Delete the branch after merging
git branch -d feature-name
```

---

## If Something Goes Wrong

```powershell
# Undo last commit but keep your file changes
git reset --soft HEAD~1

# Discard all unsaved changes (careful — this is permanent)
git checkout .

# See full commit history
git log --oneline

# Go back to a specific commit
git checkout COMMIT_ID
```

---

## Cloning an Existing Project

If you want to download a project from GitHub to your PC:

```powershell
git clone https://github.com/USERNAME/project-name.git
cd project-name
```

---

## How It All Works — Big Picture

```
Your PC (Local)               GitHub (Online)
───────────────               ───────────────
git init                      (empty repo)
git add .
git commit -m "..."
git push          ──────►     files uploaded
                  ◄──────     git pull (get updates)
git clone URL     ◄──────     download to new machine
```

---

## The 3 Commands to Always Remember

| # | Command | Purpose |
|---|---|---|
| 1 | `git add .` | Select what to save |
| 2 | `git commit -m "message"` | Save a labeled snapshot |
| 3 | `git push` | Upload to GitHub |

---

## Authentication — GitHub Token Setup

If GitHub asks for a password and rejects it, use a Personal Access Token:

1. Go to **github.com** → Profile → **Settings**
2. Scroll to **Developer settings** → **Personal access tokens** → **Tokens (classic)**
3. Click **Generate new token (classic)**
4. Check ✅ **repo** → Generate → Copy the token
5. Use it in your remote URL:

```powershell
git remote set-url origin https://YOUR_TOKEN@github.com/USERNAME/repo.git
git push origin main
```

---

## Quick Cheat Sheet

```
NEW PROJECT
  git init
  git add .
  git commit -m "Initial commit"
  git remote add origin URL
  git push -u origin main

DAILY WORK
  git status
  git add .
  git commit -m "what changed"
  git push

BRANCHING
  git checkout -b branch-name
  git checkout main
  git merge branch-name
```

---

*Document created for Oracle APEX 26.1 Project Tracker — applicable to any project.*
