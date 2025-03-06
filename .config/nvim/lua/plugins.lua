local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
		vim.cmd([[packadd packer.nvim]])
		return true
	end
	return false
end

local packer_bootstrap = ensure_packer()

require("packer").startup(function(use)
	use("wbthomason/packer.nvim")
	use("nvim-lua/plenary.nvim") -- lua utility for neovim

	-- style
	use({
		"nvim-treesitter/nvim-treesitter",
		run = function()
			local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
			ts_update()
		end,
	})
	use("sainnhe/gruvbox-material")
	use("nvim-tree/nvim-web-devicons")
	use("lukas-reineke/indent-blankline.nvim")
	use("rvmelkonian/move.vim")
	use("MunifTanjim/nui.nvim")

	-- window
	use({
		"nvim-lualine/lualine.nvim",
		requires = { "kyazdani42/nvim-web-devicons", opt = true },
	})
	use({ "akinsho/bufferline.nvim", tag = "v4.*", requires = "nvim-tree/nvim-web-devicons" }) -- others

	-- filer
	use("lambdalisue/fern.vim")
	use("lambdalisue/nerdfont.vim")
	use("lambdalisue/fern-renderer-nerdfont.vim")
	use("lambdalisue/glyph-palette.vim")

	--markdown
	use({
		"iamcco/markdown-preview.nvim",
		run = function()
			vim.fn["mkdp#util#install"]()
		end,
	})

	-- motion
	use("easymotion/vim-easymotion")

	-- command support
	use("svermeulen/vim-easyclip") -- "mm" for move
	use("machakann/vim-sandwich")
	-- use 'haya14busa/incsearch.vim' -- highlight on regular expression search
	use({ "mg979/vim-visual-multi", branch = "master" }) -- multi cursol
	use("simeji/winresizer")
	use("windwp/nvim-autopairs")

	-- cmp
	use("hrsh7th/cmp-nvim-lsp")
	use("hrsh7th/cmp-buffer")
	use("hrsh7th/cmp-path")
	use("hrsh7th/cmp-cmdline")
	use("hrsh7th/nvim-cmp")
	use("onsails/lspkind.nvim")

	-- lsp
	use("neovim/nvim-lspconfig")
	use({
		"williamboman/mason.nvim",
		run = ":MasonUpdate", -- :MasonUpdate updates registry contents
	})
	use("williamboman/mason-lspconfig.nvim")
	use({
		"nvimdev/lspsaga.nvim",
		-- after = "nvim-lspconfig",
		config = function()
			require("lspsaga").setup({})
		end,
		requires = {
			{ "nvim-tree/nvim-web-devicons" },
			--Please make sure you install markdown and markdown_inline parser
			{ "nvim-treesitter/nvim-treesitter" },
		},
	})
	use({
		"L3MON4D3/LuaSnip",
		tag = "v<CurrentMajor>.*",
	})
	use({
		"nvimtools/none-ls.nvim",
		dependencies = {
			"nvimtools/none-ls-extras.nvim",
		},
		requires = { "nvim-lua/plenary.nvim" },
	})
	use("jay-babu/mason-null-ls.nvim")

	-- fuzzy finder
	use({
		"nvim-telescope/telescope.nvim",
		tag = "0.1.4",
		requires = { { "nvim-lua/plenary.nvim" } },
	})
	use({
		"princejoogie/dir-telescope.nvim",
		requires = { "nvim-telescope/telescope.nvim" },
		config = function()
			require("dir-telescope").setup({
				hidden = true,
				no_ignore = false,
			})
		end,
	})

	-- copilot / AI coding
	use("github/copilot.vim")
	use({
		"CopilotC-Nvim/CopilotChat.nvim",
		tag = "v3.7.0",
		requires = { "nvim-lua/plenary.nvim", "github/copilot.vim" },
	})
  use({
    "yetone/avante.nvim",
    branch = "main",
    requires = {
      "nvim-treesitter/nvim-treesitter",
      "stevearc/dressing.nvim",
      "MunifTanjim/nui.nvim",
      "MeanderingProgrammer/render-markdown.nvim",
      "hrsh7th/nvim-cmp",
      "nvim-tree/nvim-web-devicons",
      "HakonHarnes/img-clip.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-lua/popup.nvim",
    },
    run = "make",
  })

	-- others
	use("preservim/nerdcommenter") -- comment
	use("myusuf3/numbers.vim") -- toggle relative number
	use("tyru/open-browser.vim")
	use("kristijanhusak/vim-carbon-now-sh")
	use("t9md/vim-quickhl") -- highlight

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if packer_bootstrap then
		require("packer").sync()
	end
end)

------------------------------------
-- Configs
------------------------------------
local keymap = vim.keymap.set

-- theme
vim.cmd([[colorscheme gruvbox-material]])
vim.cmd([[let g:gruvbox_material_background = 'soft']])
vim.cmd([[let g:gruvbox_material_disable_italic_comment = '1']])
vim.cmd("highlight Comment guifg=#928374 guibg=NONE gui=NONE cterm=NONE")

-- numbers
keymap("n", "<Leader>n", ":NumbersToggle<CR>")

-- autopairs
require("nvim-autopairs").setup({})

-- winresizer
vim.cmd([[let g:winresizer_start_key = '<C-w>']])

-- markdown
keymap("n", "<Leader>md", "<Plug>MarkdownPreviewToggle")
vim.cmd([[let g:mkdp_filetypes = ['markdown', 'md', 'puml', 'plantuml'] ]])

-- browser
keymap("n", "<Leader>b", "<Plug>(openbrowser-smart-search)")
keymap("v", "<Leader>b", "<Plug>(openbrowser-smart-search)")

-- carbon-now-sh
keymap("v", "<Leader>sh", ":CarbonNowSh<CR>")

-- quickhl
keymap("n", "<Leader>hl", "<Plug>(quickhl-manual-this)")
keymap("v", "<Leader>hl", "<Plug>(quickhl-manual-this)")
keymap("n", "<Leader>HL", "<Plug>(quickhl-manual-reset)")
keymap("v", "<Leader>HL", "<Plug>(quickhl-manual-reset)")
