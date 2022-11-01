#!/usr/bin/env zsh

# Install yadm
if [ ! -f /usr/local/bin/yadm ]; then
  sudo curl -fLo /usr/local/bin/yadm https://raw.githubusercontent.com/TheLocehiliosan/yadm/master/yadm && sudo chmod a+x /usr/local/bin/yadm
fi

if [ ! -d ~/.local/share/yadm/repo.git ]; then
  yadm clone https://github.com/Joniator/dotfiles
  yadm submodule init
  yadm submodule update
fi

source ~/.zshenv

# Install zsh
if command -v apt-get &> /dev/null; then
  sudo apt-get update
  sudo apt-get install -y zsh fzf zip unzip curl sed
else
  echo "No package manager found";
fi

mkdir -p $XDG_CONFIG_HOME
mkdir -p $XDG_DATA_HOME
mkdir -p $XDG_STATE_HOME
