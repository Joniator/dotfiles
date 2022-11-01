#!/usr/bin/env zsh

source $XDG_CONFIG_HOME/antigen/antigen.zsh

antigen use oh-my-zsh

antigen bundles <<EOBUNDLES
  docker
  docker-compose
  fzf
  git
  matthieusb/zsh-sdkman@main
  MichaelAquilina/zsh-you-should-use
  rsync
  sudo
  systemadmin
  tmux
  zsh-users/zsh-autosuggestions
  zsh-users/zsh-completions
  zsh-users/zsh-syntax-highlighting
EOBUNDLES

antigen theme robbyrussell

antigen apply

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/home/boeckj/.sdkman"
[[ -s "/home/boeckj/.sdkman/bin/sdkman-init.sh" ]] && source "/home/boeckj/.sdkman/bin/sdkman-init.sh"
