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

	-- showing file name
	{
		"b0o/incline.nvim",
		event = "VeryLazy",
		config = function()
			local helpers = require("incline.helpers")
			local devicons = require("nvim-web-devicons")
			require("incline").setup({
				window = {
					padding = 0,
					margin = { horizontal = 0 },
				},
				render = function(props)
					local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
					if filename == "" then
						filename = "[No Name]"
					end
					local ft_icon, ft_color = devicons.get_icon_color(filename)
					local modified = vim.bo[props.buf].modified
					return {
						ft_icon and { " ", ft_icon, " ", guibg = ft_color, guifg = helpers.contrast_color(ft_color) }
							or "",
						" ",
						{ filename, gui = modified and "bold,italic" or "bold" },
						" ",
						guibg = "#44406e",
					}
				end,
			})
		end,
	},
}
