--[[
@author		: Bruno MARQUES (bruno.marques@globallogic.com)
@created	: 28/08/2024
@filename	: neotest-python.lua
]]

return {
  {
    'nvim-neotest/neotest',
    dependencies = {
      'nvim-neotest/nvim-nio',
      'nvim-lua/plenary.nvim',
      'antoinemadec/FixCursorHold.nvim',
      'nvim-treesitter/nvim-treesitter',
    },
  },
  {
    'nvim-neotest/neotest-python',
    config = function()
      require('neotest').setup {
        adapters = {
          require 'neotest-python',
        },
      }
    end,
  },
}
