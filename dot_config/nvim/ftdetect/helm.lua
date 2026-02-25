vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  desc = "Detect helmfiles",
  group = vim.api.nvim_create_augroup("helmfile-detection", { clear = true }),
  pattern = { "*/helm/**/*.yaml", "*/helm/**/*.yml", "*/helm/**/*.tpl" },
  callback = function(ev)
    vim.api.nvim_set_option_value("ft", "helm", {})
  end,
})
