local map = vim.keymap.set
return {
  {
    'stevearc/oil.nvim',
    config = function()
      require('oil').setup {
        view_options = {
          show_hidden = true,
        },
      }
      map('n', '<leader>-', '<cmd>Oil<CR>', { desc = 'File Manager' })
    end,
  },
}
