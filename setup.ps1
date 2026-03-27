#Requires -RunAsAdministrator
<#
.SYNOPSIS
    Windows Setup Script - Automatische Programm-Installation via winget
.DESCRIPTION
    Kategorienbasierte Installation. Kann direkt via irm | iex aus GitHub ausgefuehrt werden.
.EXAMPLE
    irm https://raw.githubusercontent.com/USERNAME/windows-setup/main/setup.ps1 | iex
#>

$ErrorActionPreference = "Stop"
$REPO_BASE_URL = "https://raw.githubusercontent.com/USERNAME/windows-setup/main"

# ──────────────────────────────────────────────
#  Bootstrap: Wenn via irm | iex ausgefuehrt,
#  haben wir kein $PSScriptRoot → Module laden
# ──────────────────────────────────────────────
function Initialize-Setup {
    $script:ScriptDir = $PSScriptRoot

    if (-not $script:ScriptDir) {
        Write-Host "  Lade Module herunter..." -ForegroundColor DarkGray

        $TempDir = Join-Path $env:TEMP "windows-setup"
        $ModDir  = Join-Path $TempDir "modules"

        New-Item -ItemType Directory -Force -Path $TempDir | Out-Null
        New-Item -ItemType Directory -Force -Path $ModDir  | Out-Null

        $modules = @("ui.ps1", "packages.ps1", "install.ps1")
        foreach ($mod in $modules) {
            $url  = "$REPO_BASE_URL/modules/$mod"
            $dest = Join-Path $ModDir $mod
            try {
                Invoke-WebRequest -Uri $url -OutFile $dest -UseBasicParsing
            } catch {
                Write-Host "  FEHLER: Konnte $mod nicht laden. Pruefe die URL/Verbindung." -ForegroundColor Red
                exit 1
            }
        }

        $script:ScriptDir = $TempDir
    }
}

# ──────────────────────────────────────────────
#  Module laden & Hauptmenue starten
# ──────────────────────────────────────────────
Initialize-Setup

. "$script:ScriptDir\modules\ui.ps1"
. "$script:ScriptDir\modules\packages.ps1"
. "$script:ScriptDir\modules\install.ps1"

Start-MainMenu
