local mason = require('mason-lspconfig')
mason.ensure_installed = {
  'lua_ls',
}

local lspconfig = require('lspconfig')

lspconfig.lua_ls.setup({})
