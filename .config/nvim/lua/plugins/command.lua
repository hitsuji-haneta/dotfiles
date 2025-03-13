return {
	-- motion
	{
		"easymotion/vim-easymotion",
		event = "VeryLazy",
		config = function()
			vim.cmd([[let g:EasyMotion_keys = 'HKLYNMQERTGZXCJ']])
			vim.cmd([[let g:EasyMotion_smartcase = 1]])
			vim.cmd([[let g:EasyMotion_use_upper = 1]])
			vim.cmd([[let g:EasyMotion_enter_jump_first = 1]])

			local keymap = vim.keymap.set
			keymap("n", "ff", "<Plug>(easymotion-overwin-f2)")
		end,
	},

	-- command support
	-- "mm" for move
	{ "svermeulen/vim-easyclip", event = "VeryLazy" },

	-- surround
	{ "machakann/vim-sandwich", event = "VeryLazy" },

	-- multi cursor
	{
		"mg979/vim-visual-multi",
		branch = "master",
		event = "VeryLazy",
	},

	-- autopairs
	{ "windwp/nvim-autopairs", event = "VeryLazy" },
}
