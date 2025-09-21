return {
  "mason-org/mason-lspconfig.nvim",
  opts = {
    automatic_enable = {
      exclude = { "stylua" },
    },
  },
  dependencies = {
    { "mason-org/mason.nvim", opts = {} },
    "neovim/nvim-lspconfig",
  },
}
