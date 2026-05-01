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

if executable_exists nvim
then
    alias vi="nvim"
    alias vim="nvim"

    vf() {
        file="$(find . | fzf)"
        if [[ $? = 0 ]]; then
            nvim "$file"
        fi
    }
fi

if executable_exists atuin
then
    eval "$(atuin init zsh --disable-up-arrow)"
fi

if executable_exists zoxide
then
    eval "$(zoxide init --cmd cd zsh)"
fi

alias ca="chezmoi apply"
alias cg="chezmoi git"
alias g="git"

function ce() {
    local dir=$PWD
    cd ~/.local/share/chezmoi
    vi $@
    chezmoi apply
    cd $dir
    exec zsh
}
