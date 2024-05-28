return {
  {
    'folke/trouble.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      local map = vim.keymap.set
      local t = require 'trouble'

      map('n', '<leader>tt', function()
        t.toggle()
      end, { desc = '[T]oggle' })

      map('n', '<leader>tw', function()
        t.toggle 'workspace_diagnostics'
      end, { desc = '[W]orkspace diagnostics' })

      map('n', '<leader>td', function()
        t.toggle 'document_diagnostics'
      end, { desc = '[D]ocument diagnostics' })

      map('n', '<leader>tq', function()
        t.toggle 'quickfix'
      end, { desc = '[Q]uickfix' })

      map('n', '<leader>tl', function()
        t.toggle 'loclist'
      end, { desc = '[L]oclist' })

      map('n', 'gR', function()
        t.toggle 'lsp_references'
      end, { desc = 'Lsp [R]eferences' })
    end,
  },
}
