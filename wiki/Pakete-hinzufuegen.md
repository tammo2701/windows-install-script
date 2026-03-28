# Pakete hinzufuegen

So erweiterst du das Script um eigene Programme.

---

## Winget-ID finden

```powershell
winget search <programmname>
```

Beispiel:
```
winget search vlc
```

Ausgabe:
```
Name   Id              Version  Quelle
------ --------------- -------- ------
VLC    VideoLAN.VLC    3.0.21   winget
```

Die Spalte **Id** ist der Wert den du benoenigst.

---

## Paket zu einer Kategorie hinzufuegen

Datei `modules/packages.ps1` oeffnen und in der gewuenschten Kategorie einen neuen Eintrag hinzufuegen:

```powershell
Coding = @{
    ...
    Packages = @(
        @{ Name = "Visual Studio Code"; Id = "Microsoft.VisualStudioCode"; Source = "winget" }
        @{ Name = "Mein neues Tool";    Id = "Hersteller.ProgrammID";      Source = "winget" }  # <-- neu
    )
}
```

---

## Microsoft Store Apps

Manche Apps sind nur ueber den Microsoft Store verfuegbar (z.B. WhatsApp). Hier ist die ID eine 12-stellige Store-ID, nicht ein lesbarer Name:

```powershell
@{ Name = "WhatsApp"; Id = "9NKSQGP7F2NH"; Source = "msstore" }
```

Store-ID finden: Im Microsoft Store die App-Seite oeffnen, die ID steht in der URL:
```
https://apps.microsoft.com/detail/9NKSQGP7F2NH
```

---

## Neue Kategorie anlegen

In `modules/packages.ps1` einen neuen Block hinzufuegen:

```powershell
MeineKategorie = @{
    Order   = 7                                  # Reihenfolge im Menue
    Label   = "Meine Kategorie"
    Preview = "Prog1, Prog2, Prog3"             # Kurzvorschau
    Packages = @(
        @{ Name = "Programm 1"; Id = "Hersteller.Prog1"; Source = "winget" }
        @{ Name = "Programm 2"; Id = "Hersteller.Prog2"; Source = "winget" }
    )
}
```

---

## Paket testen

Vor dem Hinzufuegen pruefen ob die ID korrekt ist:

```powershell
winget install --id Microsoft.VisualStudioCode --silent --accept-package-agreements --accept-source-agreements
```
