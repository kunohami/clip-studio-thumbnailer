#!/usr/bin/env bash
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

check_deps() {
    local missing=()
    for cmd in python3 sqlite3 ffmpeg; do
        command -v "$cmd" &>/dev/null || missing+=("$cmd")
    done
    if [[ ${#missing[@]} -gt 0 ]]; then
        echo "Missing dependencies: ${missing[*]}"
        echo "Install them and try again."
        exit 1
    fi
}

uninstall() {
    echo "Uninstalling clip-studio-thumbnailer..."
    sudo rm -f /usr/bin/clip-thumbnailer
    sudo rm -f /usr/share/thumbnailers/clip-studio.thumbnailer
    sudo rm -f /usr/share/mime/packages/clip-studio.xml
    sudo update-mime-database /usr/share/mime
    rm -rf ~/.cache/thumbnails
    echo "Done."
}

install() {
    echo "Checking dependencies..."
    check_deps

    echo "Installing files..."
    sudo install -m 755 "$SCRIPT_DIR/clip-thumbnailer" /usr/bin/clip-thumbnailer
    sudo install -m 644 "$SCRIPT_DIR/clip-studio.thumbnailer" /usr/share/thumbnailers/clip-studio.thumbnailer
    sudo install -m 644 "$SCRIPT_DIR/clip-studio.xml" /usr/share/mime/packages/clip-studio.xml
    sudo update-mime-database /usr/share/mime

    # Also install the user-level thumbnailer so gnome-desktop picks it up
    # (it searches ~/.local/share/thumbnailers/ before /usr/share/thumbnailers/)
    mkdir -p ~/.local/share/thumbnailers
    cp "$SCRIPT_DIR/clip-studio.thumbnailer" ~/.local/share/thumbnailers/clip-studio.thumbnailer

    rm -rf ~/.cache/thumbnails

    echo "Done. Open Nautilus and browse to your .clip files to generate previews."
}

case "${1:-}" in
    uninstall) uninstall ;;
    *) install ;;
esac
