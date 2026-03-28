# modules/ui.ps1
# WinForms GUI

Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing
[System.Windows.Forms.Application]::EnableVisualStyles()

# ----- Farben & Fonts -----
$BG        = [System.Drawing.Color]::FromArgb(18, 18, 24)
$BG2       = [System.Drawing.Color]::FromArgb(28, 28, 38)
$BG3       = [System.Drawing.Color]::FromArgb(38, 38, 52)
$ACCENT    = [System.Drawing.Color]::FromArgb(99, 102, 241)
$FG        = [System.Drawing.Color]::FromArgb(225, 225, 235)
$FG_DIM    = [System.Drawing.Color]::FromArgb(130, 130, 150)
$COL_OK    = [System.Drawing.Color]::FromArgb(100, 220, 100)
$COL_ERR   = [System.Drawing.Color]::FromArgb(220, 80, 80)

$FontMain  = New-Object System.Drawing.Font("Segoe UI", 10)
$FontBold  = New-Object System.Drawing.Font("Segoe UI Semibold", 10)
$FontTitle = New-Object System.Drawing.Font("Segoe UI", 16, [System.Drawing.FontStyle]::Bold)
$FontSmall = New-Object System.Drawing.Font("Segoe UI", 8.5)
$FontMono  = New-Object System.Drawing.Font("Consolas", 9)

function New-FlatButton {
    param($BtnLabel, $X, $Y, $W = 160, $H = 38, $BtnColor = $ACCENT)
    $btn = New-Object System.Windows.Forms.Button
    $btn.Text      = $BtnLabel
    $btn.Location  = New-Object System.Drawing.Point($X, $Y)
    $btn.Size      = New-Object System.Drawing.Size($W, $H)
    $btn.FlatStyle = [System.Windows.Forms.FlatStyle]::Flat
    $btn.FlatAppearance.BorderSize = 0
    $btn.BackColor = $BtnColor
    $btn.ForeColor = $FG
    $btn.Font      = $FontBold
    $btn.Cursor    = [System.Windows.Forms.Cursors]::Hand
    return $btn
}

