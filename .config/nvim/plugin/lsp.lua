local lspconfig = require("lspconfig")
local util = require("lspconfig/util")

require("mason").setup()
require("mason-lspconfig").setup({
	-- list of LSP which can be installed automatically
	-- https://github.com/williamboman/mason-lspconfig.nvim?tab=readme-ov-file#available-lsp-servers
	ensure_installed = {
		-- js/ts
		"eslint",
    "tsserver",
		-- "typescript-language-server",
		-- go
		"gopls",
		-- python
    "pylsp",
		"ruff_lsp",
		"pyright",
		-- rust
		"rust_analyzer",
		-- lua
		"lua_ls",
		-- solidity
		-- "nomicfoundation-solidity-language-server",
		"solidity_ls_nomicfoundation",
		-- move
		"move_analyzer",
		-- other
		"jsonls",
	},
	handlers = {
		function(server)
			local opt = {
				capabilities = require("cmp_nvim_lsp").default_capabilities(
					vim.lsp.protocol.make_client_capabilities()
				),
			}
			lspconfig[server].setup({})
		end,
	},
})

lspconfig.solidity.setup({
	cmd = { "nomicfoundation-solidity-language-server", "--stdio" },
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

require("lspsaga").setup({
	lightbulb = {
		-- enable = false,
		sign = false,
		virtual_text = false,
	},
	-- border_style = "rounded",
	-- show_outline = {
	--   win_width = 50,
	--   auto_preview = false,
	-- },
})

keymap("n", "<Leader>h", "<cmd>Lspsaga hover_doc<CR>")
keymap("n", "<Leader>r", "<cmd>Lspsaga finder<CR>")
keymap("n", "<Leader>t", "<cmd>Lspsaga term_toggle<CR>")
keymap("t", "<ESC><ESC>", "<C-\\><C-N><cmd>Lspsaga term_toggle<CR>")
keymap("n", "<Leader>o", "<cmd>Lspsaga outline<CR>")
keymap("n", "<Leader>ic", "<cmd>Lspsaga incoming_calls<CR>")
keymap("n", "<Leader>oc", "<cmd>Lspsaga outgoing_calls<CR>")
keymap("n", "<Leader>m", "<cmd>Lspsaga show_line_diagnostics<CR>")

local opts = { noremap = true, silent = true, buffer = bufnr }
keymap("n", "<Leader>d", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
keymap("n", "<Leader>i", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
keymap("n", "<Leader>td", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
keymap("n", "<C-f>", "<cmd>lua vim.lsp.buf.format {async=true}<CR>", opts)

local null_ls = require("null-ls")
null_ls.setup({
	-- none-ls doesn't support some formatter/linter, check this link before adding new sources
	-- https://github.com/nvimtools/none-ls.nvim/discussions/81
	-- Deprecated sources might be supported via "nvimtools/none-ls-extras.nvim"
	-- usage:
	-- sources = {
	--   require("none-ls.diagnostics.eslint"), -- the way to add unsupported source
	-- }
	sources = {
		-- lua
		null_ls.builtins.formatting.stylua,

		-- js/ts
		null_ls.builtins.formatting.prettier,

		-- python
		null_ls.builtins.formatting.black, -- python formatter
		null_ls.builtins.formatting.isort, -- python import sort

		-- solidity
    -- null_ls.builtins.formatting.solhint,
	},
})
require("mason-null-ls").setup({
	ensure_installed = nil,
	automatic_installation = true,
})
