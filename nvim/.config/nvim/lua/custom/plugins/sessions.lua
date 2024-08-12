--[[
@author		: Bruno MARQUES (bmarques68@gmail.com)
@created	: 18/07/2024
@filename	: sessions.lua
]]

return {
  'rmagatti/auto-session',
  config = function()
    require('auto-session').setup {
      auto_restore_enabled = false,
      -- auto_session_suppress_dir = { '~/', '~/dev', '/' },
      session_lens = {
        load_on_setup = true,
        theme_conf = { border = true },
        previewer = true,
      },
      vim.keymap.set('n', '<leader>sS', require('auto-session.session-lens').search_session, { desc = '[s]earch [S]ession' }),
    }
  end,
}
