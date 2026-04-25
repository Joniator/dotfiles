# Ubuntu install — sourced by install.sh after utils.sh.

$SUDO apt-get update
$SUDO apt-get install -y curl git gpg unzip software-properties-common

# Nushell via fury.io apt repo
curl -fsSL https://apt.fury.io/nushell/gpg.key \
    | $SUDO gpg --dearmor --batch --yes -o /etc/apt/trusted.gpg.d/fury-nushell.gpg
echo "deb https://apt.fury.io/nushell/ /" | $SUDO tee /etc/apt/sources.list.d/fury.list

# Neovim (unstable PPA for latest) and Fastfetch
$SUDO add-apt-repository -y ppa:neovim-ppa/unstable
$SUDO add-apt-repository -y ppa:zhangsongcui3371/fastfetch

$SUDO apt-get update
$SUDO apt-get install -y neovim nushell fastfetch ripgrep fd-find fzf

# Ubuntu ships fd as 'fdfind'; expose it as 'fd'
ln -sf "$(command -v fdfind)" "$HOME/.local/bin/fd"

# Chezmoi — official installer, respects $HOME
sh -c "$(curl -fsLS get.chezmoi.io)" -- -b "$HOME/.local/bin"

# Oh My Posh
curl -s https://ohmyposh.dev/install.sh | bash -s -- -d "$HOME/.local/bin"

# Carapace (Go-style arch: amd64/arm64)
install_gh_tar "carapace-sh/carapace-bin" "linux_${GOARCH}.tar.gz" "carapace"

# Zoxide — installs to ~/.local/bin by default
curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh

# Atuin (uname -m arch: x86_64/aarch64)
install_gh_tar "atuinsh/atuin" "${ARCH}-unknown-linux-musl" "atuin"

# Mise — kept for Java version management only
curl https://mise.run | sh
