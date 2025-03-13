return {
	-- status line on bottom
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		event = "VeryLazy",
		config = function()
			require("lualine").setup({
				extensions = { "fern" },
				options = {
					theme = "gruvbox-material",
				},
			})
		end,
	},

	-- bufferline on top
	{
		"akinsho/bufferline.nvim",
		version = "v4.*",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		event = "VeryLazy",
		config = function()
			require("bufferline").setup({
				highlights = {
					buffer_selected = {
						fg = {
							attribute = "bg",
							highlight = "Normal",
						},
						bg = "#bdae93",
						bold = true,
					},
					buffer_visible = {
						fg = "#bdae93",
						bold = true,
					},
				},
				options = {
					show_buffer_close_icons = false,
					separator_style = "slant",
				},
			})
		end,
	},

	-- resize window
	{
		"simeji/winresizer",
		lazy = false,
		config = function()
			vim.cmd([[let g:winresizer_start_key = '<C-w>']])
		end,
	},
}
