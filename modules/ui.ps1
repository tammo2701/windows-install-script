# modules/ui.ps1
# WinForms GUI - cleanes Windows-Design

Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing
[System.Windows.Forms.Application]::EnableVisualStyles()

# Farben
$CLR_BG      = [System.Drawing.Color]::FromArgb(245, 245, 245)
$CLR_WHITE   = [System.Drawing.Color]::White
$CLR_HEADER  = [System.Drawing.Color]::FromArgb(30, 30, 30)
$CLR_BORDER  = [System.Drawing.Color]::FromArgb(210, 210, 210)
$CLR_ACCENT  = [System.Drawing.Color]::FromArgb(0, 120, 215)
$CLR_ACCENT2 = [System.Drawing.Color]::FromArgb(0, 100, 190)
$CLR_FG      = [System.Drawing.Color]::FromArgb(30, 30, 30)
$CLR_FG_DIM  = [System.Drawing.Color]::FromArgb(110, 110, 110)
$CLR_OK      = [System.Drawing.Color]::FromArgb(16, 124, 16)
$CLR_ERR     = [System.Drawing.Color]::FromArgb(196, 43, 28)
$CLR_WARN    = [System.Drawing.Color]::FromArgb(150, 150, 150)
$CLR_CARD    = [System.Drawing.Color]::White
$CLR_CARD_HV = [System.Drawing.Color]::FromArgb(235, 244, 255)

# Fonts
$FNT_MAIN    = New-Object System.Drawing.Font("Segoe UI", 9.5)
$FNT_BOLD    = New-Object System.Drawing.Font("Segoe UI Semibold", 9.5)
$FNT_TITLE   = New-Object System.Drawing.Font("Segoe UI", 18, [System.Drawing.FontStyle]::Bold)
$FNT_SMALL   = New-Object System.Drawing.Font("Segoe UI", 8.5)
$FNT_MONO    = New-Object System.Drawing.Font("Consolas", 9)

function New-Button {
    param($BtnLabel, $X, $Y, $W = 140, $H = 34, $BtnBg = $CLR_ACCENT, $BtnFg = $CLR_WHITE)
    $btn = New-Object System.Windows.Forms.Button
    $btn.Text      = $BtnLabel
    $btn.Location  = New-Object System.Drawing.Point($X, $Y)
    $btn.Size      = New-Object System.Drawing.Size($W, $H)
    $btn.FlatStyle = [System.Windows.Forms.FlatStyle]::Flat
    $btn.FlatAppearance.BorderSize  = 0
    $btn.FlatAppearance.MouseOverBackColor = $CLR_ACCENT2
    $btn.BackColor = $BtnBg
    $btn.ForeColor = $BtnFg
    $btn.Font      = $FNT_BOLD
    $btn.Cursor    = [System.Windows.Forms.Cursors]::Hand
    return $btn
}

