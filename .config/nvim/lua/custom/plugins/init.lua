-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information

-- auto CD in project parent irectory (based on .git dir)
local function git_or_parent_dir()
  local dot_git_path = vim.fn.finddir('.git', '.;')
  if dot_git_path ~= '' then
    return vim.fn.fnamemodify(dot_git_path, ':p:h:h')
  end

  local parent_path = vim.fn.expand '%:p:h'
  return parent_path
end

local function cd_to_git_or_parent_dir()
  local dir = git_or_parent_dir()
  if vim.fn.bufname() == nil or vim.o.buftype ~= '' or vim.fn.isdirectory(dir) ~= 1 then
    return
  end
  vim.api.nvim_set_current_dir(vim.fn.fnameescape(dir))
end

vim.api.nvim_create_autocmd({ 'BufEnter', 'BufRead' }, {
  desc = 'Cd to git root or parent dir',
  pattern = '*',
  callback = cd_to_git_or_parent_dir,
  group = vim.api.nvim_create_augroup('AutoCdGitOrFileDir', {}),
})

vim.api.nvim_create_user_command('CdGitRoot', cd_to_git_or_parent_dir, {
  desc = 'Cd to git root or parent dir',
})

return {}
