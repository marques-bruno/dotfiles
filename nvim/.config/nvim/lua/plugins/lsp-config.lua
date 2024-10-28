return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup({
        ensure_installed = {
          "stylua", "lua_ls", -- lua
          "black",
          "isort", -- python
          "python",
          "codelldb",
        },
      })
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls",
          "pyright",
        },
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require("lspconfig")

      -- This is the capabilities coming from the hrsh7th/cmp-nvim-lsp plugin loaded in completions.lua
      local cmp = require("cmp_nvim_lsp").default_capabilities()

      lspconfig.lua_ls.setup({ capabilities = cmp })
      lspconfig.pyright.setup({ capabilities = cmp })

      local map = function(keys, func, desc)
        vim.keymap.set("n", keys, func, { desc = "LSP: " .. desc })
      end

      -- Jump to the definition of the word under your cursor.
      --  This is where a variable was first declared, or where a function is defined, etc.
      --  To jump back, press <C-t>.
      map("gd", require("telescope.builtin").lsp_definitions, "[g]oto [d]efinition")

      -- Jump to the type of the word under your cursor.
      --  Useful when you're not sure what type a variable is and you want to see
      --  the definition of its *type*, not where it was *defined*.
      map("gt", require("telescope.builtin").lsp_type_definitions, "[g]oto [t]ype def.")

      -- Find references for the word under your cursor.
      map("gr", require("telescope.builtin").lsp_references, "[g]oto [r]eferences")

      -- Jump to the implementation of the word under your cursor.
      --  Useful when your language has ways of declaring types without an actual implementation.
      map("gI", require("telescope.builtin").lsp_implementations, "[g]oto [I]mplementation")

      -- Fuzzy find all the symbols in your current document.
      --  Symbols are things like variables, functions, types, etc.
      map("gsd", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")

      -- Fuzzy find all the symbols in your current workspace.
      --  Similar to document symbols, except searches over your entire project.
      map("gsw", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

      -- Rename the variable under your cursor.
      --  Most Language Servers support renaming across files, etc.
      map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")

      -- Execute a code action, usually your cursor needs to be on top of an error
      -- or a suggestion from your LSP for this to activate.
      map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

      -- Opens a popup that displays documentation about the word under your cursor
      --  See `:help K` for why this keymap.
      map("<space>cd", vim.lsp.buf.hover, "LSP: Hover [D]ocumentation")

      -- WARN: This is not Goto Definition, this is Goto Declaration.
      --  For example, in C this would take you to the header.
      map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

      -- map('<space>cp', vim.lsp.buf, 'LSP: [P]eek at definition')
      -- The following two autocommands are used to highlight references of the
      -- word under your cursor when your cursor rests there for a little while.
      --    See `:help CursorHold` for information about when this is executed
    end,
  },
  {
    "ray-x/lsp_signature.nvim",
    config = function()
      local lsp_signature = require("lsp_signature")

      lsp_signature.setup({
        bind = true, -- Bind signature help to a key
        handler_opts = {
          border = "rounded" -- Set the border style for the floating window
        },
        hint_prefix = '👀 '
      })
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local bufnr = args.buf
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if client then
            lsp_signature.on_attach({ bind = true }, bufnr)
          end
        end,
      })
    end,
  },
}
