return {
	{
		"nvim-telescope/telescope.nvim",
		version = "0.1.4",
		dependencies = { "nvim-lua/plenary.nvim" },
		event = "VeryLazy",
		config = function(_, opts)
			local actions = require("telescope.actions")
			require("telescope").setup({
				defaults = {
					mappings = {
						i = {
							["<esc>"] = actions.close,
							["<C-c>"] = actions.close,
						},
						n = {
							["<esc>"] = actions.close,
							["<C-c>"] = actions.close,
						},
					},
				},
			})

			require("telescope").load_extension("dir")

			local builtin = require("telescope.builtin")
			local keymap = vim.keymap.set
			keymap("n", "<Leader>fd", ":Telescope dir live_grep<CR>", { silent = true })
			keymap("n", "<Leader>ff", builtin.find_files)
			keymap("n", "<Leader>fg", builtin.live_grep)
			keymap("n", "<Leader>fb", builtin.buffers)
			keymap("n", "<Leader>fh", builtin.help_tags)
		end,
	},
	{
		"princejoogie/dir-telescope.nvim",
		dependencies = { "nvim-telescope/telescope.nvim" },
		event = "VeryLazy",
		config = function()
			require("dir-telescope").setup({
				hidden = true,
				no_ignore = false,
			})
		end,
	},
}
