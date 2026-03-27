<div align="center">

# Windows Install Script

**Kategorienbasierte Programm-Installation via winget — direkt aus der PowerShell**

[![Stars](https://img.shields.io/github/stars/tammo2701/windows-install-script?style=for-the-badge&color=6366f1&labelColor=0d0d14)](https://github.com/tammo2701/windows-install-script/stargazers)
[![Forks](https://img.shields.io/github/forks/tammo2701/windows-install-script?style=for-the-badge&color=6366f1&labelColor=0d0d14)](https://github.com/tammo2701/windows-install-script/forks)
[![Issues](https://img.shields.io/github/issues/tammo2701/windows-install-script?style=for-the-badge&color=6366f1&labelColor=0d0d14)](https://github.com/tammo2701/windows-install-script/issues)
[![License](https://img.shields.io/github/license/tammo2701/windows-install-script?style=for-the-badge&color=6366f1&labelColor=0d0d14)](LICENSE)
[![PowerShell](https://img.shields.io/badge/PowerShell-5.1+-5391FE?style=for-the-badge&logo=powershell&logoColor=white&labelColor=0d0d14)](https://github.com/PowerShell/PowerShell)
[![winget](https://img.shields.io/badge/winget-required-0078D4?style=for-the-badge&logo=windows&logoColor=white&labelColor=0d0d14)](https://aka.ms/winget)

</div>

---

## Quickstart

PowerShell als **Administrator** oeffnen — oder einfach ausfuehren, das Script fragt selbst nach Admin-Rechten:

```powershell
irm https://raw.githubusercontent.com/tammo2701/windows-install-script/main/setup.ps1 | iex
```

> Falls Skriptausfuehrung blockiert ist:
> ```powershell
> Set-ExecutionPolicy Bypass -Scope Process
> ```

---

## GUI

Das Script startet automatisch ein grafisches Fenster, in dem Kategorien per Checkbox ausgewaehlt werden koennen.

- Einzelne Kategorien oder alles auf einmal auswaehlen
- Live-Log und Fortschrittsbalken waehrend der Installation
- Automatische UAC-Anfrage wenn nicht als Admin gestartet

---

## Kategorien

| Kategorie | Enthaltene Programme |
|-----------|----------------------|
| Gaming | Steam, Epic Games, GOG Galaxy, Playnite, Discord |
| Coding | VS Code, Git, Python 3, Node.js, PowerShell 7, Firefox, GitHub CLI, Postman |
| Media | VLC, Spotify, OBS Studio, HandBrake, Audacity |
| Tools | 7-Zip, Notepad++, Everything, ShareX, CPU-Z, HWiNFO, WinDirStat |
| Communication | WhatsApp, Signal, Telegram, TeamSpeak 3, Zoom, Discord |
| Server | Docker Desktop, Jellyfin, qBittorrent, WireGuard, HeidiSQL, FileZilla, Tailscale |

---

## Repo-Struktur

```
windows-install-script/
├── setup.ps1          # Einstiegspunkt: Auto-Elevation + Modulloader
├── modules/
│   ├── ui.ps1         # WinForms GUI (Fenster, Checkboxen, Log)
│   ├── packages.ps1   # Alle Kategorien und Paket-IDs
│   └── install.ps1    # Installations-Logik und Exit-Code-Behandlung
└── README.md
```

---

## Pakete anpassen

In `modules/packages.ps1` neue Pakete hinzufuegen:

```powershell
@{ Name = "Programmname"; Id = "Winget.ID"; Source = "winget" }
```

Fuer Microsoft Store Apps:

```powershell
@{ Name = "WhatsApp"; Id = "9NKSQGP7F2NH"; Source = "msstore" }
```

Winget-ID herausfinden:

```powershell
winget search <programmname>
```

---

## Anforderungen

- Windows 10 / 11
- PowerShell 5.1 oder neuer
- [App Installer (winget)](https://aka.ms/winget) aus dem Microsoft Store

---

<div align="center">

Detaillierte Dokumentation im **[Wiki](../../wiki)**

</div>
