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
		"ravitemer/mcphub.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		build = "npm install -g mcp-hub@latest", -- Installs `mcp-hub` node binary globally
		config = function()
			require("mcphub").setup({
				extensions = {
					avante = {
						make_slash_commands = true, -- make /slash commands from MCP server prompts
					},
				},
			})
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
			"ravitemer/mcphub.nvim",
		},
		event = "VeryLazy",
		build = "make",
		opts = {
			provider = "claude", -- openai, claude, gemini
			provides = {
				openai = {
					endpoint = "https://api.openai.com/v1",
					model = "gpt-4.1",
					timeout = 30000, -- Timeout in milliseconds, increase this for reasoning models
					extra_request_body = {
						temperature = 0,
						max_tokens = 32768,
						--reasoning_effort = "medium", -- low|medium|high, only used for reasoning models
					},
				},
				claude = {
					endpoint = "https://api.anthropic.com",
					model = "claude-sonnet-4-20250514",
					extra_request_body = {
						temperature = 0,
						-- max_tokens = 200000,
						max_tokens = 32000,
						-- disabled_tools = { "python" },
					},
				},
				gemini = {
					-- @see https://ai.google.dev/gemini-api/docs/models/gemini
					model = "gemini-2.5-pro-exp-03-25",
					-- model = "gemini-1.5-flash",
					extra_request_body = {
						temperature = 0,
						max_tokens = 1047576,
					},
				},
			},
			web_search_engine = {
				provider = "serpapi", -- tavily, serpapi, searchapi, google or kagi
			},
			-- system_prompt as function ensures LLM always has latest MCP server state
			-- This is evaluated for every message, even in existing chats
			system_prompt = function()
				local hub = require("mcphub").get_hub_instance()
				return hub and hub:get_active_servers_prompt() or ""
			end,
			-- Using function prevents requiring mcphub before it's loaded
			custom_tools = function()
				return {
					require("mcphub.extensions.avante").mcp_tool(),
				}
			end,
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
