# modules/install.ps1
# Installations-Logik, Exit-Code-Behandlung und Zusammenfassung

$script:EXITCODE_ALREADY_INSTALLED = -1978335189
$script:EXITCODE_NOT_FOUND         = -1978335153

function Install-Package {
    param(
        [string]$Name,
        [string]$Id,
        [string]$Source = "winget"
    )

    $args = @(
        "install",
        "--id", $Id,
        "--source", $Source,
        "--silent",
        "--accept-package-agreements",
        "--accept-source-agreements"
    )

    winget @args 2>&1 | Out-Null
    $ec = $LASTEXITCODE

    if ($ec -eq 0) {
        return "ok"
    } elseif ($ec -eq $script:EXITCODE_ALREADY_INSTALLED) {
        return "skipped"
    } elseif ($ec -eq $script:EXITCODE_NOT_FOUND) {
        return "error"
    } else {
        return "error"
    }
}

function Start-Installation {
    param(
        [array]$Packages,
        [System.Windows.Forms.RichTextBox]$LogBox,
        [System.Windows.Forms.ProgressBar]$ProgressBar,
        [System.Windows.Forms.Label]$StatusLabel
    )

    $results = @{ ok = @(); skipped = @(); error = @() }
    $total   = $Packages.Count
    $current = 0

    foreach ($pkg in $Packages) {
        $current++
        $pct = [int](($current / $total) * 100)

        if ($ProgressBar)  { $ProgressBar.Value = $pct }
        if ($StatusLabel)  { $StatusLabel.Text = "[$current/$total]  Installiere $($pkg.Name)..." }
        if ($LogBox)       {
            $LogBox.SelectionColor = [System.Drawing.Color]::FromArgb(180,180,180)
            $LogBox.AppendText(">> Installiere $($pkg.Name)...`n")
            $LogBox.ScrollToCaret()
        }
        [System.Windows.Forms.Application]::DoEvents()

        $status = Install-Package -Name $pkg.Name -Id $pkg.Id -Source $pkg.Source
        $results[$status] += $pkg.Name

        if ($LogBox) {
            switch ($status) {
                "ok"      {
                    $LogBox.SelectionColor = [System.Drawing.Color]::FromArgb(100,220,100)
                    $LogBox.AppendText("   [OK]  $($pkg.Name) installiert`n")
                }
                "skipped" {
                    $LogBox.SelectionColor = [System.Drawing.Color]::FromArgb(130,130,130)
                    $LogBox.AppendText("   [--]  $($pkg.Name) bereits installiert`n")
                }
                "error"   {
                    $LogBox.SelectionColor = [System.Drawing.Color]::FromArgb(220,80,80)
                    $LogBox.AppendText("   [!!]  $($pkg.Name) fehlgeschlagen`n")
                }
            }
            $LogBox.ScrollToCaret()
            [System.Windows.Forms.Application]::DoEvents()
        }
    }

    if ($ProgressBar) { $ProgressBar.Value = 100 }
    if ($StatusLabel) {
        $StatusLabel.Text = "Fertig!   OK: $($results.ok.Count)   Übersprungen: $($results.skipped.Count)   Fehler: $($results.error.Count)"
    }
    if ($LogBox) {
        $LogBox.SelectionColor = [System.Drawing.Color]::FromArgb(100,180,255)
        $LogBox.AppendText("`n=== Fertig! OK: $($results.ok.Count)  Uebersprungen: $($results.skipped.Count)  Fehler: $($results.error.Count) ===`n")
        $LogBox.ScrollToCaret()
    }

    return $results
}
