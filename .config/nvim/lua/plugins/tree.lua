return {
	"nvim-tree/nvim-tree.lua",
	lazy = false,
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	opts = {
		sort_by = "case_sensitive",
		view = {
			width = {
        max = "40%"
      },
		},
		renderer = {
			group_empty = true,
			highlight_git = true,
			full_name = true,
			icons = {
				git_placement = "signcolumn",
			},
		},
		filters = {
			dotfiles = true,
		},
	},
}
