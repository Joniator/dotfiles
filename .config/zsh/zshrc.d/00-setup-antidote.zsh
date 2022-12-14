#!/usr/bin/env zsh

source ${ZDOTDIR:-~}/antidote/antidote.zsh
antidote_dir=${ZDOTDIR:-~}/antidote
plugins_txt=${ZDOTDIR:-~}/plugins
static_file=${ZDOTDIR:-~}/plugins.zsh

# Generate a static plugin file.
if [[ ! $static_file -nt $plugins_txt ]]; then
  (
    source $antidote_dir/antidote.zsh
    [[ -e $plugins_txt ]] || touch $plugins_txt
    antidote bundle <$plugins_txt >$static_file
  )
fi

autoload -Uz $antidote_dir/functions/antidote

# source the static plugins file
source $static_file

# cleanup
unset antidote_dir plugins_txt static_file
