return {
  'ojroques/nvim-bufdel',
  config = function()
    local bufdel = require('bufdel')
    bufdel.setup({
      quit = false,
    })
    vim.keymap.set('n', '<leader>bd', bufdel.delete_buffer_expr, { desc = 'Delete buffer' })
    vim.keymap.set('n', '<leader>bD', function() bufdel.delete_buffel_expr(null, true) end, { desc = 'Delete buffer' })
  end,
}
