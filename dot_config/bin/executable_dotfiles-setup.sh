#! /usr/bin/env bash
set -e

if [ "$(id -u)" -eq 0 ]; then
  SUDO=""
else
  if ! command -v sudo &>/dev/null; then
    echo "❌ sudo is not installed. Please install sudo or run as root."
    exit 1
  fi
  SUDO="sudo"
fi

function get_latest_release_version {
  REPO="$1"
  curl --silent "https://api.github.com/repos/$1/releases/latest" |
    jq .tag_name -r
}

function install_atuin {
  NAME="atuin"
  VERSION="$(get_latest_release_version atuinsh/atuin)"
  BIN="$HOME/.local/bin/$NAME"
  LIB="$HOME/.local/lib/$NAME"
  echo "⚙️  Installing $NAME"

  [[ -e "$BIN" ]] && rm -rf "$BIN"
  [[ -d "$LIB" ]] && rm -rf "$LIB"
  mkdir -p $LIB || return 3

  tar -C "$LIB" --strip-components 1 -xzf <(curl -sL "https://github.com/atuinsh/atuin/releases/download/$VERSION/atuin-x86_64-unknown-linux-gnu.tar.gz")
  ln -s "$LIB/$NAME" "$BIN"
  echo "✅ $NAME installed successfully"
}

function install_entr {
  NAME=entr
  echo "⚙️  Installing $NAME"
  (
    TMP="$(mktemp -d)"
    cd $TMP
    git clone https://github.com/eradman/entr.git
    cd entr
    ./configure
    make test
    PREFIX=~/.local make install
    echo "✅ $NAME installed successfully"
  )
}

function install_fnm {
  NAME="fnm"
  echo "⚙️  Installing $NAME"

  curl -fsSL https://fnm.vercel.app/install | bash -s -- -s || return 1
  $XDG_DATA_HOME/fnm/fnm use --install-if-missing 20
  echo "✅ $NAME installed successfully"
}

function install_fzf {
  NAME="fzf"
  VERSION=$(get_latest_release_version "junegunn/fzf" | cut -c 2-)
  ARCH=$(uname -m)
  BIN="$HOME/.local/bin/fzf"
  echo "⚙️  Installing $NAME"

  if [[ $ARCH -eq "x86_64" ]]; then
    ARCH="amd64"
  elif [[ $ARCH -eq "arm64" ]]; then
    ARCH="arm8"
  else
    echo "❌ $ARCH is not supported"
    return
  fi

  [[ -e "$BIN" ]] && rm "$BIN"
  wget -qO- "https://github.com/junegunn/fzf/releases/download/v$VERSION/fzf-$VERSION-linux_$ARCH.tar.gz" |
    tar -xz -C $HOME/.local/bin
  chmod +x "$BIN"
  echo "✅ $NAME installed successfully"
}

function install_go {
  NAME='go'
  VERSION='go1.22.1'
  LIB="$HOME/.local/lib/go"
  BIN="$HOME/.local/bin/go"
  echo "⚙️  Installing $NAME"

  rm -rf "$LIB"
  rm -f "$BIN"
  mkdir -p "$LIB"
  zsh -c "tar -C ~/.local/lib -xzf <(curl -sL https://go.dev/dl/go1.22.1.linux-amd64.tar.gz)"
  ln -s "$LIB/bin/go" "$BIN"
  echo "✅ $NAME installed successfully"
}

function install_omp {
  NAME="Oh My Posh"
  echo "⚙️  Installing $NAME"
  if [[ ! -s "$HOME/.local/bin/oh-my-posh" && ! -d $XDG_CACHE_HOME/oh-my-posh ]]; then
    curl -s https://ohmyposh.dev/install.sh | bash -s -- -d ~/.local/bin
  else
    echo "✅ $NAME is already installed"
  fi
}

function install_rust {
  NAME="Rust"
  echo "⚙️  Installing $NAME"

  curl https://sh.rustup.rs -sSf | sh -s -- -y
  echo "✅ $NAME installed successfully"
}

function install_sdkman {
  NAME="SDKMan"
  echo "⚙️  Installing $NAME"
  if [[ ! -s "$SDKMAN_DIR/bin/sdkman-init.sh" ]]; then
    source <(curl -s "https://get.sdkman.io?rcupdate=false") || return 1
    source "$SDKMAN_DIR/bin/sdkman-init.sh" || return 2
  else
    echo "✅ $NAME is already installed"
  fi
}

function install_zoxide {
  NAME="zoxide"
  echo "⚙️  Installing $NAME"

  curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash
  echo "✅ $NAME installed successfully"
}

APT_PACKAGES=(
  bat
  btop
  build-essential
  direnv
  fd-find
  ffmpeg
  git
  jq
  neofetch
  neovim
  python3-pip
  python3-venv
  ripgrep
  software-properties-common
  tar
  tmux
  unzip
  zip
)
PIP_PACKAGES=(
  ansible
  yt-dlp
)
CARGO_PACKAGES=(
  du-dust
  eza
  tlrc
)

$SUDO add-apt-repository -y ppa:neovim-ppa/unstable
$SUDO apt-get update && $SUDO apt-get install -y $APT_PACKAGES && echo "✅ Apt packages installed successfully"
pip install $PIP_PACKAGES && echo "✅ Pip packages installed successfully"
cargo install $CARGO_PACKAGES && echo "✅ Cargo packages installed successfully"

install_atuin
install_entr
install_fnm
install_fzf
install_go
install_omp
install_rust
install_sdkman
install_zoxide
