# Quickstart

## Voraussetzungen

- Windows 10 oder Windows 11
- PowerShell 5.1 oder neuer (standardmaessig vorhanden)
- [winget (App Installer)](https://aka.ms/winget) aus dem Microsoft Store

---

## Ausfuehren

PowerShell oeffnen (normal oder als Admin) und eingeben:

```powershell
irm https://raw.githubusercontent.com/tammo2701/windows-install-script/main/setup.ps1 | iex
```

Das Script:
1. Fragt automatisch nach Admin-Rechten per UAC (falls noetig)
2. Laedt die Module aus GitHub herunter
3. Oeffnet das GUI-Fenster

---

## Bedienung

1. Kategorien per Checkbox auswaehlen (Mehrfachauswahl moeglich)
2. **"Installieren"** klicken
3. Im Log-Bereich den Fortschritt verfolgen
4. Nach Abschluss: Zusammenfassung erscheint im Log

**Alle auswaehlen** — alle Kategorien auf einmal markieren  
**Auswahl leeren** — alle Haekchen entfernen

---

## Lokale Ausfuehrung (ohne irm)

Repo klonen und direkt starten:

```powershell
git clone https://github.com/tammo2701/windows-install-script.git
cd windows-install-script
.\setup.ps1
```
