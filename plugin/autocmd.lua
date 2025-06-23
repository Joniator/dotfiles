vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

local term = vim.api.nvim_create_augroup("term", { clear = true })
vim.api.nvim_create_autocmd("TermOpen", {
  callback = function()
    vim.opt_local.relativenumber = false
    vim.opt_local.number = false
  end,
  group = term,
})

vim.api.nvim_create_autocmd("BufEnter", {
  group = vim.api.nvim_create_augroup("HelmTemplateGroup", { clear = true }),
  pattern = "preview-fss",
  callback = function()
    local output = vim.fn.system("helm template ./deployment/helm/fss")
    local lines = vim.split(output, "\n")
    vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
  end,
})
