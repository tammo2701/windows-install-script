#Requires -Version 5.1
<#
.EXAMPLE
    irm https://raw.githubusercontent.com/tammo2701/windows-install-script/main/setup.ps1 | iex
#>

$ErrorActionPreference = "Stop"
$REPO_BASE_URL = "https://raw.githubusercontent.com/tammo2701/windows-install-script/main"

# Auto-Elevation: UAC-Prompt wenn nicht als Admin, neues Fenster bleibt versteckt
$isAdmin = ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(
    [Security.Principal.WindowsBuiltInRole]::Administrator
)
if (-not $isAdmin) {
    $cmd = "irm https://raw.githubusercontent.com/tammo2701/windows-install-script/main/setup.ps1 | iex"
    Start-Process powershell.exe -Verb RunAs -WindowStyle Hidden -ArgumentList "-NoProfile -ExecutionPolicy Bypass -Command `"$cmd`""
    exit 0
}

function Initialize-Setup {
    $script:ScriptDir = $PSScriptRoot

    if (-not $script:ScriptDir) {
        Write-Host "Lade Module herunter..." -ForegroundColor DarkGray

        $TempDir = Join-Path $env:TEMP "windows-install-script"
        $ModDir  = Join-Path $TempDir "modules"

        New-Item -ItemType Directory -Force -Path $TempDir | Out-Null
        New-Item -ItemType Directory -Force -Path $ModDir  | Out-Null

        $modules = @("ui.ps1", "packages.ps1", "install.ps1")
        foreach ($mod in $modules) {
            $url  = "$REPO_BASE_URL/modules/$mod"
            $dest = Join-Path $ModDir $mod
            try {
                $content = (Invoke-WebRequest -Uri $url -UseBasicParsing).Content
                [System.IO.File]::WriteAllText($dest, $content, [System.Text.Encoding]::UTF8)
            } catch {
                Write-Host "FEHLER: Konnte $mod nicht laden. ($url)" -ForegroundColor Red
                pause
                exit 1
            }
        }

        $script:ScriptDir = $TempDir
    }
}

Initialize-Setup

. "$script:ScriptDir\modules\packages.ps1"
. "$script:ScriptDir\modules\install.ps1"
. "$script:ScriptDir\modules\ui.ps1"

Start-MainMenu
