--[[
@author		: Bruno MARQUES (bmarques68@gmail.com)
@created	: 18/07/2024
@filename	: which-key.lua
]]

return {
  -- Useful plugin to show you pending keybinds.
  'folke/which-key.nvim',
  event = 'VeryLazy', -- Sets the loading event to 'VimEnter'

  opts = {},
  -- keys = {
  --   {
  --     '<leader>?',
  --     function()
  --       require('which-key').show { global = false }
  --     end,
  --     desc = 'Buffer Local Keymaps (which-key)',
  --   },
  -- },
  config = function() -- This is the function that runs, AFTER loading
    local wk = require 'which-key'
    wk.setup()

    -- Document existing key chains
    wk.add {
      { '<leader>b', group = '[b]uffers', hidden = true },
      { '<leader>c', group = '[c]ode' },
      { '<leader>d', group = '[d]ocument' },
      { '<leader>D', group = '[D]ebug' },
      { '<leader>r', group = '[r]ename' },
      { '<leader>s', group = '[s]earch' },
      { '<leader>w', group = '[w]orkspace' },
      { '<leader>g', group = '[g]it', icon = '' },
    }

    -- TODO: Make it possible to edit files relative to current buffer
    -- vim.keymap.set('n', ':erel', '<cmd>e %:p:h<Tab>')
    -- vim.api.nvim_create_user_command('E', 'e %:p:h', {})
    vim.keymap.set('c', '%r', function()
      return 'e ' .. vim.fn.expand '%:p:h'
    end, { expr = true })
  end,
}
