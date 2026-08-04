$env.EDITOR = 'nvim'
alias _   = sudo
alias cat = open --raw
alias l   = ls
alias la  = ls -a
alias ll  = ls -l
alias lla = ls -la
alias vi  = nvim
alias vf  = nvim (fzf)
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

# Podman Docker compat
let _podman_sock = "/mnt/wsl/podman-sockets/podman-machine-default/podman-user.sock"
if ($_podman_sock | path exists) {
    $env.DOCKER_HOST = $"unix://($_podman_sock)"
}
