alias _   = sudo
alias cat = open --raw
alias l   = ls
alias la  = ls -a
alias ll  = ls -l
alias lla = ls -la
alias vi  = nvim
alias vf = nvim (fzf)
alias afk = install-nothing

###
# Chezmoi
###
alias ca  = chezmoi apply
alias ccd = chezmoi cd
alias ce  = chezmoi edit --apply
alias cg  = chezmoi git
alias cr  = chezmoi re-add
alias cu  = chezmoi update

def "ce nvim" [] { ce ~/.config/nvim }
def "ce nu" [] { ce ~/.config/nushell; exec nu }
def "ce mise" [] { ce ~/.config/mise/config.toml; }

###
# Docker
###
alias dps  = docker ps
alias dpsa = docker ps -a
alias drit = docker run --rm -it

###
# Docker Compose
###
alias dc    = docker compose
alias dce   = dc execute
alias dclog = dc log --tail 20 -f
alias dcps  = dc ps
alias dcpsa = dc ps -a
alias dcup  = dc up
alias dcupd = dc up -d
alias dndn  = dc down

alias g  = git
alias ng = nvim +Neogit
alias g  = git

def gacp [] {
    g aa
    g c
    g p
}

if ((which podman-remote-static-linux_amd64 | is-not-empty) and (which podman | is-empty)) {
    alias podman = podman-remote-static-linux_amd64
}

def --env "load-env-file" [file = '.env'] {
    open $file
    | lines 
    | split column "=" 
    | rename name value 
    | where not (($it.name | str starts-with "#") or ($it.name | is-empty)) 
    | reduce -f {} {|it, acc| $acc | upsert $it.name $it.value } 
    | load-env
}

def "e" [...rest] {
    nvim ...$rest
}

def "util chezmoi-origin-to-ssh" [] {
    let dotfiles_url = "ssh://git@codeberg.org/JonnyB/dotfiles.git"
    chezmoi git remote set-url origin $dotfiles_url
}

def "util ipinfo" [] {
    http get --headers [ ACCEPT application/json ] ipinfo.io | get ip
}

def "util nvim-update" [] {
    nvim --headless "+Lazy! sync" +qa
    chezmoi add ~/.config/nvim/lazy-lock.json
}

def "util update" [] {

    const config_file = $nu.data-dir | path join "autoupdate.yaml"
    mut config = {};

    if ($config_file | path exists) {
        $config = open $config_file
    }

    if (($config.last_updated? | is-empty) or ($config.last_updated | date from-human) < (date now) - 7day) {
        print "Updating dotfiles"
        $config | upsert last_updated (date now) | save -f $config_file
        chezmoi update
    }
}
