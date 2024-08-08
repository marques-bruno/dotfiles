--[[
@author		: marques-bruno (bmarques68@gmail.com)
@created	: 26/07/2024
@filename	: maximize.lua
]]

-- provides :Maximize to set a specific pane full screen

vim.keymap.set('n', '<C-b>z', '<cmd>Maximize<cr>', { desc = '[Zoom] Maximize / minimize current window' })
return {
  'declancm/maximize.nvim',
  config = true,
}
