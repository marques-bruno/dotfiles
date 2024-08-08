--[[
@author		: Bruno MARQUES (bmarques68@gmail.com)
@created	: 19/07/2024
@filename	: cmake-tools.lua
]]

return {
  'cdelledonne/vim-cmake',
  config = function()
    vim.g.cmake_link_compile_commands = 1
  end,
}
