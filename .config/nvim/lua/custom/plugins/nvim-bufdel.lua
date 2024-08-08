--[[
@author		: marques-bruno (bmarques68@gmail.com)
@created	: 26/07/2024
@filename	: nvim-bufdel.lua
]]

-- Provides functions to kill buffers without closing the window / tab in which it is displayed
vim.keymap.set('n', '<C-b>d', '<cmd>BufDel<cr>', { desc = 'Delete current buffer' })
vim.keymap.set('n', '<C-b>D', '<cmd>BufDel!<cr>', { desc = 'Delete current buffer (force)' })

vim.keymap.set('n', '<C-b>o', '<cmd>BufDelOthers<cr>', { desc = 'Delete all but current buffer' })
vim.keymap.set('n', '<C-b>O', '<cmd>BufDelOthers!<cr>', { desc = 'Delete all but current buffer (force)' })

return {
  'ojroques/nvim-bufdel',
}
