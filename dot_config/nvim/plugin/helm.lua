local helmAuGroup = vim.api.nvim_create_augroup("HelmGroup", { clear = true })

vim.api.nvim_create_autocmd("BufEnter", {
  group = helmAuGroup,
  pattern = { "preview-*" },
  callback = function(args)
    local bufname = vim.api.nvim_buf_get_name(args.buf)
    local basename = vim.fn.fnamemodify(bufname, ":t")
    local folder = basename:match("^preview%-(.+)$")

    if folder then
      local helm_cmd = "helm template ./deployment/helm/" .. folder
      local output = vim.fn.systemlist(helm_cmd)
      if vim.v.shell_error == 0 then
        vim.api.nvim_buf_set_lines(args.buf, 0, -1, false, output)
      else
        vim.notify("Helm template failed: " .. table.concat(output, "\n"), vim.log.levels.ERROR)
      end
    end
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
