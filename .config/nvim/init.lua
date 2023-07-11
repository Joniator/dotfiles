require("vim-config")

require("install-lazy")
require("lazy").setup("plugins", {
  install = {
    colorscheme = { "catppuccin-macchiato" }
  }
})
