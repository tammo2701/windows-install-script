#Requires -Version 5.1
<#
.SYNOPSIS
    Windows Setup Script - Automatische Programm-Installation via winget
.EXAMPLE
    irm https://raw.githubusercontent.com/tammo2701/windows-install-script/main/setup.ps1 | iex
#>

$ErrorActionPreference = "Stop"
$REPO_BASE_URL = "https://raw.githubusercontent.com/tammo2701/windows-install-script/main"

$isAdmin = ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(
    [Security.Principal.WindowsBuiltInRole]::Administrator
)
if (-not $isAdmin) {
    Write-Host ""
    Write-Host "  FEHLER: Bitte PowerShell als Administrator starten!" -ForegroundColor Red
    Write-Host ""
    Write-Host "  Druecke eine Taste zum Beenden..." -ForegroundColor DarkGray
    $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
    exit 1
}

function Initialize-Setup {
    $script:ScriptDir = $PSScriptRoot

    if (-not $script:ScriptDir) {
        Write-Host "  Lade Module herunter..." -ForegroundColor DarkGray

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
                Write-Host ""
                Write-Host "  FEHLER: Konnte $mod nicht laden." -ForegroundColor Red
                Write-Host "  URL: $url" -ForegroundColor DarkGray
                Write-Host ""
                Write-Host "  Druecke eine Taste zum Beenden..." -ForegroundColor DarkGray
                $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
                exit 1
            }
        }

        $script:ScriptDir = $TempDir
    }
}

Initialize-Setup

. "$script:ScriptDir\modules\ui.ps1"
. "$script:ScriptDir\modules\packages.ps1"
. "$script:ScriptDir\modules\install.ps1"

Start-MainMenu
