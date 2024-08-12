--[[
@author		: Bruno MARQUES (bmarques68@gmail.com)
@created	: 18/07/2024
@filename	: cppman.lua
]]

return {
  'v1nh1shungry/cppman.nvim',
  dependencies = 'nvim-telescope/telescope.nvim', -- optional, if absent `vim.ui.select()` will be used
  opts = {
    position = 'split',
    index_db_path = '$HOME/.cache/cppman/index.db',
  },
}
