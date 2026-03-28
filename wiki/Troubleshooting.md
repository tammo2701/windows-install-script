# Troubleshooting

Haeufige Probleme und deren Loesungen.

---

## "winget wird nicht erkannt"

winget ist nicht installiert. Loesung: **App Installer** aus dem Microsoft Store installieren:

```
https://aka.ms/winget
```

---

## "Skriptausfuehrung ist deaktiviert"

```
Die Datei kann nicht geladen werden, da die Ausfuehrung von Skripts auf diesem System deaktiviert ist.
```

Loesung — nur fuer die aktuelle Sitzung:

```powershell
Set-ExecutionPolicy Bypass -Scope Process
```

---

## GUI oeffnet sich nicht / schliesst sich sofort

1. PowerShell als Administrator starten
2. Script direkt aus dem Repo-Ordner testen statt via `irm`:

```powershell
cd C:\Users\...\windows-install-script
.\debug.ps1
```

Der Debug-Output zeigt die genaue Fehlerzeile.

---

## Paket schlaegt fehl

Wenn ein einzelnes Paket fehlschlaegt, das andere nicht beeintraechtigt, erscheint es rot im Log. Manuell pruefen:

```powershell
winget search <programmname>
winget install --id <ID> --source winget
```

---

## WhatsApp / Store-Apps schlagen fehl

Microsoft Store muss eingerichtet sein und du musst mit einem Microsoft-Konto angemeldet sein. Store-Apps koennen nicht im Silent-Modus ohne Store-Account installiert werden.

---

## "Der Wert kann nicht in System.Drawing.Color konvertiert werden"

Tritt auf wenn das Script mit alter PowerShell-Version (< 5.1) ausgefuehrt wird. Loesung: PowerShell-Version pruefen:

```powershell
$PSVersionTable.PSVersion
```

Mindestens `5.1` benoetigt. Empfohlen: PowerShell 7 installieren.

---

## Encoding-Fehler (Fragezeichen statt Umlaute)

Das Script speichert Module explizit in UTF-8. Falls dennoch Probleme auftreten: Temp-Cache loeschen und neu starten:

```powershell
Remove-Item -Recurse -Force "$env:TEMP\windows-install-script"
```
