return {
  "Bekaboo/dropbar.nvim",
  dependencies = {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "make",
  },
  keys = function()
    local dropbar_api = require("dropbar.api")
    require("which-key").add({
      {
        "<leader>;",
        dropbar_api.pick,
        desc = "Pick symbols in winbar",
      },
      {
        "[;",
        dropbar_api.goto_context_start,
        desc = "Go to start of current context",
      },
      {
        "];",
        dropbar_api.select_next_context,
        desc = "Select next context",
      },
    })
  end,
}
