# Befehlsreferenz

Erklaerung aller PowerShell-Befehle die im Script haeufig vorkommen.

---

## `Invoke-RestMethod` (irm)

```powershell
irm https://raw.githubusercontent.com/...
```

Laedt den Inhalt einer URL herunter und gibt ihn als Objekt zurueck. Wird hier genutzt um das Script direkt aus GitHub zu laden.

---

## `Invoke-Expression` (iex)

```powershell
... | iex
```

Fuehrt einen String als PowerShell-Code aus. In Kombination mit `irm` wird das heruntergeladene Script direkt ausgefuehrt ohne es auf der Festplatte zu speichern.

---

## `Invoke-WebRequest`

```powershell
Invoke-WebRequest -Uri $url -UseBasicParsing
```

Laedt eine URL herunter. `-UseBasicParsing` verhindert dass der Internet Explorer fuer die Verarbeitung benoetigt wird (wichtig auf Server-Systemen ohne GUI).

---

## `[System.IO.File]::WriteAllText`

```powershell
[System.IO.File]::WriteAllText($pfad, $inhalt, [System.Text.Encoding]::UTF8)
```

Schreibt Text mit explizitem UTF-8-Encoding in eine Datei. Wichtig damit Umlaute und Sonderzeichen korrekt gespeichert werden.

---

## `New-Item`

```powershell
New-Item -ItemType Directory -Force -Path $pfad
```

Erstellt ein Verzeichnis. `-Force` verhindert einen Fehler wenn das Verzeichnis bereits existiert.

---

## `Join-Path`

```powershell
Join-Path $env:TEMP "windows-install-script"
```

Verbindet Pfade betriebssystemunabhaengig mit dem richtigen Trennzeichen (`\` unter Windows).

---

## `Get-Command`

```powershell
Get-Command winget -ErrorAction SilentlyContinue
```

Prueft ob ein Programm/Cmdlet verfuegbar ist. `-ErrorAction SilentlyContinue` verhindert eine Fehlermeldung wenn das Programm nicht gefunden wird.

---

## `Start-Process`

```powershell
Start-Process powershell.exe -Verb RunAs -WindowStyle Hidden -ArgumentList "..."
```

Startet einen neuen Prozess. `-Verb RunAs` loest den UAC-Prompt fuer Administrator-Rechte aus. `-WindowStyle Hidden` verhindert dass ein sichtbares Fenster geoeffnet wird.

---

## `ForEach-Object`

```powershell
$liste | ForEach-Object { $_.Key }
```

Iteriert ueber jedes Element einer Pipeline. `$_` repraesentiert das aktuelle Element.

---

## `Write-Host`

```powershell
Write-Host "Text" -ForegroundColor Green
```

Gibt Text in der Konsole aus. `-ForegroundColor` setzt die Textfarbe. Wird im Script fuer Status-Meldungen im Terminal verwendet.

---

## `$LASTEXITCODE`

```powershell
winget install ...
$ec = $LASTEXITCODE
```

Enthaelt den Exit-Code des zuletzt ausgefuehrten externen Programms. Bei winget bedeutet `0` Erfolg, `-1978335189` dass das Programm bereits installiert ist.

---

## `[Security.Principal.WindowsPrincipal]`

```powershell
([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(
    [Security.Principal.WindowsBuiltInRole]::Administrator
)
```

Prueft ob das aktuelle Script mit Administrator-Rechten ausgefuehrt wird. Gibt `$true` oder `$false` zurueck.

---

## `Add-Type`

```powershell
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing
```

Laedt .NET-Assemblies in die aktuelle PowerShell-Session. Notwendig um WinForms-GUI-Elemente verwenden zu koennen.

---

## `[System.Windows.Forms.Application]::EnableVisualStyles()`

Aktiviert moderne visuelle Stile fuer WinForms-Elemente (abgerundete Buttons, Themes etc.). Muss vor dem Erstellen von Fenstern aufgerufen werden.

---

## `$form.ShowDialog()`

```powershell
$form.ShowDialog() | Out-Null
```

Oeffnet das GUI-Fenster als modalen Dialog und blockiert die PowerShell bis das Fenster geschlossen wird. `| Out-Null` verwirft den Rueckgabewert (DialogResult).

---

## `[System.Windows.Forms.Application]::DoEvents()`

Verarbeitet ausstehende Windows-Ereignisse (z.B. UI-Neuzeichnung). Wichtig damit die GUI waehrend langer Operationen (Installation) nicht einfriert.
