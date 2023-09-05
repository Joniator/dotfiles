return {
	-- Breadcrumbs
	{
		"SmiteshP/nvim-navic",
		dependencies = {
			"neovim/nvim-lspconfig",
		},
	},

	-- Flash jump
	{
		"folke/flash.nvim",
		opts = {},
	},
	-- Telescope
	{
		"nvim-telescope/telescope.nvim",
		opts = {}
	},

	-- File explorer
	{
		'nvim-neo-tree/neo-tree.nvim',
		branch = 'v3.x',
		cmd = 'Neotree',
		dependencies = {
			'nvim-lua/plenary.nvim',
			'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
			'MunifTanjim/nui.nvim',
		},
		deactivate = function()
			vim.cmd([[Neotree close]])
		end,
		init = function()
			if vim.fn.argc() == 1 then
				local stat = vim.loop.fs_stat(vim.fn.argv(0))
				if stat and stat.type == 'directory' then
					require('neo-tree')
				end
			end
		end,
		opts = {
			sources = { 'filesystem', 'buffers', 'git_status', 'document_symbols' },
			open_files_do_not_replace_types = { 'terminal', 'Trouble', 'qf', 'Outline' },
			filesystem = {
				bind_to_cwd = false,
				follow_current_file = { enabled = true },
				use_libuv_file_watcher = true,
			},
			window = {
				mappings = {
					['<space>'] = 'none',
				},
			},
			default_component_configs = {
				indent = {
					with_expanders = true, -- if nil and file nesting is enabled, will enable expanders
					expander_collapsed = '',
					expander_expanded = '',
					expander_highlight = 'NeoTreeExpander',
				},
			},
		},
		config = function(_, opts)
			require('neo-tree').setup(opts)
			vim.api.nvim_create_autocmd('TermClose', {
				pattern = '*lazygit',
				callback = function()
					if package.loaded['neo-tree.sources.git_status'] then
						require('neo-tree.sources.git_status').refresh()
					end
				end,
			})
		end,
	},

	-- Treesitter
	{
		'nvim-treesitter/nvim-treesitter',
		dependencies = {
			'nvim-treesitter/nvim-treesitter-textobjects',
		},
		build = ':TSUpdate',
	},

	-- Highlight color codes
	'NvChad/nvim-colorizer.lua',

	-- Which key
	{
		'folke/which-key.nvim',
		opts = {},

		config = function(_, opts)
			local wk = require("which-key")
			wk.setup(opts)
			wk.register(opts.defaults)
		end,
	},

	-- Gitsigns    
	{
		-- Adds git related signs to the gutter, as well as utilities for managing changes
		'lewis6991/gitsigns.nvim',
		opts = {
			-- See `:help gitsigns.txt`
			signs = {
				add = { text = '+' },
				change = { text = '~' },
				delete = { text = '_' },
				topdelete = { text = '‾' },
				changedelete = { text = '~' },
			},
			on_attach = function(bufnr)
				require('config/keymap').gitsigns(bufnr)
			end,
		},
	},

	-- LSP Configuration & Plugins
	{
		'neovim/nvim-lspconfig',
		dependencies = {
			-- Automatically install LSPs to stdpath for neovim
			{
				'williamboman/mason.nvim',
				config = true,
			},
			'williamboman/mason-lspconfig.nvim',

			-- Useful status updates for LSP
			{
				'j-hui/fidget.nvim',
				tag = 'legacy',
				opts = {},
			},

			-- Additional lua configuration, makes nvim stuff amazing!
			'folke/neodev.nvim',
		},
	},

	-- Autocompletion
	{
		'hrsh7th/nvim-cmp',
		dependencies = {
			-- Snippet Engine & its associated nvim-cmp source
			'L3MON4D3/LuaSnip',
			'saadparwaiz1/cmp_luasnip',

			-- Adds LSP completion capabilities
			'hrsh7th/cmp-nvim-lsp',

			-- Adds a number of user-friendly snippets
			'rafamadriz/friendly-snippets',
		},
	},

}
