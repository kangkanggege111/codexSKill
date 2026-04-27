param(
    [string]$SourceDir = "$HOME\.codex\skills",
    [string]$RepoDir = (Split-Path -Parent $PSScriptRoot),
    [int]$DebounceSeconds = 10
)

$ErrorActionPreference = "Stop"

$createdNew = $false
$mutex = New-Object System.Threading.Mutex($false, "Global\CodexSkillAutoSyncWatcher", [ref]$createdNew)
if (-not $createdNew) {
    exit 0
}

if (-not (Test-Path $SourceDir)) {
    throw "Source skill directory not found: $SourceDir"
}

$syncScript = Join-Path $PSScriptRoot "sync-codex-skills.ps1"
if (-not (Test-Path $syncScript)) {
    throw "Sync script not found: $syncScript"
}

$logDir = Join-Path $RepoDir "logs"
if (-not (Test-Path $logDir)) {
    New-Item -ItemType Directory -Force -Path $logDir | Out-Null
}
$logFile = Join-Path $logDir "watch-codex-skills.log"

function Write-Log([string]$Message) {
    $line = "[{0}] {1}" -f (Get-Date -Format "yyyy-MM-dd HH:mm:ss"), $Message
    Add-Content -Path $logFile -Value $line
}

$global:PendingSync = $false
$global:LastEventAt = Get-Date

function Invoke-Sync {
    $global:PendingSync = $false
    try {
        & $syncScript -SourceDir $SourceDir -RepoDir $RepoDir -Quiet
        Write-Log "Sync completed."
    }
    catch {
        Write-Log "Sync failed: $($_.Exception.Message)"
    }
}

$watcher = New-Object System.IO.FileSystemWatcher
$watcher.Path = $SourceDir
$watcher.IncludeSubdirectories = $true
$watcher.NotifyFilter = [System.IO.NotifyFilters]'FileName, DirectoryName, LastWrite, CreationTime'
$watcher.EnableRaisingEvents = $true

$action = {
    $global:PendingSync = $true
    $global:LastEventAt = Get-Date
}

$created = Register-ObjectEvent $watcher Created -Action $action
$changed = Register-ObjectEvent $watcher Changed -Action $action
$deleted = Register-ObjectEvent $watcher Deleted -Action $action
$renamed = Register-ObjectEvent $watcher Renamed -Action $action

try {
    Write-Log "Watcher started for $SourceDir"
    while ($true) {
        Start-Sleep -Seconds 2
        if ($global:PendingSync) {
            $age = (Get-Date) - $global:LastEventAt
            if ($age.TotalSeconds -ge $DebounceSeconds) {
                Invoke-Sync
            }
        }
    }
}
finally {
    Unregister-Event -SourceIdentifier $created.Name
    Unregister-Event -SourceIdentifier $changed.Name
    Unregister-Event -SourceIdentifier $deleted.Name
    Unregister-Event -SourceIdentifier $renamed.Name
    $watcher.Dispose()
    $mutex.ReleaseMutex() | Out-Null
    $mutex.Dispose()
}
