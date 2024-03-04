#!/usr/bin/env zsh

alias ch='chezmoi'
alias chg="ch git"

# Add
alias chadd='ch add'
alias chaddt='cha --template'

# Edit
alias che='ch edit --apply'

# Apply
alias cha='ch apply'
alias chaa='cha --refresh-externals'
alias chae='chap --exclude=encrypted'
