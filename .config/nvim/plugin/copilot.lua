local keymap = vim.keymap.set

-- copilot
keymap("n", "<Leader>aion", ":Copilot panel<CR>")
keymap("n", "<Leader>aioff", ":Copilot disable<CR>")
vim.cmd([[
  let g:copilot_filetypes = {
  \ 'move': v:false,
  \ }
]])

-- copilot chat
require("CopilotChat").setup({
	model = "claude-3.7-sonnet",
	debug = true,
	mapping = {
		complete = {
			insert = "",
		},
	},
})

keymap("v", "<Leader>ai", function()
	vim.ui.input({ prompt = "Any help?" }, function(input)
		if input and input ~= "" then
			require("CopilotChat").ask(input, { selection = require("CopilotChat.select").visual })
		end
	end)
end, { desc = "CopilotChat - Quick chat(visual)" })

keymap("n", "<Leader>ai", ":CopilotChatOpen<CR>")

local actions = require("CopilotChat.actions")
keymap("v", "<Leader>aip", function()
	require("CopilotChat.integrations.telescope").pick(actions.prompt_actions({
		selection = require("CopilotChat.select").visual,
	}))
end, { desc = "CopilotChat - Prompt action" })

keymap("n", "<Leader>aih", function()
	require("CopilotChat.integrations.telescope").pick(actions.prompt_actions())
end, { desc = "CopilotChat - Help action" })


-- avante
require("avante").setup({
  provider = "claude",
  claude = {
    endpoint = "https://api.anthropic.com",
    model = "claude-3-7-sonnet-20250219",
    temperature = 0,
    max_tokens = 4096,
  },
})
