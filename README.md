# Dotfiles

Managed with [chezmoi](https://chezmoi.io/).

# Installation

```sh
# Don't decrypt secrets, works on non-interactive terminals and does not need a password to work
sh -c "$(curl -fsLS https://joniator.github.io/dotfiles/install.sh) --mode=checkout"

# Trying to decrypt secrets, needs interactive terminal and password
sh -c "$(curl -fsLS https://joniator.github.io/dotfiles/install.sh) --mode=decrypt"
```

## Usage
Some programs need to be installed first:

### SDKMan
```sh
setup-sdkman
```

### Neovim
```sh
setup-nvim
```

## License

MIT
