require('glow').setup({
  width = 192,
  height = 108
})

vim.keymap.set("n", "<leader>help", function() vim.cmd.Glow { '~/README.md' } end)
