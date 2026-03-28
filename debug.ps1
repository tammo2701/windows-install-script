# debug.ps1 - Fehler abfangen und anzeigen
$ErrorActionPreference = "Continue"

Write-Host "=== DEBUG START ===" -ForegroundColor Yellow
Write-Host ""

# Cache loeschen
$cache = "$env:TEMP\windows-install-script"
if (Test-Path $cache) {
    Remove-Item -Recurse -Force $cache
    Write-Host "[OK] Cache geloescht: $cache" -ForegroundColor Green
}

# Module direkt laden (ohne irm) um Encoding-Probleme auszuschliessen
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path

Write-Host "[..] Lade packages.ps1..." -ForegroundColor Cyan
try {
    . "$ScriptDir\modules\packages.ps1"
    Write-Host "[OK] packages.ps1 geladen" -ForegroundColor Green
} catch {
    Write-Host "[!!] FEHLER in packages.ps1:" -ForegroundColor Red
    Write-Host $_.Exception.Message -ForegroundColor Red
    Write-Host $_.ScriptStackTrace -ForegroundColor DarkGray
}

Write-Host "[..] Lade install.ps1..." -ForegroundColor Cyan
try {
    . "$ScriptDir\modules\install.ps1"
    Write-Host "[OK] install.ps1 geladen" -ForegroundColor Green
} catch {
    Write-Host "[!!] FEHLER in install.ps1:" -ForegroundColor Red
    Write-Host $_.Exception.Message -ForegroundColor Red
    Write-Host $_.ScriptStackTrace -ForegroundColor DarkGray
}

Write-Host "[..] Lade ui.ps1..." -ForegroundColor Cyan
try {
    . "$ScriptDir\modules\ui.ps1"
    Write-Host "[OK] ui.ps1 geladen" -ForegroundColor Green
} catch {
    Write-Host "[!!] FEHLER in ui.ps1:" -ForegroundColor Red
    Write-Host $_.Exception.Message -ForegroundColor Red
    Write-Host $_.ScriptStackTrace -ForegroundColor DarkGray
}

Write-Host ""
Write-Host "[..] Starte GUI..." -ForegroundColor Cyan
try {
    Start-MainMenu
} catch {
    Write-Host "[!!] FEHLER in Start-MainMenu:" -ForegroundColor Red
    Write-Host $_.Exception.Message -ForegroundColor Red
    Write-Host $_.ScriptStackTrace -ForegroundColor DarkGray
}

Write-Host ""
Write-Host "=== DEBUG ENDE ===" -ForegroundColor Yellow
Write-Host "Druecke eine Taste..."
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
