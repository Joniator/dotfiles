-- Learn the keybindings, see :help lsp-zero-keybindings
-- Learn to configure LSP sevrers, see :help lsp-zero-api-showcase
local lsp = require('lsp-zero').preset('recommended')

lsp.on_attach(function(client, bufnr)
  lsp.default_keymaps({buffer = bufnr})
end)

lsp.setup()
