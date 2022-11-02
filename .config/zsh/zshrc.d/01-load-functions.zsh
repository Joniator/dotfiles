#!/usr/bin/env zsh

setopt EXTENDED_GLOB
for _zconf in $ZDOTDIR/functions/*.zsh(N); do
  #ignore files that begin with a tilde
  case ${f:t} in '~'*) continue;; esac
  source "$_zconf"
done
unset _zconf
