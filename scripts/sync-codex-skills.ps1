param(
    [string]$SourceDir = "$HOME\.codex\skills",
    [string]$RepoDir = (Split-Path -Parent $PSScriptRoot),
    [string]$CommitMessage = "",
    [switch]$Push,
    [switch]$SkipCommit,
    [switch]$Quiet
)

$ErrorActionPreference = "Stop"

# 输出开关：安静模式下不打印普通进度。
function Write-Info([string]$Message) {
    if (-not $Quiet) {
        Write-Host $Message
    }
}

function Ensure-Repo([string]$Path) {
    $gitDir = Join-Path $Path ".git"
    if (-not (Test-Path $gitDir)) {
        throw "Not a git repository: $Path"
    }
}

function Ensure-Dir([string]$Path) {
    if (-not (Test-Path $Path)) {
        New-Item -ItemType Directory -Force -Path $Path | Out-Null
    }
}

Ensure-Repo $RepoDir

$skillsTarget = Join-Path $RepoDir "skills"
Ensure-Dir $skillsTarget

if (-not (Test-Path $SourceDir)) {
    throw "Source skill directory not found: $SourceDir"
}

Write-Info "Mirroring skills from $SourceDir to $skillsTarget"

# 用 robocopy 做镜像同步，保持仓库 skills/ 与本机 source 完全一致。
$null = robocopy $SourceDir $skillsTarget /MIR /R:2 /W:1 /NFL /NDL /NJH /NJS /NP
$robocopyExit = $LASTEXITCODE
if ($robocopyExit -ge 8) {
    throw "robocopy failed with exit code $robocopyExit"
}

Push-Location $RepoDir
try {
    $status = git status --porcelain
    if (-not $status) {
        Write-Info "No repository changes detected."
        return
    }

    Write-Info "Detected repository changes."
    if ($SkipCommit) {
        return
    }

    git add -A

    if ([string]::IsNullOrWhiteSpace($CommitMessage)) {
        # 默认提交信息带时间戳，便于回看自动同步记录。
        $CommitMessage = "Sync Codex skills $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')"
    }

    $postAddStatus = git status --porcelain
    if (-not $postAddStatus) {
        Write-Info "Nothing to commit after staging."
        return
    }

    git commit -m $CommitMessage

    if ($Push) {
        # 仅在显式传入 -Push 时才推送远程。
        git push
    }
}
finally {
    Pop-Location
}
