#!/usr/bin/env zsh

# Install yadm
if [ ! -f /usr/local/bin/yadm ]; then
  curl -fLo /usr/local/bin/yadm https://github.com/TheLocehiliosan/yadm/raw/master/yadm && chmod a+x /usr/local/bin/yadm
fi

if [ ! -d ~/.local/share/yadm/repo.git ]; then
  yadm clone git@github.com:Joniator/dotfiles.git
fi

# Install zsh and oh-my-zsh
if command -v apt-get &> /dev/null; then
  sudo apt-get update
  sudo apt-get install -y zsh fzf
else
  echo "No package manager found";
fi

source .zshenv

if [ ! -d $ZSH ]; then
  KEEP_ZSHRC=yes sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  rm ~/.zshrc
fi

mkdir -p $XDG_CONFIG_HOME
mkdir -p $XDG_DATA_HOME
mkdir -p $XDG_STATE_HOME
