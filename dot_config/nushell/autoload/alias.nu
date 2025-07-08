alias _ = sudo
alias vi = nvim
alias l     = ls
alias la    = ls -a
alias ll    = ls -l
alias lla   = ls -la

###
# Chezmoi
###
alias ca    = chezmoi apply
alias ccd   = chezmoi cd
alias ce    = chezmoi edit --apply
alias cg    = chezmoi git
alias cr    = chezmoi re-add
alias cu    = chezmoi update

###
# Docker
###
alias dps   = docker ps
alias dpsa  = docker ps -a
alias drit  = docker run --rm -it

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

###
# Git
###
alias ng    = nvim +Neogit
alias g     = git
alias ga    = git add
alias gaa   = git add --all
alias gc    = git commit
alias gl    = git pull
alias gp    = git push
alias gst   = git status

def gacp [] {
    gaa
    gc
    gp
}
