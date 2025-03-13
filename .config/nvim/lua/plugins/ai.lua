return {
	{
		"github/copilot.vim",
		event = "VeryLazy",
		opts = {},
		config = function(_, opts)
			vim.keymap.set("n", "<Leader>aion", ":Copilot panel<CR>")
			vim.keymap.set("n", "<Leader>aioff", ":Copilot disable<CR>")
			vim.cmd([[
        let g:copilot_filetypes = {
        \ 'move': v:false,
        \ }
      ]])
		end,
	},
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		version = "v3.7.0",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"github/copilot.vim",
		},
		event = "VeryLazy",
		opts = {
			model = "claude-3.7-sonnet",
			debug = true,
			mapping = {
				complete = {
					insert = "",
				},
			},
		},
		config = function(_, opts)
			require("CopilotChat").setup(opts)

			local keymap = vim.keymap.set

			keymap("v", "<Leader>ai", function()
				vim.ui.input({ prompt = "Any help?" }, function(input)
					if input and input ~= "" then
						require("CopilotChat").ask(input, { selection = require("CopilotChat.select").visual })
					end
				end)
			end, { desc = "CopilotChat - Quick chat(visual)" })

			keymap("n", "<Leader>ai", ":CopilotChatOpen<CR>")

			local actions = require("CopilotChat.actions")
			keymap("n", "<Leader>aih", function()
				require("CopilotChat.integrations.telescope").pick(actions.prompt_actions())
			end, { desc = "CopilotChat - Help action" })
		end,
	},
	{
		"yetone/avante.nvim",
		branch = "main",
		dependencies = {
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
		event = "VeryLazy",
		build = "make",
		opts = {
			provider = "claude",
			claude = {
				endpoint = "https://api.anthropic.com",
				model = "claude-3-7-sonnet-20250219",
				temperature = 0,
				max_tokens = 4096,
			},
			web_search_engine = {
				provider = "serpapi", -- tavily, serpapi, searchapi, google or kagi
			},
		},
		config = function(_, opts)
			require("avante").setup(opts)
		end,
	},
	{
		"MeanderingProgrammer/render-markdown.nvim",
		opts = {
			file_types = { "markdown", "Avante" },
		},
		ft = { "markdown", "Avante" },
	},
}
