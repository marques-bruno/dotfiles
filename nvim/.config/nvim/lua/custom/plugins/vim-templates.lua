--[[
@author		: marques-bruno (bmarques68@gmail.com)
@created	: 26/07/2024
@filename	: vim-templates.lua
]]

local function get_output(cmd)
  local handle = io.popen(cmd)
  if handle ~= nil then
    local result = handle:read('*a'):sub(1, -2)
    handle:close()
    return result
  end
  return 'UNKNOWN'
end

local function get_name()
  local name = get_output 'git config --local user.name'
  if name == '' then
    name = get_output 'git config user.name'
    if name == '' then
      name = os.getenv 'USER'
    end
  end
  return name
end

vim.g.tmpl_search_paths = { '$HOME/.config/nvim/vim-templates/' }
vim.g.tmpl_author_name = get_name()
vim.g.tmpl_author_email = get_output 'git config user.email'

return {
  'tibabit/vim-templates',
}
