#!/bin/sh

# -e: exit on error
# -u: exit on unset variables
set -eu

print_help () {
  echo """
  install.sh [--mode=MODE] [--ssh]
  Installs chezmoi and applies the dotfiles using MODE

  Defaults:
    MODE = local
    SSH = false
  
  Modes:
    local     Uses the local, checked out version of the repo, useful for CI/development without decrypting
    checkout  Checks out the repository and applies non-interactively without decrypting the secrest
    decrypt   Checks out the repository and interactively asks for decryption password. Does not work non-interactive and fails without correct password.
"""
}

install_dependencies () {
  if apt="$(command -v apt)"; then 
    echo "Installing dependencies"
    packages="curl zsh git gettext zip unzip build-essential"
    if sudo=$(command -v sudo); then
      sudo apt-get update
      sudo apt-get install -y $packages
    elif [ $(id -u) = 0 ]; then
      apt-get update
      apt-get install -y $packages
    fi
  fi
}

install_chezmoi () {
  if ! chezmoi="$(command -v chezmoi)"; then
    bin_dir="${HOME}/.local/bin"
    chezmoi="${bin_dir}/chezmoi"
    echo "Installing chezmoi to '${chezmoi}'" >&2
    if command -v curl >/dev/null; then
      chezmoi_install_script="$(curl -fsSL https://chezmoi.io/get)"
    elif command -v wget >/dev/null; then
      chezmoi_install_script="$(wget -qO- https://chezmoi.io/get)"
    else
      echo "To install chezmoi, you must have curl or wget installed." >&2
      exit 1
    fi
    sh -c "${chezmoi_install_script}" -- -b "${bin_dir}"
    unset chezmoi_install_script bin_dir
  fi
}

arg_mode=local
flag_ssh=false
while [ $# -gt 0 ]; do
  case $1 in
    -h|--help)          print_help && return                    ;;
    -m|--mode)          shift; arg_mode=$1                      ;;
    -m=*|--mode=*)      arg_mode="${1#*=}"                      ;;
    -s|--ssh)           flag_ssh=true                           ;;
    *)                  print_help && return 2                  ;;
  esac
  shift
done

install_dependencies
install_chezmoi

set -- init --apply
if [ $arg_mode = "local" ]; then
  # POSIX way to get script's dir: https://stackoverflow.com/a/29834779/12156188
  script_dir="$(cd -P -- "$(dirname -- "$(command -v -- "$0")")" && pwd -P)"
  set -- "$@" --source="${script_dir}" --exclude=encrypted
elif [ $arg_mode = "checkout" ]; then
  set -- "$@" Joniator --exclude=encrypted
elif [ $arg_mode = "decrypt" ]; then
  set -- "$@" Joniator
fi

if [ $flag_ssh = true ]; then
  set -- "$@" --ssh
fi

chezmoi="$(command -v chezmoi)"
echo "Running '$chezmoi $*'" >&2
# exec: replace current process with chezmoi
exec "$chezmoi" "$@"