function Start-MainMenu {
    $form = New-Object System.Windows.Forms.Form
    $form.Text            = "Windows Install Script"
    $form.Size            = New-Object System.Drawing.Size(960, 760)
    $form.MinimumSize     = New-Object System.Drawing.Size(960, 760)
    $form.StartPosition   = "CenterScreen"
    $form.BackColor       = $CLR_BG
    $form.ForeColor       = $CLR_FG
    $form.Font            = $FNT_MAIN
    $form.FormBorderStyle = "FixedSingle"
    $form.MaximizeBox     = $false

    # Header-Leiste
    $header = New-Object System.Windows.Forms.Panel
    $header.Size      = New-Object System.Drawing.Size(960, 72)
    $header.Location  = New-Object System.Drawing.Point(0, 0)
    $header.BackColor = $CLR_HEADER
    $form.Controls.Add($header)

    $lblTitle = New-Object System.Windows.Forms.Label
    $lblTitle.Text      = "Windows Install Script"
    $lblTitle.Font      = $FNT_TITLE
    $lblTitle.ForeColor = $CLR_WHITE
    $lblTitle.Location  = New-Object System.Drawing.Point(20, 14)
    $lblTitle.AutoSize  = $true
    $header.Controls.Add($lblTitle)

    $lblSub = New-Object System.Windows.Forms.Label
    $lblSub.Text      = "github.com/tammo2701/windows-install-script"
    $lblSub.Font      = $FNT_SMALL
    $lblSub.ForeColor = [System.Drawing.Color]::FromArgb(160, 160, 160)
    $lblSub.Location  = New-Object System.Drawing.Point(22, 50)
    $lblSub.AutoSize  = $true
    $header.Controls.Add($lblSub)

    # Spalten-Header
    $lblLeft = New-Object System.Windows.Forms.Label
    $lblLeft.Text      = "Kategorien auswaehlen"
    $lblLeft.Font      = $FNT_BOLD
    $lblLeft.ForeColor = $CLR_FG_DIM
    $lblLeft.Location  = New-Object System.Drawing.Point(20, 84)
    $lblLeft.AutoSize  = $true
    $form.Controls.Add($lblLeft)

    $lblRight = New-Object System.Windows.Forms.Label
    $lblRight.Text      = "Installationslog"
    $lblRight.Font      = $FNT_BOLD
    $lblRight.ForeColor = $CLR_FG_DIM
    $lblRight.Location  = New-Object System.Drawing.Point(478, 84)
    $lblRight.AutoSize  = $true
    $form.Controls.Add($lblRight)

    # Linke Spalte: Kategorie-Karten
    $scroll = New-Object System.Windows.Forms.Panel
    $scroll.Location    = New-Object System.Drawing.Point(16, 108)
    $scroll.Size        = New-Object System.Drawing.Size(446, 570)
    $scroll.BackColor   = $CLR_BG
    $scroll.AutoScroll  = $true
    $form.Controls.Add($scroll)

    $checkboxes = @{}
    $catList    = $script:Categories.GetEnumerator() | Sort-Object { $_.Value.Order }
    $yPos       = 4

    foreach ($cat in $catList) {
        $key  = $cat.Key
        $data = $cat.Value

        $card = New-Object System.Windows.Forms.Panel
        $card.Size      = New-Object System.Drawing.Size(424, 72)
        $card.Location  = New-Object System.Drawing.Point(4, $yPos)
        $card.BackColor = $CLR_CARD
        $card.BorderStyle = "FixedSingle"
        $scroll.Controls.Add($card)

        $cb = New-Object System.Windows.Forms.CheckBox
        $cb.Location  = New-Object System.Drawing.Point(10, 8)
        $cb.Size      = New-Object System.Drawing.Size(400, 24)
        $cb.Text      = $data.Label
        $cb.Font      = $FNT_BOLD
        $cb.ForeColor = $CLR_FG
        $cb.BackColor = $CLR_CARD
        $cb.FlatStyle = "Standard"
        $card.Controls.Add($cb)
        $checkboxes[$key] = $cb

        $pkgCount = $data.Packages.Count
        $lblPrev = New-Object System.Windows.Forms.Label
        $lblPrev.Text      = "$($data.Preview)   ($pkgCount Programme)"
        $lblPrev.Font      = $FNT_SMALL
        $lblPrev.ForeColor = $CLR_FG_DIM
        $lblPrev.Location  = New-Object System.Drawing.Point(28, 36)
        $lblPrev.Size      = New-Object System.Drawing.Size(390, 28)
        $card.Controls.Add($lblPrev)

        $yPos += 80
    }

    # Rechte Spalte: Log
    $logBox = New-Object System.Windows.Forms.RichTextBox
    $logBox.Location    = New-Object System.Drawing.Point(474, 108)
    $logBox.Size        = New-Object System.Drawing.Size(466, 512)
    $logBox.BackColor   = $CLR_WHITE
    $logBox.ForeColor   = $CLR_FG
    $logBox.Font        = $FNT_MONO
    $logBox.BorderStyle = "FixedSingle"
    $logBox.ReadOnly    = $true
    $logBox.ScrollBars  = "Vertical"
    $logBox.Text        = "Bereit.`nKategorien auswaehlen und auf 'Installieren' klicken.`n"
    $form.Controls.Add($logBox)

    # Fortschrittsbalken
    $progress = New-Object System.Windows.Forms.ProgressBar
    $progress.Location  = New-Object System.Drawing.Point(474, 628)
    $progress.Size      = New-Object System.Drawing.Size(466, 14)
    $progress.Style     = "Continuous"
    $form.Controls.Add($progress)

    $lblStatus = New-Object System.Windows.Forms.Label
    $lblStatus.Text      = ""
    $lblStatus.Font      = $FNT_SMALL
    $lblStatus.ForeColor = $CLR_FG_DIM
    $lblStatus.Location  = New-Object System.Drawing.Point(474, 646)
    $lblStatus.Size      = New-Object System.Drawing.Size(466, 18)
    $form.Controls.Add($lblStatus)

    # Trennlinie
    $sep = New-Object System.Windows.Forms.Panel
    $sep.Size      = New-Object System.Drawing.Size(1, 640)
    $sep.Location  = New-Object System.Drawing.Point(466, 72)
    $sep.BackColor = $CLR_BORDER
    $form.Controls.Add($sep)

    # Footer-Leiste
    $footer = New-Object System.Windows.Forms.Panel
    $footer.Size      = New-Object System.Drawing.Size(960, 54)
    $footer.Location  = New-Object System.Drawing.Point(0, 700)
    $footer.BackColor = [System.Drawing.Color]::FromArgb(235, 235, 235)
    $form.Controls.Add($footer)

    $sepFoot = New-Object System.Windows.Forms.Panel
    $sepFoot.Size      = New-Object System.Drawing.Size(960, 1)
    $sepFoot.Location  = New-Object System.Drawing.Point(0, 0)
    $sepFoot.BackColor = $CLR_BORDER
    $footer.Controls.Add($sepFoot)

    $btnAll     = New-Button "Alle auswaehlen"   16 10 148 34 $CLR_WHITE $CLR_FG
    $btnNone    = New-Button "Auswahl leeren"    172 10 148 34 $CLR_WHITE $CLR_FG
    $btnInstall = New-Button "Installieren"      776 10 164 34 $CLR_ACCENT $CLR_WHITE

    $btnAll.FlatAppearance.BorderSize    = 1
    $btnAll.FlatAppearance.BorderColor   = $CLR_BORDER
    $btnNone.FlatAppearance.BorderSize   = 1
    $btnNone.FlatAppearance.BorderColor  = $CLR_BORDER

    $footer.Controls.Add($btnAll)
    $footer.Controls.Add($btnNone)
    $footer.Controls.Add($btnInstall)

    # Events
    $btnAll.Add_Click({ foreach ($cb in $checkboxes.Values) { $cb.Checked = $true } })
    $btnNone.Add_Click({ foreach ($cb in $checkboxes.Values) { $cb.Checked = $false } })

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
            foreach ($pkg in $script:Categories[$k].Packages) { $allPkgs += $pkg }
        }

        $logBox.Clear()
        $progress.Value     = 0
        $btnInstall.Enabled = $false
        $btnInstall.Text    = "Laeuft..."

        Start-Installation -Packages $allPkgs -LogBox $logBox -ProgressBar $progress -StatusLabel $lblStatus

        $btnInstall.Enabled = $true
        $btnInstall.Text    = "Installieren"
    })

    $form.ShowDialog() | Out-Null
}
