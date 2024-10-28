return {
	"v1nh1shungry/cppman.nvim",
	event = "VeryLazy", -- Sets the loading event to 'VimEnter'
	ft = { "c", "cpp" },
	dependencies = "nvim-telescope/telescope.nvim", -- optional, if absent `vim.ui.select()` will be used
	config = function()
		local cppman = require("cppman")
		cppman.setup({
			position = "split",
			index_db_path = "$HOME/.cache/cppman/index.db",
		})

		-- Make a keymap to open the word under cursor in CPPman
		vim.keymap.set("n", "<leader>cm", function()
			cppman.open_cppman_for(vim.fn.expand("<cword>"))
		end, { desc = "open symbol in cppman" })

		vim.keymap.set("n", "<leader>sc", cppman.search, { desc = "[s]earch [c]ppReference" })
	end,
}
