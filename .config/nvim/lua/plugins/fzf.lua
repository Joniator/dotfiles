return {
	{
		"junegunn/fzf",
		build = "./install --bin",
	},
	{
		"ibhagwan/fzf-lua",
		lazy = true,
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {
			"fzf-native",
		},
	},
}
