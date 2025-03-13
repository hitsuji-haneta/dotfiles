return {
	-- theme
	{
		"sainnhe/gruvbox-material",
		lazy = false,
		config = function()
			vim.cmd([[colorscheme gruvbox-material]])
			vim.cmd([[let g:gruvbox_material_background = 'soft']])
			vim.cmd([[let g:gruvbox_material_disable_italic_comment = '1']])
			vim.cmd("highlight Comment guifg=#928374 guibg=NONE gui=NONE cterm=NONE")
		end,
	},

	-- parser & syntax highlight
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		lazy = false,
		config = function()
			require("nvim-treesitter.configs").setup({
				auto_install = true,
				ensure_installed = { "markdown_inline" },
				highlight = {
					enable = true,
				},
			})
		end,
	},

	-- icons
	{ "nvim-tree/nvim-web-devicons", lazy = false },

	-- show indent lines
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		---@module "ibl"
		---@type ibl.config
		opts = {},
	},

	-- ui components
	{
		"MunifTanjim/nui.nvim",
		config = function()
			local function floating_input(opts, on_confirm)
				local Input = require("nui.input")
				local event = require("nui.utils.autocmd").event

				local input = Input({
					position = {
						row = "20%",
						col = "50%",
					},
					size = {
						width = 50,
					},
					border = {
						style = "rounded",
						text = {
							top = opts.prompt or " Input ",
							top_align = "center",
						},
					},
					win_options = {
						winhighlight = "Normal:Normal,FloatBorder:Normal",
					},
				}, {
					prompt = "",
					default_value = opts.default,
					on_close = function()
						on_confirm(nil)
					end,
					on_submit = function(value)
						on_confirm(value)
					end,
				})

				input:mount()

				input:on(event.BufLeave, function()
					input:unmount()
				end)

				return input
			end

			vim.ui.input = function(opts, on_confirm)
				floating_input(opts, on_confirm)
			end
		end,
	},

	-- syntax highlight for move lang
	{ "rvmelkonian/move.vim" },
}
