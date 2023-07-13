require("config/vim")

require("install-lazy")
require("lazy").setup("plugins", {
	install = {
		colorscheme = { "catppuccin-macchiato" },
	},
})

require("config/lsp")
require("config/which-key")
