return {
	{
		"junegunn/fzf",
		build = "./install --bin",
	},
	{
		"ibhagwan/fzf-lua",
		lazy = true,
		dependencies = { "nvim-tree/nvim-web-devicons" },
		keys = {
			{ "<c-P>", '<cmd>lua require("fzf-lua").files()<CR>', silent = true, desc = "Find files" },
			{ "<c-A>", '<cmd>lua require("fzf-lua").commands()<CR>', silent = true, desc = "Find commands" },
			{ "<c-F>", '<cmd>lua require("fzf-lua").live_grep()<CR>', silent = true, desc = "Find text" },
		},
		opts = {
			"fzf-native",
		},
	},
}
