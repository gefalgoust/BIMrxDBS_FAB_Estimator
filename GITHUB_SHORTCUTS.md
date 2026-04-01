# GitHub / Git Shortcuts Guide  —  BIMrxDBS FAB Estimator

See this file for command aliases, commit format, and the recommended easy-commit workflow.

## Quick reference

| Shortcut | Expands to | What it does |
|---|---|---|
| `git gs` | `git status --short` | Compact working tree status |
| `git gd` | `git diff` | Show unstaged changes |
| `git gdc` | `git diff --cached` | Show staged changes |
| `git gc` | `git commit` | Start a normal commit |
| `git gca` | `git commit -a` | Commit all tracked modified files |
| `git gp` | `git push` | Push current branch to remote |
| `git lg` | `git log --oneline --graph --decorate --all` | Graph view of commit history |
| `git snap` | `git add -A && git commit` | Stage all changes, then start commit |

---

## Easy commit (recommended)

Double-click **`Commit.bat`** or run from PowerShell:

```powershell
.\Commit.bat
```

It will:
1. Auto-fill today's date
2. Show current version detected from last commit
3. Prompt for new version number (e.g. `1.1.0`)
4. Let you pick a commit type (`feat`, `fix`, `chore`, `refactor`, `docs`)
5. Prompt for a one-line summary
6. Display the final commit message for confirmation
7. Pull, commit, and push automatically

---

## Commit message format

```
YYYYMMDD - vMAJOR.MINOR.PATCH: type: summary
```

**Examples:**
```
20260401 - v1.1.0: feat: add dynamic path resolution to batch launcher
20260401 - v1.0.1: fix: correct template path in BIMrxDBS Shop Order.bat
20260401 - v1.0.0: chore: initial backup and folder cleanup
```

**Types:**
- `feat`     — new feature or enhancement
- `fix`      — bug fix
- `chore`    — maintenance / housekeeping
- `refactor` — restructure without behaviour change
- `docs`     — documentation only

---

## Manual workflow

```powershell
# 1) Check what changed
git gs

# 2) Review diffs
git gd      # unstaged
git gdc     # staged

# 3) Stage all and commit
git snap -m "20260401 - v1.1.0: feat: describe your change"

# 4) Push
git gp
```

Or with standard Git commands (no aliases):

```powershell
git pull --ff-only
git add -A
git commit -m "20260401 - v1.1.0: feat: describe your change"
git push
```

---

## Recreate aliases (run once per machine)

```powershell
git config --global alias.gs "status --short"
git config --global alias.gd "diff"
git config --global alias.gdc "diff --cached"
git config --global alias.gc "commit"
git config --global alias.gca "commit -a"
git config --global alias.gp "push"
git config --global alias.lg "log --oneline --graph --decorate --all"
git config --global alias.snap "!git add -A && git commit"
```

---

## Remote

- **Repository:** https://github.com/gefalgoust/BIMrxDBS_FAB_Estimator
- **Branch:** `master`
