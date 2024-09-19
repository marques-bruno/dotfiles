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

local function dump(o)
  if type(o) == 'table' then
    local s = '{ '

    for k, v in pairs(o) do
      if type(k) ~= 'number' then
        k = '"' .. k .. '"'
      end
      s = s .. '[' .. k .. '] = ' .. dump(v) .. ','
    end
    return s .. '} '
  else
    return tostring(o)
  end
end

function Show_dap_config(lang)
  local dap = require 'dap'
  for k, v in pairs(dap.configurations[lang]) do
    print(dump(v))
  end
end

vim.api.nvim_create_user_command('DapShow', Show_dap_config, { desc = 'Display the nvim-dap configuration for a given adapter' })

-- A function that tokenizes text as it would be done in a shell:
function Extract_args(text)
  local args = {}
  local spat, epat, buf, quoted = [=[^(['"])]=], [=[(['"])$]=]
  for str in text:gmatch '%S+' do
    local squoted = str:match(spat)
    local equoted = str:match(epat)
    local escaped = str:match [=[(\*)['"]$]=]
    if squoted and not quoted and not equoted then
      buf, quoted = str, squoted
    elseif buf and equoted == quoted and #escaped % 2 == 0 then
      str, buf, quoted = buf .. ' ' .. str, nil, nil
    elseif buf then
      buf = buf .. ' ' .. str
    end
    if not buf then
      table.insert(args, (str:gsub(spat, ''):gsub(epat, '')))
    end
  end
  if buf then
    print('Missing matching quote for ' .. buf)
  end
  return args
end

return {}
