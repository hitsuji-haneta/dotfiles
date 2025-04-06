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
				commit_editor = {
					kind = "split",
				},
			})

			vim.keymap.set("n", "<Leader>gi", ":Neogit<CR>", { silent = true })
		end,
	},
}
