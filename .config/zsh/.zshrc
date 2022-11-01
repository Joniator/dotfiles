source $XDG_CONFIG_HOME/antigen/antigen.zsh

antigen use oh-my-zsh

antigen bundles <<EOBUNDLES
  docker
  docker-compose
  fzf
  git
  rsync
  sudo
  systemadmin
  tmux
  MichaelAquilina/zsh-you-should-use
  zsh-users/zsh-completions
  zsh-users/zsh-autosuggestions
  zsh-users/zsh-syntax-highlighting
EOBUNDLES

antigen theme robbyrussell

antigen apply
