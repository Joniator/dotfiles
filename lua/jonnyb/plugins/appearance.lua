return {
	{ "NvChad/nvim-colorizer.lua", opts = {
		user_default_options = {
			css = true,
			tailwind = true,
		},
	} },
	{
		"catppuccin/nvim",
		name = "catppuccin",
		lazy = false,
		priority = 1000,
		config = function()
			local config = {}
			if os.getenv("LIGHT_MODE") == "true" then
				config = {
					flavour = "latte",
					transparent_background = false,
				}
			else
				config = {
					flavour = "macchiato",
					transparent_background = true,
				}
			end

			require("catppuccin").setup(config)

			vim.cmd.colorscheme("catppuccin")
		end,
	},

	{
		"nvim-lualine/lualine.nvim",
		opts = {
			options = {
				theme = "catppuccin",
				-- component_separators = "|",
				-- section_separators = "",
			},
		},
	},

	{
		"folke/todo-comments.nvim",
		event = "VimEnter",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = { signs = false },
	},

	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		opts = {},
	},

	"HiPhish/rainbow-delimiters.nvim",

	{
		"j-hui/fidget.nvim",
		opts = {
			notification = {
				window = {
					winblend = 0,
				},
			},
		},
	},
}
