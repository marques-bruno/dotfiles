-- TreeSitter analyses the AST of a buffer and feeds it to parsers.
-- These parsers can then indent, or highlight text within the buffer.
return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
  config = function()
    local ts = require('nvim-treesitter')
    ts.setup({
      auto_install = true,
      highlight = { enable = true },
      indent = { enable = true },
    })
  end,
}
