local git_mappings = {
	name = "git",
	b = {
		":Gitsigns toggle_current_line_blame",
		"blame",
	},
	h = {
		name = "hunk",
		n = {
			":Gitsigns next_hunk<CR>",
			"next",
		},
		N = {
			":Gitsigns prev_hunk<CR>",
			"prev",
		},
		p = {
			":Gitsigns preview_hunk<CR>",
			"preview",
		},
		s = {
			":Gitsigns stage_hunk<CR>",
			"stage",
		},
		u = {
			":Gitsigns undo_stage_hunk<CR>",
			"undo",
		},
		r = {
			":Gitsigns reset_hunk<CR>",
			"reset",
		},
	},
	f = {
		name = "buffer",
		s = {
			":Gitsigns stage_buffer<CR>",
			"stage",
		},
		u = {
			":Gitsigns undo_stage_buffer<CR>",
			"undo",
		},
		r = {
			":Gitsigns reset_buffer<CR>",
			"reset",
		},
	},
}

local pretty_mappings = {
	name = "pretty",
	f = {
		function()
			vim.lsp.buf.format({ async = false })
		end,
		"Format current file",
	},
}

local wk = require("which-key")

wk.register({
	p = pretty_mappings,
	g = git_mappings,
}, {
	prefix = "<leader>",
})
