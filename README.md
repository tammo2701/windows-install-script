<div align="center">

# Windows Install Script

**Kategorienbasierte Programm-Installation via winget — ein Befehl, fertig.**

[![Stars](https://img.shields.io/github/stars/tammo2701/windows-install-script?style=for-the-badge&logo=github&color=238636&labelColor=161b22)](https://github.com/tammo2701/windows-install-script/stargazers)
[![Forks](https://img.shields.io/github/forks/tammo2701/windows-install-script?style=for-the-badge&logo=github&color=1f6feb&labelColor=161b22)](https://github.com/tammo2701/windows-install-script/forks)
[![Issues](https://img.shields.io/github/issues/tammo2701/windows-install-script?style=for-the-badge&logo=github&color=da3633&labelColor=161b22)](https://github.com/tammo2701/windows-install-script/issues)
[![PowerShell](https://img.shields.io/badge/PowerShell-5.1+-5391FE?style=for-the-badge&logo=powershell&logoColor=white&labelColor=161b22)](https://github.com/PowerShell/PowerShell)
[![winget](https://img.shields.io/badge/winget-required-0078D4?style=for-the-badge&logo=windows&logoColor=white&labelColor=161b22)](https://aka.ms/winget)
[![Views](https://img.shields.io/badge/dynamic/json?url=https%3A%2F%2Fraw.githubusercontent.com%2Ftammo2701%2Fwindows-install-script%2Fmain%2Fdownloads.json&query=views_14d&label=Views+%2814d%29&style=for-the-badge&color=6e40c9&labelColor=161b22)](https://github.com/tammo2701/windows-install-script)

</div>

---

## Quickstart

PowerShell oeffnen und ausfuehren — Admin-Rechte werden automatisch angefragt:

```powershell
irm https://raw.githubusercontent.com/tammo2701/windows-install-script/main/setup.ps1 | iex
```

> Falls Skriptausfuehrung blockiert:
> ```powershell
> Set-ExecutionPolicy Bypass -Scope Process
> ```

---

## GUI

Nach dem Ausfuehren oeffnet sich ein grafisches Fenster:

- Kategorien per Checkbox auswaehlen
- Mehrere Kategorien gleichzeitig moeglich
- Live-Log mit Farb-Statusanzeige
- Fortschrittsbalken waehrend der Installation
- Admin-Rechte werden automatisch per UAC angefragt

---

## Kategorien

| Kategorie | Programme |
|-----------|-----------|
| Gaming | Steam, Epic Games, GOG Galaxy, Playnite, Discord |
| Coding | VS Code, Git, Python 3, Node.js, PowerShell 7, Windows Terminal, Firefox, GitHub CLI, Postman |
| Media | VLC, Spotify, OBS Studio, HandBrake, Audacity |
| Tools | 7-Zip, Notepad++, Everything, ShareX, CPU-Z, HWiNFO, WinDirStat |
| Communication | WhatsApp, Signal, Telegram, TeamSpeak 3, Zoom, Discord |
| Server | Docker Desktop, Jellyfin, qBittorrent, WireGuard, HeidiSQL, FileZilla, Tailscale |

---

## Repo-Struktur

```
windows-install-script/
├── setup.ps1                        # Einstiegspunkt: Auto-Elevation + Modulloader
├── modules/
│   ├── ui.ps1                       # WinForms GUI
│   ├── packages.ps1                 # Kategorien und Paket-IDs
│   └── install.ps1                  # Installations-Logik
├── .github/workflows/
│   └── count-downloads.yml          # Automatischer View-Zaehler
├── downloads.json                   # Aktueller View-Zaehler (auto-updated)
└── README.md
```

---

## Pakete anpassen

`modules/packages.ps1` oeffnen und Eintraege hinzufuegen:

```powershell
# Winget-Paket
@{ Name = "Programmname"; Id = "Winget.ID"; Source = "winget" }

# Microsoft Store App
@{ Name = "WhatsApp"; Id = "9NKSQGP7F2NH"; Source = "msstore" }
```

Winget-ID finden:
```powershell
winget search <programmname>
```

---

## Anforderungen

- Windows 10 / 11
- PowerShell 5.1+
- [App Installer (winget)](https://aka.ms/winget)

---

<div align="center">

Befehlsreferenz und Details im **[Wiki](../../wiki)**

</div>
