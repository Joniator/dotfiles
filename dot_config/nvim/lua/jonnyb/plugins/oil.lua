local map = vim.keymap.set
return {
  {
    'stevearc/oil.nvim',
    config = function()
      require('oil').setup {}
      map('n', '<leader>-', '<cmd>Oil<CR>', { desc = 'File Manager' })
    end,
  },
}
