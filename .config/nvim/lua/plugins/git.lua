return {
	{
		"NeogitOrg/neogit",
		dependencies = {
			"nvim-lua/plenary.nvim", -- required
			"sindrets/diffview.nvim", -- optional - Diff integration
			"nvim-telescope/telescope.nvim", -- optional
		},
		config = function()
			require("neogit").setup({
				kind = "vsplit",
				integrations = {
					diffview = true,
					telescope = true,
				},
			})

			vim.keymap.set("n", "<Leader>gi", ":Neogit<CR>", { silent = true })
		end,
	},
}
