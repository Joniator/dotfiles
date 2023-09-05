return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
  },
  config = function()
    local mason = require("mason")
    mason.setup({})

    local lspconfig = require("mason-lspconfig")

    lspconfig.setup({
      ensure_installed = {
        "lua_ls",
      },
      automatic_installation = true,
    })
  end,
}
