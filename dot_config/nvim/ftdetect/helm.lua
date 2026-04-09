vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  desc = "Detect helmfiles",
  pattern = { "*/helm/**/*.yaml", "*/helm/**/*.yml", "*/helm/**/*.tpl" },
  callback = function()
    vim.api.nvim_set_option_value("ft", "helm", {})
  end,
})
