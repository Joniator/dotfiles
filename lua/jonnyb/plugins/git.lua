return {
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim",

      -- Only one of these is needed.
      "nvim-telescope/telescope.nvim", -- optional
    },
    config = function(_, opts)
      require("neogit").setup(opts)
      require("which-key").add({
        {
          "<leader>g",
          group = "git",
        },
        {
          "<leader>gg",
          ":Neogit<CR>",
          desc = "[S]earch [H]elp",
        },
      })
    end,
  },
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup({
        on_attach = function(bufnr)
          local gitsigns = require("gitsigns")

          require("which-key").add({
            {
              "<leader>g",
              group = "git",
            },
            {
              "<leader>gh",
              group = "hunk",
            },
            {
              "<leader>gb",
              group = "buffer",
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
            },
            {
              "<leader>ghs",
              gitsigns.stage_hunk,
              desc = "Stage",
            },
            {
              "<leader>ghr",
              gitsigns.reset_hunk,
              desc = "Reset",
            },
            {
              mode = "v",
              "<leader>ghs",
              function()
                gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
              end,
            },
            {
              mode = "v",
              "<leader>ghr",
              function()
                gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
              end,
            },
            {
              "<leader>gbs",
              gitsigns.stage_buffer,
              desc = "Stage",
            },
            {
              "<leader>gbr",
              gitsigns.reset_buffer,
              desc = "Reset",
            },
            {
              "<leader>ghp",
              gitsigns.preview_hunk,
              desc = "Preview",
            },
            {
              "<leader>ghP",
              gitsigns.preview_hunk_inline,
              desc = "Preview Inline",
            },
            {
              "<leader>ghb",
              function()
                gitsigns.blame_line({ full = true })
              end,
              desc = "Blame",
            },
            {
              "<leader>gtb",
              gitsigns.toggle_current_line_blame,
            },
            {
              "<leader>gtd",
              gitsigns.toggle_deleted,
            },
            {
              "<leader>gtw",
              gitsigns.toggle_word_diff,
            },
          })
        end,
      })
    end,
  },
}
