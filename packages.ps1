# modules/packages.ps1
# Alle Kategorien mit Paketen und Winget-IDs

$script:Categories = [ordered]@{

    Gaming = @{
        Order   = 1
        Icon    = "🎮"
        Label   = "Gaming"
        Preview = "Steam, Epic Games, GOG, Playnite"
        Packages = @(
            @{ Name = "Steam";                  Id = "Valve.Steam"                         }
            @{ Name = "Epic Games Launcher";    Id = "EpicGames.EpicGamesLauncher"         }
            @{ Name = "GOG Galaxy";             Id = "GOG.Galaxy"                          }
            @{ Name = "Playnite";               Id = "Playnite.Playnite"                   }
            @{ Name = "Discord";                Id = "Discord.Discord"                     }
        )
    }

    Coding = @{
        Order   = 2
        Icon    = "💻"
        Label   = "Coding"
        Preview = "VS Code, Git, Python, Node.js, Firefox"
        Packages = @(
            @{ Name = "Visual Studio Code";     Id = "Microsoft.VisualStudioCode"          }
            @{ Name = "Git";                    Id = "Git.Git"                             }
            @{ Name = "Python 3";               Id = "Python.Python.3.13"                  }
            @{ Name = "Node.js LTS";            Id = "OpenJS.NodeJS.LTS"                   }
            @{ Name = "PowerShell 7";           Id = "Microsoft.PowerShell"               }
            @{ Name = "Windows Terminal";       Id = "Microsoft.WindowsTerminal"           }
            @{ Name = "Firefox";                Id = "Mozilla.Firefox"                    }
            @{ Name = "GitHub CLI";             Id = "GitHub.cli"                          }
            @{ Name = "Postman";                Id = "Postman.Postman"                     }
        )
    }

    Media = @{
        Order   = 3
        Icon    = "🎬"
        Label   = "Media"
        Preview = "VLC, Spotify, HandBrake, Audacity"
        Packages = @(
            @{ Name = "VLC";                    Id = "VideoLAN.VLC"                        }
            @{ Name = "Spotify";                Id = "Spotify.Spotify"                    }
            @{ Name = "HandBrake";              Id = "HandBrake.HandBrake"                }
            @{ Name = "Audacity";               Id = "Audacity.Audacity"                  }
            @{ Name = "MPC-HC";                 Id = "clsid2.mpc-hc"                      }
            @{ Name = "OBS Studio";             Id = "OBSProject.OBSStudio"               }
        )
    }

    Tools = @{
        Order   = 4
        Icon    = "🛠️"
        Label   = "Tools & Utilities"
        Preview = "7-Zip, Notepad++, Everything, ShareX"
        Packages = @(
            @{ Name = "7-Zip";                  Id = "7zip.7zip"                           }
            @{ Name = "Notepad++";              Id = "Notepad++.Notepad++"                }
            @{ Name = "Everything";             Id = "voidtools.Everything"               }
            @{ Name = "ShareX";                 Id = "ShareX.ShareX"                      }
            @{ Name = "CPU-Z";                  Id = "CPUID.CPU-Z"                        }
            @{ Name = "HWiNFO";                 Id = "REALiX.HWiNFO"                      }
            @{ Name = "WinDirStat";             Id = "WinDirStat.WinDirStat"              }
            @{ Name = "Bulk Rename Utility";    Id = "TGRMNSoftware.BulkRenameUtility"    }
        )
    }

    Communication = @{
        Order   = 5
        Icon    = "💬"
        Label   = "Communication"
        Preview = "Signal, Telegram, TeamSpeak, Zoom"
        Packages = @(
            @{ Name = "Signal";                 Id = "OpenWhisperSystems.Signal"           }
            @{ Name = "Telegram";               Id = "Telegram.TelegramDesktop"           }
            @{ Name = "TeamSpeak 3";            Id = "TeamSpeakSystems.TeamSpeakClient"   }
            @{ Name = "Zoom";                   Id = "Zoom.Zoom"                          }
            @{ Name = "Discord";                Id = "Discord.Discord"                    }
        )
    }

    Server = @{
        Order   = 6
        Icon    = "🖥️"
        Label   = "Server"
        Preview = "Docker Desktop, Jellyfin, qBittorrent, WireGuard"
        Packages = @(
            @{ Name = "Docker Desktop";         Id = "Docker.DockerDesktop"               }
            @{ Name = "Jellyfin Server";        Id = "Jellyfin.Jellyfin"                  }
            @{ Name = "qBittorrent";            Id = "qBittorrent.qBittorrent"            }
            @{ Name = "WireGuard";              Id = "WireGuard.WireGuard"                }
            @{ Name = "HeidiSQL";               Id = "HeidiSQL.HeidiSQL"                  }
            @{ Name = "FileZilla";              Id = "TimKosse.FileZilla.Client"           }
            @{ Name = "Tailscale";              Id = "Tailscale.Tailscale"                }
            @{ Name = "Insomnia";               Id = "Insomnia.Insomnia"                  }
        )
    }
}
