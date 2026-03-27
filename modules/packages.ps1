# modules/packages.ps1
# Alle Kategorien mit Paketen und Winget-IDs

$script:Categories = [ordered]@{

    Gaming = @{
        Order   = 1
        Label   = "Gaming"
        Preview = "Steam, Epic Games, GOG, Playnite"
        Packages = @(
            @{ Name = "Steam";               Id = "Valve.Steam";                    Source = "winget" }
            @{ Name = "Epic Games Launcher"; Id = "EpicGames.EpicGamesLauncher";    Source = "winget" }
            @{ Name = "GOG Galaxy";          Id = "GOG.Galaxy";                     Source = "winget" }
            @{ Name = "Playnite";            Id = "Playnite.Playnite";              Source = "winget" }
            @{ Name = "Discord";             Id = "Discord.Discord";                Source = "winget" }
        )
    }

    Coding = @{
        Order   = 2
        Label   = "Coding"
        Preview = "VS Code, Git, Python, Node.js, Firefox"
        Packages = @(
            @{ Name = "Visual Studio Code";  Id = "Microsoft.VisualStudioCode";     Source = "winget" }
            @{ Name = "Git";                 Id = "Git.Git";                        Source = "winget" }
            @{ Name = "Python 3";            Id = "Python.Python.3.13";             Source = "winget" }
            @{ Name = "Node.js LTS";         Id = "OpenJS.NodeJS.LTS";              Source = "winget" }
            @{ Name = "PowerShell 7";        Id = "Microsoft.PowerShell";           Source = "winget" }
            @{ Name = "Windows Terminal";    Id = "Microsoft.WindowsTerminal";      Source = "winget" }
            @{ Name = "Firefox";             Id = "Mozilla.Firefox";                Source = "winget" }
            @{ Name = "GitHub CLI";          Id = "GitHub.cli";                     Source = "winget" }
            @{ Name = "Postman";             Id = "Postman.Postman";                Source = "winget" }
        )
    }

    Media = @{
        Order   = 3
        Label   = "Media"
        Preview = "VLC, Spotify, OBS, HandBrake"
        Packages = @(
            @{ Name = "VLC";                 Id = "VideoLAN.VLC";                   Source = "winget" }
            @{ Name = "Spotify";             Id = "Spotify.Spotify";                Source = "winget" }
            @{ Name = "HandBrake";           Id = "HandBrake.HandBrake";            Source = "winget" }
            @{ Name = "Audacity";            Id = "Audacity.Audacity";              Source = "winget" }
            @{ Name = "OBS Studio";          Id = "OBSProject.OBSStudio";           Source = "winget" }
        )
    }

    Tools = @{
        Order   = 4
        Label   = "Tools & Utilities"
        Preview = "7-Zip, Notepad++, Everything, ShareX"
        Packages = @(
            @{ Name = "7-Zip";               Id = "7zip.7zip";                      Source = "winget" }
            @{ Name = "Notepad++";           Id = "Notepad++.Notepad++";            Source = "winget" }
            @{ Name = "Everything";          Id = "voidtools.Everything";           Source = "winget" }
            @{ Name = "ShareX";              Id = "ShareX.ShareX";                  Source = "winget" }
            @{ Name = "CPU-Z";               Id = "CPUID.CPU-Z";                    Source = "winget" }
            @{ Name = "HWiNFO";              Id = "REALiX.HWiNFO";                 Source = "winget" }
            @{ Name = "WinDirStat";          Id = "WinDirStat.WinDirStat";          Source = "winget" }
        )
    }

    Communication = @{
        Order   = 5
        Label   = "Communication"
        Preview = "WhatsApp, Signal, Telegram, TeamSpeak"
        Packages = @(
            @{ Name = "WhatsApp";            Id = "9NKSQGP7F2NH";                   Source = "msstore" }
            @{ Name = "Signal";              Id = "OpenWhisperSystems.Signal";      Source = "winget" }
            @{ Name = "Telegram";            Id = "Telegram.TelegramDesktop";       Source = "winget" }
            @{ Name = "TeamSpeak 3";         Id = "TeamSpeakSystems.TeamSpeakClient"; Source = "winget" }
            @{ Name = "Zoom";                Id = "Zoom.Zoom";                      Source = "winget" }
            @{ Name = "Discord";             Id = "Discord.Discord";                Source = "winget" }
        )
    }

    Server = @{
        Order   = 6
        Label   = "Server"
        Preview = "Docker Desktop, Jellyfin, qBittorrent, WireGuard"
        Packages = @(
            @{ Name = "Docker Desktop";      Id = "Docker.DockerDesktop";           Source = "winget" }
            @{ Name = "Jellyfin Server";     Id = "Jellyfin.Jellyfin";              Source = "winget" }
            @{ Name = "qBittorrent";         Id = "qBittorrent.qBittorrent";        Source = "winget" }
            @{ Name = "WireGuard";           Id = "WireGuard.WireGuard";            Source = "winget" }
            @{ Name = "HeidiSQL";            Id = "HeidiSQL.HeidiSQL";              Source = "winget" }
            @{ Name = "FileZilla";           Id = "TimKosse.FileZilla.Client";      Source = "winget" }
            @{ Name = "Tailscale";           Id = "Tailscale.Tailscale";            Source = "winget" }
        )
    }
}