function Start-MainMenu {
    $form = New-Object System.Windows.Forms.Form
    $form.Text            = "Windows Setup  //  tammo2701"
    $form.Size            = New-Object System.Drawing.Size(920, 700)
    $form.StartPosition   = "CenterScreen"
    $form.BackColor       = $BG
    $form.ForeColor       = $FG
    $form.Font            = $FontMain
    $form.FormBorderStyle = "FixedSingle"
    $form.MaximizeBox     = $false

    # Header
    $header = New-Object System.Windows.Forms.Panel
    $header.Size      = New-Object System.Drawing.Size(920, 70)
    $header.Location  = New-Object System.Drawing.Point(0, 0)
    $header.BackColor = $BG2
    $form.Controls.Add($header)

    $lblTitle = New-Object System.Windows.Forms.Label
    $lblTitle.Text      = "Windows Setup"
    $lblTitle.Font      = $FontTitle
    $lblTitle.ForeColor = $FG
    $lblTitle.Location  = New-Object System.Drawing.Point(24, 12)
    $lblTitle.AutoSize  = $true
    $header.Controls.Add($lblTitle)

    $lblSub = New-Object System.Windows.Forms.Label
    $lblSub.Text      = "by tammo2701  -  Automatische Installation via winget"
    $lblSub.Font      = $FontSmall
    $lblSub.ForeColor = $FG_DIM
    $lblSub.Location  = New-Object System.Drawing.Point(26, 46)
    $lblSub.AutoSize  = $true
    $header.Controls.Add($lblSub)

    # Linke Seite: Kategorien
    $leftPanel = New-Object System.Windows.Forms.Panel
    $leftPanel.Size      = New-Object System.Drawing.Size(440, 560)
    $leftPanel.Location  = New-Object System.Drawing.Point(0, 70)
    $leftPanel.BackColor = $BG
    $form.Controls.Add($leftPanel)

    $lblCat = New-Object System.Windows.Forms.Label
    $lblCat.Text      = "Kategorien"
    $lblCat.Font      = $FontBold
    $lblCat.ForeColor = $FG_DIM
    $lblCat.Location  = New-Object System.Drawing.Point(20, 14)
    $lblCat.AutoSize  = $true
    $leftPanel.Controls.Add($lblCat)

    $checkboxes = @{}
    $catList    = $script:Categories.GetEnumerator() | Sort-Object { $_.Value.Order }
    $yPos       = 40

    foreach ($cat in $catList) {
        $key  = $cat.Key
        $data = $cat.Value

        $card = New-Object System.Windows.Forms.Panel
        $card.Size      = New-Object System.Drawing.Size(400, 68)
        $card.Location  = New-Object System.Drawing.Point(16, $yPos)
        $card.BackColor = $BG2
        $leftPanel.Controls.Add($card)

        $cb = New-Object System.Windows.Forms.CheckBox
        $cb.Location  = New-Object System.Drawing.Point(12, 10)
        $cb.Size      = New-Object System.Drawing.Size(380, 22)
        $cb.Text      = $data.Label
        $cb.Font      = $FontBold
        $cb.ForeColor = $FG
        $cb.BackColor = $BG2
        $cb.FlatStyle = "Flat"
        $card.Controls.Add($cb)
        $checkboxes[$key] = $cb

        $lblPrev = New-Object System.Windows.Forms.Label
        $lblPrev.Text      = $data.Preview
        $lblPrev.Font      = $FontSmall
        $lblPrev.ForeColor = $FG_DIM
        $lblPrev.Location  = New-Object System.Drawing.Point(32, 36)
        $lblPrev.Size      = New-Object System.Drawing.Size(360, 20)
        $card.Controls.Add($lblPrev)

        $yPos += 76
    }

    # Trennlinie
    $sep = New-Object System.Windows.Forms.Panel
    $sep.Size      = New-Object System.Drawing.Size(1, 560)
    $sep.Location  = New-Object System.Drawing.Point(440, 70)
    $sep.BackColor = $BG3
    $form.Controls.Add($sep)

    # Rechte Seite: Log
    $rightPanel = New-Object System.Windows.Forms.Panel
    $rightPanel.Size      = New-Object System.Drawing.Size(478, 560)
    $rightPanel.Location  = New-Object System.Drawing.Point(442, 70)
    $rightPanel.BackColor = $BG
    $form.Controls.Add($rightPanel)

    $lblLog = New-Object System.Windows.Forms.Label
    $lblLog.Text      = "Ausgabe"
    $lblLog.Font      = $FontBold
    $lblLog.ForeColor = $FG_DIM
    $lblLog.Location  = New-Object System.Drawing.Point(12, 14)
    $lblLog.AutoSize  = $true
    $rightPanel.Controls.Add($lblLog)

    $logBox = New-Object System.Windows.Forms.RichTextBox
    $logBox.Location    = New-Object System.Drawing.Point(12, 40)
    $logBox.Size        = New-Object System.Drawing.Size(454, 440)
    $logBox.BackColor   = $BG2
    $logBox.ForeColor   = $FG
    $logBox.Font        = $FontMono
    $logBox.BorderStyle = "None"
    $logBox.ReadOnly    = $true
    $logBox.ScrollBars  = "Vertical"
    $logBox.Text        = "Bereit. Kategorien auswaehlen und auf 'Installieren' klicken.`n"
    $rightPanel.Controls.Add($logBox)

    $progress = New-Object System.Windows.Forms.ProgressBar
    $progress.Location  = New-Object System.Drawing.Point(12, 492)
    $progress.Size      = New-Object System.Drawing.Size(454, 8)
    $progress.Style     = "Continuous"
    $progress.BackColor = $BG3
    $progress.ForeColor = $ACCENT
    $rightPanel.Controls.Add($progress)

    $lblStatus = New-Object System.Windows.Forms.Label
    $lblStatus.Text      = ""
    $lblStatus.Font      = $FontSmall
    $lblStatus.ForeColor = $FG_DIM
    $lblStatus.Location  = New-Object System.Drawing.Point(12, 506)
    $lblStatus.Size      = New-Object System.Drawing.Size(454, 20)
    $rightPanel.Controls.Add($lblStatus)

    # Footer
    $footer = New-Object System.Windows.Forms.Panel
    $footer.Size      = New-Object System.Drawing.Size(920, 56)
    $footer.Location  = New-Object System.Drawing.Point(0, 630)
    $footer.BackColor = $BG2
    $form.Controls.Add($footer)

    $btnAll     = New-FlatButton "Alle auswaehlen" 20  9 160 38 $BG3
    $btnNone    = New-FlatButton "Auswahl leeren"  192 9 160 38 $BG3
    $btnInstall = New-FlatButton "  Installieren  " 720 9 178 38 $ACCENT
    $footer.Controls.Add($btnAll)
    $footer.Controls.Add($btnNone)
    $footer.Controls.Add($btnInstall)

    # Events
    $btnAll.Add_Click({
        foreach ($cb in $checkboxes.Values) { $cb.Checked = $true }
    })

    $btnNone.Add_Click({
        foreach ($cb in $checkboxes.Values) { $cb.Checked = $false }
    })

    $btnInstall.Add_Click({
        $selected = @()
        foreach ($k in $checkboxes.Keys) {
            if ($checkboxes[$k].Checked) { $selected += $k }
        }

        if ($selected.Count -eq 0) {
            [System.Windows.Forms.MessageBox]::Show(
                "Bitte mindestens eine Kategorie auswaehlen.",
                "Keine Auswahl",
                [System.Windows.Forms.MessageBoxButtons]::OK,
                [System.Windows.Forms.MessageBoxIcon]::Information
            ) | Out-Null
            return
        }

        $allPkgs = @()
        foreach ($k in $selected) {
            foreach ($pkg in $script:Categories[$k].Packages) {
                $allPkgs += $pkg
            }
        }

        $logBox.Clear()
        $progress.Value     = 0
        $btnInstall.Enabled = $false
        $btnInstall.Text    = "Laeuft..."

        Start-Installation -Packages $allPkgs -LogBox $logBox -ProgressBar $progress -StatusLabel $lblStatus

        $btnInstall.Enabled = $true
        $btnInstall.Text    = "  Installieren  "
    })

    $form.ShowDialog() | Out-Null
}
