# codexSKill

This repository mirrors `C:\Users\admin\.codex\skills` so the same Codex skills can be cloned onto other machines.

## Layout

- `skills/`: mirrored Codex skills, including `.system/` and custom skills
- `scripts/sync-codex-skills.ps1`: sync local skills into this repo, commit, and optionally push
- `scripts/watch-codex-skills.ps1`: watch local skill changes and auto-run sync
- `scripts/install-skills.ps1`: install mirrored skills from this repo into another machine's `~/.codex/skills`

## Sync this machine

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\sync-codex-skills.ps1 -Push
```

## Install on another machine

```powershell
git clone https://github.com/kangkanggege111/codexSKill.git
cd codexSKill
powershell -ExecutionPolicy Bypass -File .\scripts\install-skills.ps1
```

## Auto-sync

This repo is prepared to run `scripts/watch-codex-skills.ps1` at logon through the Windows Startup folder. The watcher debounces file changes, mirrors `~/.codex/skills` into `skills/`, commits updates, and pushes them to `origin/main`.
