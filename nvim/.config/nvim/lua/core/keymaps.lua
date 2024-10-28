local map = vim.keymap.set

-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Better split navigation
map('n', '<C-h>', '<C-w>h', { desc = 'Go to left window', remap = true })
map('n', '<C-j>', '<C-w>j', { desc = 'Go to lower window', remap = true })
map('n', '<C-k>', '<C-w>k', { desc = 'Go to upper window', remap = true })
map('n', '<C-l>', '<C-w>l', { desc = 'Go to right window', remap = true })

-- Resize splits with arrow keys
map('n', '<C-Up>', '<cmd>resize +2<CR>', { desc = 'Increase window height' })
map('n', '<C-Down>', '<cmd>resize -2<CR>', { desc = 'Decrease window height' })
map('n', '<C-Left>', '<cmd>vertical resize -2<CR>', { desc = 'Decrease window width' })
map('n', '<C-Right>', '<cmd>vertical resize +2<CR>', { desc = 'Increase window width' })

vim.keymap.set('n', '[b', '<cmd>bp<cr>', { desc = 'Goto previous buffer' })
vim.keymap.set('n', ']b', '<cmd>bn<cr>', { desc = 'Goto next buffer' })

vim.keymap.set('n', '[t', '<cmd>tabp<cr>', { desc = 'Goto previous tab' })
vim.keymap.set('n', ']t', '<cmd>tabn<cr>', { desc = 'Goto next tab' })

-- Jump to diagnostics
---@param next boolean
---@param severity? string|integer
---@return function
local function diagnostic_goto(next, severity)
  local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
  severity = severity and vim.diagnostic.severity[severity] or nil
  return function()
    go({ severity = severity })
  end
end

-- map('n', '[d', vim.diagnostic.goto_prev, { desc = 'Previous Diagnostic' })
-- map('n', ']d', vim.diagnostic.goto_next, { desc = 'Next Diagnostic' })
map('n', ']e', diagnostic_goto(true, 'ERROR'), { desc = 'Next Error' })
map('n', '[e', diagnostic_goto(false, 'ERROR'), { desc = 'Prev Error' })
map('n', ']w', diagnostic_goto(true, 'WARN'), { desc = 'Next Warning' })
map('n', '[w', diagnostic_goto(false, 'WARN'), { desc = 'Prev Warning' })

-- TODO: Make it possible to edit files relative to current buffer
vim.keymap.set('c', '%r', function()
  return 'e ' .. vim.fn.expand '%:p:h' .. '/'
end, { expr = true })

