#!/usr/bin/env sh
set -e -o xtrace

APT_PACKAGES="yadm zsh fzf zip unzip curl sed jq ctop nodejs npm ripgrep bat python3-pip python3-venv"

GITUI_VERSION="v0.23.0"

# Install packages
if command -v apt-get >/dev/null 2>&1; then
	sudo apt-get update
	sudo apt-get install -y "$APT_PACKAGES"

	ln -s /usr/bin/batcat ~/.local/bin/bat

  # Install nvim
	if ! command -v nvim >/dev/null 2>&1; then
		case $(uname -m) in
		x86_64)
			TEMP_DEB="$(mktemp ./nvim-XXXXXX.deb)" &&
				wget -O "$TEMP_DEB" "https://github.com/neovim/neovim/releases/download/v0.8.2/nvim-linux64.deb" &&
				sudo apt-get install -y "$TEMP_DEB" &&
				rm -f "$TEMP_DEB" || echo "Failed to install nvim"
			;;
		default)
			echo "Failed to install nvim, architecture not supported" >&2
			;;
		esac
	fi

  # Install gitui
	if ! command -v gitui >/dev/null 2>&1; then
    case $/uname -m) in
      x86_64)
        wget -qO- https://github.com/extrawurst/gitui/releases/download/v0.23.0/gitui-linux-musl.tar.gz | sudo tar -xz -C /usr/local/bin
        ;;
      default)
        echo "Failed to install gitui, architecture not supported" >&2
    esac
	fi
else
	echo "No package manager found"
fi

if [ ! -d ~/.local/share/yadm/repo.git ]; then
	bash <<EOF
  cd $HOME
  yadm clone https://github.com/Joniator/dotfiles
  yadm submodule init
  yadm submodule update
EOF
fi

. "$HOME/.zshenv"

mkdir -p "$XDG_CONFIG_HOME"
mkdir -p "$XDG_DATA_HOME"
mkdir -p "$XDG_STATE_HOME"

echo Changing default shell
sudo chsh -s $(which zsh) "$USER"
