#!/usr/bin/env zsh

setopt EXTENDED_GLOB
for _zconf in $ZDOTDIR/zshrc.d/*.zsh(N); do
  #ignore files that begin with a tilde
  case ${f:t} in '~'*) continue;; esac
  source "$_zconf"
done
unset _zconf


# sdkman-init.sh
