-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny

local catppuccin_config =   {
  "catppuccin/nvim",
  name = "catppuccin"
}


local minimap_config =   {
  'wfxr/minimap.vim',
  build = "cargo install --locked code-minimap",
  -- cmd = {"Minimap", "MinimapClose", "MinimapToggle", "MinimapRefresh", "MinimapUpdateHighlight"},
  config = function ()
    vim.cmd("let g:minimap_width = 10")
    vim.cmd("let g:minimap_auto_start = 1")
    vim.cmd("let g:minimap_auto_start_win_enter = 1")
  end
}


local spectre_config = {
  "windwp/nvim-spectre",
  event = "BufRead",
  config = function()
    require("spectre").setup()
  end,
}


lvim.plugins = {
  catppuccin_config,
  minimap_config,
  spectre_config
}

vim.cmd.colorscheme("catppuccin-mocha")
