# Codex Skill 仓库命令说明

这份文档只记录你以后最常用、最不容易出错的命令。

仓库根目录：

```powershell
D:\github\CodexSkill-myGitHub\codexSKill
```

本机 Codex skill 源目录：

```powershell
C:\Users\admin\.codex\skills
```

## 1. 进入仓库

```powershell
cd D:\github\CodexSkill-myGitHub\codexSKill
```

## 2. 把本机最新 skills 同步到本地仓库

用途：
- 你新建了 skill
- 你修改了 skill
- 你想手动确保本地仓库已更新

命令：

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\sync-codex-skills.ps1
```

效果：
- 把 `C:\Users\admin\.codex\skills` 镜像到仓库里的 `skills\`
- 自动 `git add`
- 自动本地 `git commit`
- 不会自动推送远程

## 3. 查看本地仓库状态

```powershell
git status --short --branch
```

常见结果：
- `ahead N`：说明本地有 N 个提交还没推送
- 没有改动：说明工作区干净

## 4. 手动推送到 GitHub

只在你确认没问题后再执行：

```powershell
git push
```

如果你只想看将要推送什么，先执行：

```powershell
git log --oneline origin/main..HEAD
```

## 5. 查看最近提交

```powershell
git log --oneline -10
```

## 6. 查看 watcher 是否已经启动

```powershell
Get-CimInstance Win32_Process | Where-Object { $_.Name -eq 'powershell.exe' -and $_.CommandLine -like '*watch-codex-skills.ps1*' } | Select-Object ProcessId,CommandLine
```

如果有结果，说明 watcher 正在后台运行。

## 7. 查看 watcher 日志

```powershell
Get-Content -Tail 50 .\logs\watch-codex-skills.log
```

持续观察日志：

```powershell
Get-Content .\logs\watch-codex-skills.log -Wait
```

## 8. 手动启动 watcher

如果你怀疑 watcher 没起来，手动执行：

```powershell
Start-Process -WindowStyle Hidden powershell.exe -ArgumentList '-NoProfile','-ExecutionPolicy','Bypass','-File','D:\github\CodexSkill-myGitHub\codexSKill\scripts\watch-codex-skills.ps1'
```

## 9. 停止 watcher

```powershell
Get-CimInstance Win32_Process | Where-Object { $_.Name -eq 'powershell.exe' -and $_.CommandLine -like '*watch-codex-skills.ps1*' } | ForEach-Object { Stop-Process -Id $_.ProcessId -Force }
```

## 10. 在另一台电脑安装这些 skills

先 clone 仓库，再执行：

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\install-skills.ps1
```

## 11. 验证某个新 skill 是否合规

示例：

```powershell
$env:PYTHONUTF8='1'
python C:\Users\admin\.codex\skills\.system\skill-creator\scripts\quick_validate.py C:\Users\admin\.codex\skills\qt-qss-styling
```

把最后那个目录换成你要检查的 skill 路径。

## 12. 推荐操作顺序

以后最稳的顺序就是：

1. 在 `C:\Users\admin\.codex\skills` 新建或修改 skill
2. watcher 自动同步到本地仓库
3. 进入仓库看状态
4. 查看最近提交
5. 确认没问题后手动 `git push`

## 13. 最常用的四条命令

```powershell
cd D:\github\CodexSkill-myGitHub\codexSKill
git status --short --branch
git log --oneline origin/main..HEAD
git push
```

## 14. 如果同步异常，先查这三项

```powershell
git status --short --branch
Get-Content -Tail 50 .\logs\watch-codex-skills.log
Get-CimInstance Win32_Process | Where-Object { $_.Name -eq 'powershell.exe' -and $_.CommandLine -like '*watch-codex-skills.ps1*' } | Select-Object ProcessId,CommandLine
```
