---
name: codex-skills-github-sync
description: Sync, back up, install, or push Codex skills to a GitHub repository. Use when Codex needs to mirror `~/.codex/skills` into a git repo, commit or push new skills, install mirrored skills onto another machine, or maintain automatic GitHub sync for Codex skills. Also use when the user asks in Chinese to "同步 skill", "备份 skills", "推送 skill 到 GitHub", "把 Codex skill 上传到仓库", or "在别的电脑同步这些 skill".
---

# Codex Skills GitHub Sync

Use this skill when the task is about backing up local Codex skills into the dedicated repository at `D:\github\CodexSkill-myGitHub\codexSKill`.

## Repo Paths

- repo root: `D:\github\CodexSkill-myGitHub\codexSKill`
- sync script: `D:\github\CodexSkill-myGitHub\codexSKill\scripts\sync-codex-skills.ps1`
- watcher script: `D:\github\CodexSkill-myGitHub\codexSKill\scripts\watch-codex-skills.ps1`
- install script: `D:\github\CodexSkill-myGitHub\codexSKill\scripts\install-skills.ps1`

## Standard Actions

### Push current local skills

Run:

```powershell
powershell -ExecutionPolicy Bypass -File D:\github\CodexSkill-myGitHub\codexSKill\scripts\sync-codex-skills.ps1 -Push
```

### Install mirrored skills onto another machine

After cloning the repo on the target machine, run:

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\install-skills.ps1
```

### Keep future changes synced automatically

- Ensure the watcher task `CodexSkillAutoSync` exists and points at `scripts/watch-codex-skills.ps1`.
- If the task is missing or stale, recreate it instead of editing files manually.

## Working Rules

- Treat `C:\Users\admin\.codex\skills` as the source of truth on this machine.
- Mirror all skill directories, including `.system/`, into the repo `skills/` directory.
- Use repository scripts rather than ad hoc copy commands when the task is about syncing or backing up.
- When troubleshooting sync, inspect `git status`, `git remote -v`, and the scheduled task definition before changing scripts.
