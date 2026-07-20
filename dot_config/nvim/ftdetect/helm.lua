vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  desc = "Detect helmfiles",
  pattern = { "*/helm/**/*.yaml", "*/helm/**/*.yml", "*/helm/**/*.tpl" },
  callback = function(arg)
    if arg.file ~= "values.yaml" then
      vim.api.nvim_set_option_value("ft", "helm", {})
    end
  end,
})
