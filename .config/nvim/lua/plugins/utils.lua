return {
	-- lua utility for neovim
	{ "nvim-lua/plenary.nvim", event = "VeryLazy" },

	-- comment
	{
		"preservim/nerdcommenter",
		event = "VeryLazy",
		opts = {},
		config = function(_, opts)
			local keymap = vim.keymap.set
			keymap("n", "<Leader>/", "<Plug>NERDCommenterToggle", { silent = true })
			keymap("v", "<Leader>/", "<Plug>NERDCommenterToggle", { silent = true })
			vim.cmd([[let g:NERDSpaceDelims = 1]])
			vim.cmd([[let g:NERDCommentEmptyLines = 1]])
			vim.cmd([[let g:NERDDefaultAlign = 'left']])
			vim.cmd([[let g:NERDCustomDelimiters = { 'solidity': { 'left': '//' }}]])
		end,
	},

	-- toggle relative number
	{
		"myusuf3/numbers.vim",
		event = "VeryLazy",
		config = function()
			local keymap = vim.keymap.set
			keymap("n", "<Leader>n", ":NumbersToggle<CR>")
		end,
	},

	-- browser
	{
		"tyru/open-browser.vim",
		event = "VeryLazy",
		config = function()
			local keymap = vim.keymap.set
			keymap("n", "<Leader>b", "<Plug>(openbrowser-smart-search)")
			keymap("v", "<Leader>b", "<Plug>(openbrowser-smart-search)")
		end,
	},

  -- code-viewer
	{
		"kristijanhusak/vim-carbon-now-sh",
		event = "VeryLazy",
		config = function()
			local keymap = vim.keymap.set
			keymap("v", "<Leader>sh", ":CarbonNowSh<CR>")
		end,
	},

	-- highlight
	{
		"t9md/vim-quickhl",
		event = "VeryLazy",
		config = function()
			local keymap = vim.keymap.set
			keymap("n", "<Leader>hl", "<Plug>(quickhl-manual-this)")
			keymap("v", "<Leader>hl", "<Plug>(quickhl-manual-this)")
			keymap("n", "<Leader>HL", "<Plug>(quickhl-manual-reset)")
			keymap("v", "<Leader>HL", "<Plug>(quickhl-manual-reset)")
		end,
	},

	-- markdown
	{
		"iamcco/markdown-preview.nvim",
		event = "VeryLazy",
		config = function()
			local keymap = vim.keymap.set
			keymap("n", "<Leader>md", "<Plug>MarkdownPreviewToggle")
			vim.cmd([[let g:mkdp_filetypes = ['markdown', 'md', 'puml', 'plantuml'] ]])
			vim.fn["mkdp#util#install"]()
		end,
	},
}
