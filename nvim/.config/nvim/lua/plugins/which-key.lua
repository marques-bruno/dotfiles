return {
	-- Useful plugin to show you pending keybinds.
	"folke/which-key.nvim",
	event = "VeryLazy", -- Sets the loading event to 'VimEnter'

	opts = {},
	-- keys = {
	--   {
	--     '<leader>?',
	--     function()
	--       require('which-key').show { global = false }
	--     end,
	--     desc = 'Buffer Local Keymaps (which-key)',
	--   },
	-- },
	config = function() -- This is the function that runs, AFTER loading
		local wk = require("which-key")
		wk.setup()

		-- Document existing key chains
		wk.add({
			{ "<leader>b", group = "[b]uffers", icon = ' ' },
			{ "<leader>c", group = "[c]ode", icon = ' ' },
			{ "<leader>D", group = "[d]ocument", icon = ' ' },
			{ "<leader>d", group = "[D]ebug", icon = ' ' },
			{ "<leader>ds", group = "[S]tack", icon = ' ' },
			{ "<leader>r", group = "[r]ename", icon = '󰑕 ' },
			{ "<leader>s", group = "[s]earch", icon = ' ' },
			{ "<leader>w", group = "[w]orkspace", icon = '󰯉 ' },
			{ "<leader>g", group = " [g]it", icon = "󰊢 " },
		})
	end,
}
