# CachyOS install — sourced by install.sh after utils.sh.

# Bootstrap paru (AUR helper) if not already present
if ! command -v paru &>/dev/null; then
    $SUDO pacman -Sy --noconfirm paru
fi

paru -Suy --noconfirm \
    atuin \
    carapace-bin \
    chezmoi \
    fastfetch \
    fd \
    fzf \
    git \
    mise \
    neovim \
    nushell \
    oh-my-posh \
    ripgrep \
    zoxide
