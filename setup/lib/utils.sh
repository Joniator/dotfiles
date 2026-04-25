# Common utilities — sourced by distro scripts, not executed directly.

export PATH="$HOME/.local/bin:$PATH"
mkdir -p "$HOME/.local/bin"

# $EUID is the *effective* user ID — the actual privileges in use right now.
# This differs from $UID when su/setuid is involved, and requires no subprocess
# unlike `whoami`. It is the correct check for "can I write to system paths?".
if [[ $EUID -eq 0 ]]; then
    # Ensure sudo exists for third-party install scripts that call it internally.
    if ! command -v sudo &>/dev/null; then
        apt-get install -y sudo 2>/dev/null || pacman -S --noconfirm sudo 2>/dev/null || true
    fi
    SUDO=""
elif command -v sudo &>/dev/null; then
    SUDO="sudo"
else
    echo "Error: not root and sudo is not installed. Re-run as root." >&2
    exit 1
fi

ARCH=$(uname -m)
# GitHub releases use Go-style arch names (amd64/arm64) for some tools.
GOARCH=$([[ "$ARCH" == "x86_64" ]] && echo "amd64" || echo "arm64")

# Install a binary from a GitHub release tar.gz into ~/.local/bin.
# Handles arbitrary directory depth inside the archive.
# Usage: install_gh_tar <owner/repo> <asset-grep-pattern> <binary-name>
install_gh_tar() {
    local repo="$1" pattern="$2" binary="$3"
    local url tmp
    url=$(curl -fsS "https://api.github.com/repos/$repo/releases/latest" \
        | grep '"browser_download_url"' \
        | grep -v '\.sha256\|\.asc\|\.sig' \
        | grep -i "$pattern" \
        | head -1 \
        | cut -d'"' -f4)
    tmp=$(mktemp -d)
    curl -fsSL "$url" | tar -xz -C "$tmp"
    find "$tmp" -name "$binary" -type f -exec install -m755 {} "$HOME/.local/bin/$binary" \;
    rm -rf "$tmp"
}
