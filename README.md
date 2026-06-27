# clip-studio-thumbnailer

Nautilus thumbnail previews for Clip Studio Paint `.clip` files on Linux.  (Nautilus is the default file manager for Linux, similar to Windows Explorer)

## Why

Although Clip Studio Paint is not supported on Linux, If you use a Linux OS as your main system and want to organize your Clip Studio .clip files or backups, this shows you an image preview in the Nautilus GUI.

## How it works

`.clip` files are a proprietary chunked binary format (`CSFCHUNK`) that embeds a SQLite database. That database has a `CanvasPreview` table with the canvas image as a PNG blob. The thumbnailer extracts the SQLite chunk, queries the image, and resizes it with ffmpeg (ImageMagick rejects these PNGs due to non-standard filter bytes).

## Requirements

- Linux with GNOME / Nautilus
- `python3`, `sqlite3`, `ffmpeg` — must be in `/usr/bin/` (required by the gnome-desktop sandbox)

Works on any major Linux distro that ships GNOME as default: Ubuntu, Fedora, Arch, Manjaro, Pop!\_OS, openSUSE, and others. Tested on **CachyOS**.

**Does not work on KDE/Dolphin** — Dolphin uses a different thumbnailer plugin system. **Does not work on XFCE/Thunar** without additional setup.

## Install

```bash
bash install.sh
```

## Uninstall

```bash
bash install.sh uninstall
```
