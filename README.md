# Windows Setup

Automatische Programm-Installation via winget – kategorienbasiert, direkt aus der Kommandozeile ausführbar.

## Quickstart

PowerShell als **Administrator** öffnen, dann:

```powershell
irm https://raw.githubusercontent.com/USERNAME/windows-setup/main/setup.ps1 | iex
```

> Falls Skriptausführung blockiert ist, einmalig vorab ausführen:
> ```powershell
> Set-ExecutionPolicy Bypass -Scope Process
> ```

---

## Kategorien

| # | Kategorie | Beispiele |
|---|-----------|-----------|
| 1 | 🎮 Gaming | Steam, Epic Games, GOG, Playnite, Discord |
| 2 | 💻 Coding | VS Code, Git, Python, Node.js, Firefox, Postman |
| 3 | 🎬 Media | VLC, Spotify, OBS, HandBrake, Audacity |
| 4 | 🛠️ Tools | 7-Zip, Notepad++, Everything, ShareX, HWiNFO |
| 5 | 💬 Communication | Signal, Telegram, TeamSpeak, Zoom |
| 6 | 🖥️ Server | Docker Desktop, Jellyfin, qBittorrent, WireGuard |

**Mehrfachauswahl:** Nummern mit Leerzeichen trennen, z.B. `2 4 6`  
**Alles:** `all` eingeben

---

## Repo-Struktur

```
windows-setup/
├── setup.ps1          # Einstiegspunkt (Bootstrap + Modulloader)
├── modules/
│   ├── ui.ps1         # Banner, Menü, farbige Ausgabe
│   ├── packages.ps1   # Alle Kategorien und Paket-IDs
│   └── install.ps1    # Installations-Logik und Zusammenfassung
└── README.md
```

---

## Pakete anpassen

In `modules/packages.ps1` neue Pakete einfügen:

```powershell
@{ Name = "Programmname"; Id = "Winget.ID" }
```

Winget-ID herausfinden:
```powershell
winget search <programmname>
```

Detaillierte Befehlsreferenz → **[GitHub Wiki](../../wiki)**
