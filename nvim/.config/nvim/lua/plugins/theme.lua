return {
	-- THEMEING
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 1000,
	opts = {
		transparent_background = true,
		custom_highlights = function(C)
			local O = require("catppuccin").options

			return {
				NeoTreeWinSeparator = { fg = C.base, bg = C.base },
				WinBarNC = { fg = C.text, bg = O.transparent_background and C.mantle },
				WinBar = { fg = C.text, bg = O.transparent_background and C.surface0 },
				WinSeparator = { fg = O.transparent_background and C.surface0 or C.crust },
				TabLineSel = { bg = O.transparent_background and C.surface1 },
				FloatBorder = { fg = C.mauve },
				LineNrAbove = { fg = C.surface2 },
				LineNrBelow = { fg = C.surface2 },
			}
		end,
	},
	init = function()
		vim.cmd.colorscheme("catppuccin-mocha")

		-- FIX lsp popup window borders
		local _border = "rounded"
		vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
			border = _border,
		})
		vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
			border = _border,
		})
		vim.diagnostic.config({
			float = { border = _border },
		})

		require("lspconfig.ui.windows").default_options = {
			border = _border,
		}
	end,
}
