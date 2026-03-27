# modules/ui.ps1
# Alle Ausgabe-Funktionen und das Hauptmenue

# ──────────────────────────────────────────────
#  Output-Helfer
# ──────────────────────────────────────────────
function Write-Banner {
    Clear-Host
    Write-Host ""
    Write-Host "  +==================================================+" -ForegroundColor Cyan
    Write-Host "  |       Windows Setup  //  by tammo2701            |" -ForegroundColor Cyan
    Write-Host "  |    Automatische Installation via winget           |" -ForegroundColor Cyan
    Write-Host "  +==================================================+" -ForegroundColor Cyan
    Write-Host ""
}

function Write-Success { param($msg) Write-Host "  [OK]  $msg" -ForegroundColor Green   }
function Write-Err     { param($msg) Write-Host "  [!!]  $msg" -ForegroundColor Red     }
function Write-Info    { param($msg) Write-Host "  [**]  $msg" -ForegroundColor Cyan    }
function Write-Step    { param($msg) Write-Host "  [>>]  $msg" -ForegroundColor Yellow  }
function Write-Dim     { param($msg) Write-Host "        $msg" -ForegroundColor DarkGray }

# ──────────────────────────────────────────────
#  Kategorie-Auswahl anzeigen
# ──────────────────────────────────────────────
function Show-CategoryMenu {
    Write-Host "  Kategorien:" -ForegroundColor White
    Write-Host ""

    $i = 1
    foreach ($cat in $script:Categories.GetEnumerator() | Sort-Object { $_.Value.Order }) {
        $label   = $cat.Value.Label
        $preview = $cat.Value.Preview

        Write-Host ("  [{0}]  {1}" -f $i, $label) -ForegroundColor White -NoNewline
        Write-Host ("   -   {0}" -f $preview) -ForegroundColor DarkGray
        $i++
    }

    Write-Host ""
    Write-Host "  [all]  Alle Kategorien installieren" -ForegroundColor DarkYellow
    Write-Host "  [0]    Beenden"                      -ForegroundColor DarkGray
    Write-Host ""
}

# ──────────────────────────────────────────────
#  Hauptmenue + Input-Loop
# ──────────────────────────────────────────────
function Start-MainMenu {
    # winget-Pruefung
    if (-not (Get-Command winget -ErrorAction SilentlyContinue)) {
        Write-Banner
        Write-Err "winget nicht gefunden!"
        Write-Dim "Installiere den 'App Installer' aus dem Microsoft Store."
        Write-Host ""
        pause
        exit 1
    }

    while ($true) {
        Write-Banner
        Show-CategoryMenu

        $userInput = Read-Host "  Auswahl (z.B. '1 3' oder 'all')"
        $userInput = $userInput.Trim().ToLower()

        if ($userInput -eq "0" -or $userInput -eq "q" -or $userInput -eq "exit") {
            Write-Host ""
            Write-Info "Tschuess!"
            Write-Host ""
            exit 0
        }

        # Kategorien aus Eingabe ermitteln
        $catList  = $script:Categories.GetEnumerator() | Sort-Object { $_.Value.Order }
        $catKeys  = @($catList | ForEach-Object { $_.Key })
        $selected = @()

        if ($userInput -eq "all") {
            $selected = $catKeys
        } else {
            foreach ($token in ($userInput -split "\s+")) {
                if ($token -match "^\d+$") {
                    $idx = [int]$token - 1
                    if ($idx -ge 0 -and $idx -lt $catKeys.Count) {
                        $selected += $catKeys[$idx]
                    } else {
                        Write-Err "Ungueltige Nummer: $token"
                    }
                }
            }
        }

        if ($selected.Count -eq 0) {
            Write-Err "Keine gueltige Auswahl. Bitte erneut versuchen."
            Start-Sleep -Seconds 2
            continue
        }

        # Ausgewaehlte Kategorien + Pakete anzeigen
        Write-Banner
        Write-Host "  Folgende Programme werden installiert:" -ForegroundColor White
        Write-Host ""

        $allPkgs = @()
        foreach ($key in $selected) {
            $cat = $script:Categories[$key]
            Write-Host ("  {0}" -f $cat.Label) -ForegroundColor Cyan
            foreach ($pkg in $cat.Packages) {
                Write-Dim "  $($pkg.Name)"
                $allPkgs += $pkg
            }
            Write-Host ""
        }

        Write-Host ("  Gesamt: {0} Programme" -f $allPkgs.Count) -ForegroundColor Yellow
        Write-Host ""
        $confirm = Read-Host "  Installieren? [J/n]"

        if ($confirm -eq "" -or $confirm -match "^[jJyY]") {
            Start-Installation -Packages $allPkgs
            Write-Host ""
            $again = Read-Host "  Weiteres installieren? [J/n]"
            if ($again -notmatch "^[jJyY]" -and $again -ne "") { break }
        } else {
            Write-Info "Abgebrochen."
            Start-Sleep -Seconds 1
        }
    }
}
