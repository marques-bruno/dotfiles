return {
  -- IF YOU GET AN ERROR SUCH AS "ERROR DETECTED WHILE PROCESSING BufREadPost....., run :TSUpdate tree-sitter-gitcommit in a new nvim session and restart nvim
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
    },
    config = function()
      require('gitsigns').setup()
      vim.keymap.set('n', '<leader>gp', ':Gitsigns prev_hunk<CR>', {})
      vim.keymap.set('n', '<leader>gn', ':Gitsigns next_hunk<CR>', {})
      vim.keymap.set('n', '<leader>gh', ':Gitsigns preview_hunk<CR>', {})
      vim.keymap.set('n', '<leader>gt', ':Gitsigns toggle_current_line_blame<CR>', {})
    end,
  },
  {
    'tpope/vim-fugitive',
    vim.keymap.set('n', '<leader>gs', ':Git<CR>', {}),
    vim.keymap.set('n', '<leader>gb', ':Git blame<CR>', {}),
  },
}
