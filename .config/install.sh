#!/usr/bin/env zsh

APT_PACKAGES=(yadm zsh fzf zip unzip curl sed jq ctop)

# Install packages
if command -v apt-get &> /dev/null; then
  sudo apt-get update
  sudo apt-get install -y $APT_PACKAGES
else
  echo "No package manager found";
fi

if [ ! -d ~/.local/share/yadm/repo.git ]; then
  yadm clone https://github.com/Joniator/dotfiles
  yadm submodule init
  yadm submodule update
fi

source ~/.zshenv

mkdir -p $XDG_CONFIG_HOME
mkdir -p $XDG_DATA_HOME
mkdir -p $XDG_STATE_HOME

echo Changing default shell
chsh -s $(which zsh)

zsh
