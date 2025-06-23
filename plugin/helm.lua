local helmAuGroup = vim.api.nvim_create_augroup("HelmGroup", { clear = true })

vim.api.nvim_create_autocmd("BufEnter", {
  group = helmAuGroup,
  pattern = "preview-fss",
  callback = function()
    local output = vim.fn.system("helm template ./deployment/helm/fss")
    local lines = vim.split(output, "\n")
    vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
  end,
})

vim.api.nvim_create_autocmd("BufEnter", {
  group = helmAuGroup,
  pattern = "preview-fss",
  callback = function()
    local output = vim.fn.system("helm template ./deployment/helm/fss")
    local lines = vim.split(output, "\n")
    vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
  end,
})

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  group = helmAuGroup,
  pattern = { "*.yaml", "*.yml", "*.tpl" },
  callback = function(args)
    local path = vim.fn.fnamemodify(args.file, ":p:h")

    local function has_chart_yaml(dir)
      return vim.fn.filereadable(dir .. "/Chart.yaml") == 1 or vim.fn.filereadable(dir .. "/Chart.yml") == 1
    end

    while path ~= "/" do
      if has_chart_yaml(path) then
        vim.bo[args.buf].filetype = "helm"
        break
      end
      path = vim.fn.fnamemodify(path, ":h")
    end
  end,
})
