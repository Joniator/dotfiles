#! /usr/bin/env zsh

fpath=($fpath ${0:A:h}/completions)

local script_dir=${0:A:h}

source ${script_dir}/util.zsh
source ${script_dir}/dm.zsh

if executable_exists mise
then
   eval "$(mise activate zsh)"
fi

if executable_exists carapace
then
    export CARAPACE_BRIDGES='zsh,fish,bash,inshellisense'
    zstyle ':completion:*' format $'\e[2;37mCompleting %d\e[m'
    source <(carapace _carapace)
fi

if executable_exists oc 
then
  source <(oc completion zsh)
  compdef _oc oc
fi

if executable_exists oh-my-posh
then 
    eval "$(oh-my-posh init zsh --config $XDG_CONFIG_HOME/omp/jonnyb.omp.yaml)" 
fi

if executable_exists atuin
then
    eval "$(atuin init zsh --disable-up-arrow)"
fi

if executable_exists zoxide
then
    eval "$(zoxide init --cmd cd zsh)"
fi

source ${script_dir}/alias.zsh
