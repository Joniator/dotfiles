#!/usr/bin/env bash
set -euo pipefail

BASE_URL="https://codeberg.org/JonnyB/dotfiles/raw/branch/main/setup"

# Resolve the lib directory. When run from a local file the lib/ sibling dir is
# used directly, so edits are picked up immediately without committing. When
# piped through bash (curl | bash) there is no local file, so each lib script
# is fetched from the remote URL instead.
_SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]:-}")" 2>/dev/null && pwd || true)"
_LIB_DIR="$_SCRIPT_DIR/lib"

source_lib() {
    local name="$1"
    if [[ -f "$_LIB_DIR/$name" ]]; then
        . "$_LIB_DIR/$name"
    else
        . <(curl -fsSL "$BASE_URL/lib/$name")
    fi
}

. /etc/os-release
source_lib utils.sh

case "$ID" in
    ubuntu)       source_lib ubuntu.sh ;;
    cachyos|arch) source_lib cachyos.sh ;;
    *)
        echo "Unsupported OS: $ID" >&2
        exit 1
        ;;
esac

chezmoi init --apply https://codeberg.org/JonnyB/dotfiles.git
