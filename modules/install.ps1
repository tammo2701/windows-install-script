# modules/install.ps1
# Installations-Logik, Exit-Code-Behandlung und Zusammenfassung

# winget Exit Codes
# 0              = Erfolg
# -1978335189    = Bereits installiert (APPINSTALLER_ERROR_ALREADY_INSTALLED)
# -1978335153    = Kein passendes Paket gefunden
# -1978335135    = Paket erfordert manuellen Eingriff
$EXITCODE_ALREADY_INSTALLED = -1978335189
$EXITCODE_NOT_FOUND         = -1978335153

# ──────────────────────────────────────────────
#  Einzelpaket installieren
# ──────────────────────────────────────────────
function Install-Package {
    param(
        [string]$Name,
        [string]$Id
    )

    Write-Step "Installiere $Name  ($Id)"

    winget install `
        --id $Id `
        --silent `
        --accept-package-agreements `
        --accept-source-agreements `
        2>&1 | Out-Null

    switch ($LASTEXITCODE) {
        0                       { Write-Success "$Name installiert";          return "ok"       }
        $EXITCODE_ALREADY_INSTALLED { Write-Dim    "$Name bereits installiert"; return "skipped"  }
        $EXITCODE_NOT_FOUND     { Write-Err    "$Name nicht gefunden (ID: $Id)"; return "error"  }
        default                 { Write-Err    "$Name fehlgeschlagen (Exit: $LASTEXITCODE)"; return "error" }
    }
}

# ──────────────────────────────────────────────
#  Batch-Installation + Live-Fortschritt
# ──────────────────────────────────────────────
function Start-Installation {
    param(
        [array]$Packages
    )

    $results = @{ ok = @(); skipped = @(); error = @() }
    $total   = $Packages.Count
    $current = 0

    Write-Host ""
    Write-Host "  ─────────────────────────────────────" -ForegroundColor DarkGray
    Write-Info "Starte Installation ($total Pakete)..."
    Write-Host "  ─────────────────────────────────────" -ForegroundColor DarkGray
    Write-Host ""

    foreach ($pkg in $Packages) {
        $current++
        Write-Host ("  [{0}/{1}]" -f $current, $total) -ForegroundColor DarkGray -NoNewline
        Write-Host ""

        $status = Install-Package -Name $pkg.Name -Id $pkg.Id
        $results[$status] += $pkg.Name
        Write-Host ""
    }

    Show-Summary -Results $results
}

# ──────────────────────────────────────────────
#  Zusammenfassung nach der Installation
# ──────────────────────────────────────────────
function Show-Summary {
    param([hashtable]$Results)

    Write-Host "  ═════════════════════════════════════" -ForegroundColor Cyan
    Write-Host "  Zusammenfassung" -ForegroundColor Cyan
    Write-Host "  ═════════════════════════════════════" -ForegroundColor Cyan
    Write-Host ""

    Write-Host ("  ✔  Installiert:      {0}" -f $Results.ok.Count)      -ForegroundColor Green
    Write-Host ("  ●  Bereits vorhanden: {0}" -f $Results.skipped.Count) -ForegroundColor DarkGray
    Write-Host ("  ✘  Fehlgeschlagen:   {0}" -f $Results.error.Count)   -ForegroundColor $(
        if ($Results.error.Count -gt 0) { "Red" } else { "DarkGray" }
    )

    if ($Results.error.Count -gt 0) {
        Write-Host ""
        Write-Host "  Fehlgeschlagene Pakete:" -ForegroundColor Red
        foreach ($name in $Results.error) {
            Write-Dim "     $name"
        }
        Write-Host ""
        Write-Dim "Tipp: Manuell pruefen mit  winget search <name>"
    }

    Write-Host ""
    Write-Host "  ═════════════════════════════════════" -ForegroundColor Cyan
    Write-Host ""
}
