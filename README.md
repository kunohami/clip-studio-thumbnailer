# clip-studio-thumbnailer

![Platform](https://img.shields.io/badge/platform-Linux-blue?logo=linux&logoColor=white)
![File Manager](https://img.shields.io/badge/file%20manager-Nautilus%20%2F%20GNOME-4A90D9?logo=gnome&logoColor=white)
![Language](https://img.shields.io/badge/language-Python-3776AB?logo=python&logoColor=white)
![Tested on](https://img.shields.io/badge/tested%20on-CachyOS-blue)

Nautilus thumbnail previews for Clip Studio Paint `.clip` files on Linux. (Nautilus is the default file manager for GNOME Linux, similar to Windows Explorer)

## Why

Although Clip Studio Paint is not supported on Linux, if you use a Linux OS as your main system and want to organize your Clip Studio `.clip` files or backups, this shows you an image preview in the Nautilus file manager.

## How it works

`.clip` files are a proprietary chunked binary format (`CSFCHUNK`) that embeds a SQLite database. That database has a `CanvasPreview` table with the canvas image as a PNG blob. The thumbnailer extracts the SQLite chunk, queries the image, and resizes it with ffmpeg (ImageMagick rejects these PNGs due to non-standard filter bytes).

## Requirements

- Linux with GNOME / Nautilus
- `python3`, `sqlite3`, `ffmpeg` — must be in `/usr/bin/` (required by the gnome-desktop sandbox)

Works on any major Linux distro that ships GNOME as default: Ubuntu, Fedora, Arch, Manjaro, Pop!\_OS, openSUSE, and others. Tested on **CachyOS**.

**Does not work on KDE/Dolphin** — Dolphin uses a different thumbnailer plugin system. **Does not work on XFCE/Thunar** without additional setup.

## Install

### 1. Install dependencies

Make sure `python3`, `sqlite3`, and `ffmpeg` are installed. On most distros they are already present, but if not:

**Ubuntu / Debian / Pop!\_OS:**
```bash
sudo apt install python3 sqlite3 ffmpeg
```

**Fedora:**
```bash
sudo dnf install python3 sqlite ffmpeg
```

**Arch / CachyOS / Manjaro:**
```bash
sudo pacman -S python sqlite ffmpeg
```

### 2. Clone the repo and run the installer

```bash
git clone https://github.com/kunohami/clip-studio-thumbnailer.git
cd clip-studio-thumbnailer
bash install.sh
```

The installer will ask for your password once to copy files to system directories. After it finishes, open Nautilus and browse to your `.clip` files — previews will generate as you view them.

## Uninstall

```bash
bash install.sh uninstall
```
