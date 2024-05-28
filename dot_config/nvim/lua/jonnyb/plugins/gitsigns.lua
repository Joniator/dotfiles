return {
  { -- Adds git related signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        local function gsmap(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        gsmap('n', ']h', function()
          if vim.wo.diff then
            return ']h'
          end
          vim.schedule(function()
            gs.next_hunk()
          end)
          return '<Ignore>'
        end, { expr = true })

        gsmap('n', '[h', function()
          if vim.wo.diff then
            return '[h'
          end
          vim.schedule(function()
            gs.prev_hunk()
          end)
          return '<Ignore>'
        end, { expr = true })

        -- Actions
        gsmap('n', '<leader>ghs', gs.stage_hunk, { desc = '[G]it [H]unk [S]tage' })
        gsmap('n', '<leader>ghr', gs.reset_hunk, { desc = '[G]it [H]unk [R]eset' })
        gsmap('v', '<leader>ghs', function()
          gs.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
        end, { desc = '[G]it [H]unk [S]tage' })
        gsmap('v', '<leader>ghr', function()
          gs.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
        end, { desc = '[G]it [H]unk [R]eset' })
        gsmap('n', '<leader>ghS', gs.stage_buffer, { desc = '[G]it [H]unk [S]tage Buffer' })
        gsmap('n', '<leader>ghu', gs.undo_stage_hunk, { desc = '[G]it [H]unk [U]ndo' })
        gsmap('n', '<leader>ghR', gs.reset_buffer, { desc = '[G]it [H]unk [R]eset Buffer' })
        gsmap('n', '<leader>ghp', gs.preview_hunk, { desc = '[G]it [H]unk [P]review' })
        gsmap('n', '<leader>ghb', function()
          gs.blame_line { full = true }
        end, { desc = '[G]it [H]unk [B]lame' })
        gsmap('n', '<leader>ghtb', gs.toggle_current_line_blame, { desc = '[G]it [H]unk [T]oggle Line [B]lame' })
        gsmap('n', '<leader>ghd', gs.diffthis, { desc = '[G]it [H]unk [D]iff' })
        gsmap('n', '<leader>ghD', function()
          gs.diffthis '~'
        end, { desc = '[G]it [H]unk [D]iff all' })
        gsmap('n', '<leader>ghtd', gs.toggle_deleted, { desc = '[G]it [H]unk [T]oggle [D]eleted' })

        -- Text object
        gsmap({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>', { desc = 'inner hunk' })
      end,
    },
  },
}
