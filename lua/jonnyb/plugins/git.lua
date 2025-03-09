return {
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim",

      -- Only one of these is needed.
      "nvim-telescope/telescope.nvim", -- optional
    },
    keys = {
      {
        "<leader>g",
        group = "git",
      },
      {
        "<leader>gg",
        ":Neogit<CR>",
        desc = "Open Neogit",
      },
    },
  },
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      on_attach = function(bufnr)
        local gitsigns = require("gitsigns")

        require("which-key").add({
          {
            "<leader>g",
            group = "git",
            buffer = bufnr,
          },
          {
            "<leader>gh",
            group = "hunk",
            buffer = bufnr,
          },
          {
            "<leader>gb",
            group = "buffer",
            buffer = bufnr,
          },
          {
            "]g",
            function()
              if vim.wo.diff then
                vim.cmd.normal({ "]g", bang = true })
              else
                gitsigns.nav_hunk("next")
              end
            end,
            desc = "Next hunk",
            buffer = bufnr,
          },
          {
            "]g",
            function()
              if vim.wo.diff then
                vim.cmd.normal({ "[c", bang = true })
              else
                gitsigns.nav_hunk("prev")
              end
            end,
            desc = "Previous hunk",
            buffer = bufnr,
          },
          {
            "<leader>ghs",
            gitsigns.stage_hunk,
            desc = "Stage",
            buffer = bufnr,
          },
          {
            "<leader>ghr",
            gitsigns.reset_hunk,
            desc = "Reset",
            buffer = bufnr,
          },
          {
            mode = "v",
            "<leader>ghs",
            function()
              gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
            end,
            buffer = bufnr,
          },
          {
            mode = "v",
            "<leader>ghr",
            function()
              gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
            end,
            buffer = bufnr,
          },
          {
            "<leader>gbs",
            gitsigns.stage_buffer,
            desc = "Stage",
            buffer = bufnr,
          },
          {
            "<leader>gbr",
            gitsigns.reset_buffer,
            desc = "Reset",
            buffer = bufnr,
          },
          {
            "<leader>ghp",
            gitsigns.preview_hunk,
            desc = "Preview",
            buffer = bufnr,
          },
          {
            "<leader>ghP",
            gitsigns.preview_hunk_inline,
            desc = "Preview Inline",
            buffer = bufnr,
          },
          {
            "<leader>ghb",
            function()
              gitsigns.blame_line({ full = true })
            end,
            desc = "Blame",
            buffer = bufnr,
          },
        })
      end,
    },
  },
}
