---
name: codex-skills-github-sync
description: Sync, back up, install, or push Codex skills to a GitHub-backed local repository. Use when Codex needs to mirror `~/.codex/skills` into a git repo, commit new skills locally, install mirrored skills onto another machine, or maintain automatic local sync for Codex skills before a manual push. Also use when the user asks in Chinese to "同步 skill", "备份 skills", "推送 skill 到 GitHub", "把 Codex skill 上传到仓库", or "在别的电脑同步这些 skill".
---

# Codex Skills GitHub Sync

Use this skill when the task is about backing up local Codex skills into the dedicated repository at `D:\github\CodexSkill-myGitHub\codexSKill`.

## Repo Paths

- repo root: `D:\github\CodexSkill-myGitHub\codexSKill`
- sync script: `D:\github\CodexSkill-myGitHub\codexSKill\scripts\sync-codex-skills.ps1`
- watcher script: `D:\github\CodexSkill-myGitHub\codexSKill\scripts\watch-codex-skills.ps1`
- install script: `D:\github\CodexSkill-myGitHub\codexSKill\scripts\install-skills.ps1`

## Standard Actions

### Sync current local skills into the local repository

Run:

```powershell
powershell -ExecutionPolicy Bypass -File D:\github\CodexSkill-myGitHub\codexSKill\scripts\sync-codex-skills.ps1
```

### Push to GitHub manually when needed

Run from the repo root:

```powershell
git push
```

### Install mirrored skills onto another machine

After cloning the repo on the target machine, run:

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\install-skills.ps1
```

### Keep future changes synced automatically

- Ensure the Startup shortcut `CodexSkillAutoSync.cmd` exists and points at `scripts/watch-codex-skills.ps1`.
- The watcher should sync and commit locally only. Remote push stays manual.

## Working Rules

- Treat `C:\Users\admin\.codex\skills` as the source of truth on this machine.
- Mirror all skill directories, including `.system/`, into the repo `skills/` directory.
- Use repository scripts rather than ad hoc copy commands when the task is about syncing or backing up.
- When troubleshooting sync, inspect `git status`, `git remote -v`, and the watcher startup entry before changing scripts.

## Authoring Convention

- Write skill rules, workflow steps, and repository procedures in English.
- Write human-oriented comments or explanatory notes in Chinese when comments are needed.
- Keep commands, paths, environment variables, git terms, and file names in their original technical language.
- If a Chinese phrase appears inside the skill body, use it only as a trigger example or a user-facing explanation.
