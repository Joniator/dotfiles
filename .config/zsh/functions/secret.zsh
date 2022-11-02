#!/usr/bin/env zsh

secret () {
  SECRET_PATH="$XDG_CONFIG_HOME/secrets/$1.zsh"

  if [[ ! -f $SECRET_PATH ]]; then
    echo "Can't find secret file"
  else
      source "$SECRET_PATH"
  fi
}

