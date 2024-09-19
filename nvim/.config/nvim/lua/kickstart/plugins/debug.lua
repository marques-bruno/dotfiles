-- debug.lua
--
-- Shows how to use the DAP plugin to debug your code.
--
-- Primarily focused on configuring the debugger for Go, but can
-- be extended to other languages as well. That's why it's called
-- kickstart.nvim and not kitchen-sink.nvim ;)

return {
  'mfussenegger/nvim-dap',
  event = 'VeryLazy',
  dependencies = {
    'rcarriga/nvim-dap-ui',

    -- Lets you set a lua file in your project repository (.nvim/nvim-dap.lua)
    -- containing your dap configuration:
    -- 'ldelossa/nvim-dap-projects',

    -- Required dependency for nvim-dap-ui
    'nvim-neotest/nvim-nio',

    -- Installs the debug adapters for you
    'williamboman/mason.nvim',
    'jay-babu/mason-nvim-dap.nvim',

    -- Add your own debuggers here
    'mfussenegger/nvim-dap-python',
    'julianolf/nvim-dap-lldb',
  },
  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'

    require('mason-nvim-dap').setup {
      -- Makes a best effort to setup the various debuggers with
      -- reasonable debug configurations
      automatic_installation = true,

      -- You can provide additional configuration to the handlers,
      -- see mason-nvim-dap README for more information
      handlers = {},

      -- You'll need to check that you have the required things installed
      -- online, please don't ask me how to install them :)
      ensure_installed = {
        -- Update this to ensure that you have the debuggers for the langs you want
        'python',
	'codelldb',
      },
    }

    -- Basic debugging keymaps, feel free to change to your liking!
    vim.keymap.set('n', '<leader>dc', dap.continue, { desc = '▶/⏸ Start/[C]ontinue' })
    vim.keymap.set('n', '<leader>di', dap.step_into, { desc = '⏎ Step [I]nto' })
    vim.keymap.set('n', '<leader>do', dap.step_over, { desc = '⏭ Step [O]ver' })
    vim.keymap.set('n', '<leader>dO', dap.step_out, { desc = '⏮ Step [O]ut' })
    vim.keymap.set('n', '<leader>db', dap.toggle_breakpoint, { desc = 'Toggle [B]reakpoint' })
    vim.keymap.set('n', '<leader>dB', function()
      dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
    end, { desc = 'Set [B]reakpoint' })

    -- Dap UI setup
    -- For more information, see |:help nvim-dap-ui|
    dapui.setup {
      -- Set icons to characters that are more likely to work in every terminal.
      --    Feel free to remove or use ones that you like more! :)
      --    Don't feel like these are good choices.
      icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
      controls = {
        icons = {
          pause = '⏸',
          play = '▶',
          step_into = '⏎',
          step_over = '⏭',
          step_out = '⏮',
          step_back = 'b',
          run_last = '▶▶',
          terminate = '⏹',
          disconnect = '⏏',
        },
      },
    }

    -- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
    vim.keymap.set('n', '<F7>', dapui.toggle, { desc = 'Toggle DAP UI' })

    dap.listeners.after.event_initialized['dapui_config'] = dapui.open
    -- dap.listeners.before.event_terminated['dapui_config'] = dapui.close
    -- dap.listeners.before.event_exited['dapui_config'] = dapui.close
    -- dap.listeners.before.event_breakpoint['dapui_config'] = dapui.open

    -- Instruct nvim-dap to look for project debug config in workspace's nvim-dap.lua
    -- require('nvim-dap-projects').search_project_config()

    -- DAP-PYTHON config
    local venv = os.getenv 'VIRTUAL_ENV' or os.getenv 'CONDA_DEFAULT_ENV' or 'NO_VENV'
    require('dap-python').setup(venv .. '/bin/python')
    require('dap-python').test_runner = 'pytest'

    vim.keymap.set('n', '<leader>Dt', function()
      require('dap-python').test_method()
    end, { desc = 'Debug Python Test method' })
    -- FIX working directory for python debugger:
    dap.configurations.python = {
      {
        name = 'Python: Launch file',
        type = 'python',
        console = 'integratedTerminal',
        request = 'launch',
        program = '${file}',
        cwd = '${workspaceFolder}',
      },
      {
        name = 'Python: Launch file with arguments',
        type = 'python',
        console = 'integratedTerminal',
        request = 'launch',
        program = '${file}',
        cwd = '${workspaceFolder}',
        args = function()
          local text = vim.fn.input 'Arguments: '
          return Extract_args(text)
        end,
      },
    }

    local cfg = {
      configurations = {
        -- C lang configurations
        cpp = {
          {
            name = 'C++: a.out',
            type = 'lldb',
            request = 'launch',
            cwd = '${workspaceFolder}',
            program = 'a.out'
          },
        },
      },
    }
    require('dap-lldb').setup(cfg)
  end,
}
