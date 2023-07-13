local git_mappings = {
	name = "git",
	b = {
		":Gitsigns toggle_current_line_blame<CR>",
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

local control_mappings = {
	["<c-p>"] = {
		":lua require('fzf-lua').files()<CR>",
		"Fuzzy find files",
	},
	["<c-a>"] = {
		":lua require('fzf-lua').commands()<CR>",
		"Fuzzy find commands",
	},
	["<c-f>"] = {
		":lua require('fzf-lua').live_grep()<CR>",
		"Fuzzy find text in files",
	},
}

local wk = require("which-key")

wk.register({
	p = pretty_mappings,
	g = git_mappings,
}, {
	prefix = "<leader>",
})

wk.register(
	control_mappings
)
