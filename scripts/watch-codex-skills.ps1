param(
    [string]$SourceDir = "$HOME\.codex\skills",
    [string]$RepoDir = (Split-Path -Parent $PSScriptRoot),
    [int]$DebounceSeconds = 10
)

$ErrorActionPreference = "Stop"

if (-not (Test-Path $SourceDir)) {
    throw "Source skill directory not found: $SourceDir"
}

$syncScript = Join-Path $PSScriptRoot "sync-codex-skills.ps1"
if (-not (Test-Path $syncScript)) {
    throw "Sync script not found: $syncScript"
}

$global:PendingSync = $false
$global:LastEventAt = Get-Date

function Invoke-Sync {
    $global:PendingSync = $false
    & $syncScript -SourceDir $SourceDir -RepoDir $RepoDir -Push -Quiet
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
}
