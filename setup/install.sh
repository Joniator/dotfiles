#!/usr/bin/env bash
set -euo pipefail

SETUP_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

. /etc/os-release
. "$SETUP_DIR/lib/utils.sh"

case "$ID" in
    ubuntu)  . "$SETUP_DIR/lib/ubuntu.sh" ;;
    cachyos) . "$SETUP_DIR/lib/cachyos.sh" ;;
    *)
        echo "Unsupported OS: $ID" >&2
        exit 1
        ;;
esac

chezmoi init --apply https://codeberg.org/JonnyB/dotfiles.git
