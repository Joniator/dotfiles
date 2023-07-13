local lsp = require("lsp-zero").preset({})

lsp.on_attach(function(client, bufnr)
	lsp.default_keymaps({ buffer = bufnr })
end)

require("mason-lspconfig").setup()

require("mason-tool-installer").setup({
	ensure_installed = {
		"lua-language-server",
		"selene", -- Lua stylecheck
		"stylua",
	},
})

require("lspconfig").lua_ls.setup({
	root_dir = function()
		--- project root will be the first directory that has
		--- either .luarc.json or .stylua.toml
		return lsp.dir.find_first({ ".luarc.json", ".stylua.toml" })
	end,
})

lsp.setup()
require("lspconfig").lua_ls.setup(lsp.nvim_lua_ls())

local null_ls = require("null-ls")

local builtins = null_ls.builtins
local code_actions = builtins.code_actions
local completion = builtins.completion
local diagnostics = builtins.diagnostics
local formatting = builtins.formatting

null_ls.setup({
	sources = {
		code_actions.gitsigns,
		completion.spell,
		diagnostics.eslint,
		formatting.stylua,
	},
})

