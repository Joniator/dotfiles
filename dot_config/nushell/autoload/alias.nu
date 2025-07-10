alias _   = sudo
alias vi  = nvim
alias l   = ls
alias la  = ls -a
alias ll  = ls -l
alias lla = ls -la

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
