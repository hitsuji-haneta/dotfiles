local lspconfig = require("lspconfig")
local util = require("lspconfig/util")
lspconfig.solidity.setup({
	cmd = { "solidity-ls", "--stdio" },
	filetypes = { "solidity" },
	-- on_attach = on_attach, -- probably you will need this.
	-- capabilities = capabilities,
	root_dir = util.root_pattern(
		"hardhat.config.js",
		"hardhat.config.ts",
		"foundry.toml",
		"remappings.txt",
		"truffle.js",
		"truffle-config.js",
		"ape-config.yaml",
		".git",
		"package.json"
	),
	settings = {
		-- example of global remapping
		-- solidity = { includePath = '', remapping = { ["@OpenZeppelin/"] = 'OpenZeppelin/openzeppelin-contracts@4.6.0/' } }
	},
})
lspconfig.pyright.setup({
	settings = {
		python = {
			pythonPath = "/Users/hitsuji-haneta/.anyenv/envs/pyenv/shims/python",
		},
		pyright = {},
	},
})
lspconfig.move_analyzer.setup({})
lspconfig.tsserver.setup({
	on_attach = function(client, bufnr)
		client.resolved_capabilities.document_formatting = false
	end,
})

require("mason").setup()
require("mason-lspconfig").setup_handlers({
	function(server)
		local opt = {
			on_attach = function(client, bufnr)
				local opts = { noremap = true, silent = true, buffer = bufnr }
				keymap("n", "<C-f>", "<cmd>lua vim.lsp.buf.format {async=true}<CR>", { noremap = true, silent = false })

				keymap("n", "<Leader>d", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
				keymap("n", "gd", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
				keymap("n", "<Leader>i", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
				keymap("n", "<Leader>td", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
			end,
			capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities()),
		}
		lspconfig[server].setup(opt)
	end,
})

require("lspsaga").setup({
	lightbulb = {
		enabled = false,
		enable_in_insert = false,
		virtual_text = false,
	},
	-- border_style = "rounded",
	-- show_outline = {
	--   win_width = 50,
	--   auto_preview = false,
	-- },
})

keymap("n", "<Leader>h", "<cmd>Lspsaga hover_doc<CR>")
keymap("n", "<Leader>r", "<cmd>Lspsaga lsp_finder<CR>")
-- keymap("n", "<Leader>d", "<cmd>Lspsaga peek_definition<CR>")
keymap("n", "<Leader>ac", "<cmd>Lspsaga code_action<CR>")
keymap("n", "<Leader>rn", "<cmd>Lspsaga rename<CR>")
keymap("n", "<Leader>m", "<cmd>Lspsaga show_line_diagnostics<CR>")

local null_ls = require("null-ls")

null_ls.setup({
	debug = true,
	sources = {
		null_ls.builtins.completion.spell,

		null_ls.builtins.formatting.stylua,
		null_ls.builtins.formatting.eslint,
		null_ls.builtins.formatting.black, -- python formatter
		null_ls.builtins.formatting.isort, -- python import sort
		null_ls.builtins.formatting.stylua, -- lua formatter

		null_ls.builtins.diagnostics.flake8, -- python linter
		null_ls.builtins.diagnostics.eslint,
		null_ls.builtins.diagnostics.luacheck, -- lua linter
	},
})
