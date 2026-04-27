param(
    [string]$RepoDir = (Split-Path -Parent $PSScriptRoot),
    [string]$TargetDir = "$HOME\.codex\skills"
)

$ErrorActionPreference = "Stop"

$skillsSource = Join-Path $RepoDir "skills"
if (-not (Test-Path $skillsSource)) {
    throw "Repository skills directory not found: $skillsSource"
}

if (-not (Test-Path $TargetDir)) {
    New-Item -ItemType Directory -Force -Path $TargetDir | Out-Null
}

$null = robocopy $skillsSource $TargetDir /MIR /R:2 /W:1 /NFL /NDL /NJH /NJS /NP
$robocopyExit = $LASTEXITCODE
if ($robocopyExit -ge 8) {
    throw "robocopy failed with exit code $robocopyExit"
}

Write-Host "Installed skills from $skillsSource to $TargetDir"
