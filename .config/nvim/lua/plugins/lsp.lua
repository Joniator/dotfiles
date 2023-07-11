local lsp_zero = {
  'VonHeikemen/lsp-zero.nvim',
  branch = 'v2.x',
  dependencies = {
    -- LSP Support
    'neovim/nvim-lspconfig',
    {
      'williamboman/mason.nvim',
      build = function()
        pcall(vim.cmd, 'MasonUpdate')
      end,
    },
    'williamboman/mason-lspconfig.nvim',
    'WhoIsSethDaniel/mason-tool-installer.nvim',

    -- Autocompletion
    'hrsh7th/nvim-cmp',
    'hrsh7th/cmp-nvim-lsp',
    'L3MON4D3/LuaSnip',
  }
}

-- Neovim language server
local null_ls = {
  'jose-elias-alvarez/null-ls.nvim',
  dependencies = { 'nvim-lua/plenary.nvim', 'williamboman/mason.nvim' },
  event = { "BufReadPre", "BufNewFile" },
}

local trouble = {
  "folke/trouble.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
}

return {
  lsp_zero,
  null_ls,
  trouble
}
