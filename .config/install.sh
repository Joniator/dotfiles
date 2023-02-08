#!/usr/bin/env sh
set -e -o xtrace

APT_PACKAGES="yadm zsh fzf zip unzip curl sed jq ctop nodejs npm ripgrep"

# Install packages
if command -v apt-get > /dev/null 2>&1; then
  sudo apt-get update
  sudo apt-get install -y $APT_PACKAGES

  if ! command -v nvim > /dev/null 2>&1; then
    TEMP_DEB="$(mktemp nvim-XXXXXX.deb)" && \
    wget -O "$TEMP_DEB" "https://github.com/neovim/neovim/releases/download/v0.8.2/nvim-linux64.deb" && \
    sudo apt-get install -y "$TEMP_DEB" && \
    rm -f "$TEMP_DEB" || echo "Failed to install nvim"
  fi
else
  echo "No package manager found";
fi

if [ ! -d ~/.local/share/yadm/repo.git ]; then
  yadm clone https://github.com/Joniator/dotfiles
  yadm submodule init
  yadm submodule update
fi

. "$HOME/.zshenv"

mkdir -p "$XDG_CONFIG_HOME"
mkdir -p "$XDG_DATA_HOME"
mkdir -p "$XDG_STATE_HOME"

echo Changing default shell
<<<<<<< HEAD
if [[ $- == *i* ]]; then
  chsh -s $(which zsh)
  zsh
fi
=======
chsh -s "$(which zsh)"

zsh
>>>>>>> 5c4de5e (Fix shellcheck)
