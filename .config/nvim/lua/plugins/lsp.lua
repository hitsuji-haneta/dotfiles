return {
  { "nanotee/sqls.nvim" },
  {
    "neovim/nvim-lspconfig",
    event = "VeryLazy",
    opts = {},
    config = function(_, opts)
      local lspconfig = require("lspconfig")
      local util = require("lspconfig/util")

      require('lspconfig').sqls.setup {
        on_attach = function(client, bufnr)
          require('sqls').on_attach(client, bufnr)
        end
      }
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
          solidity = {
            includePath = "",
            remapping = { ["@OpenZeppelin/"] = "OpenZeppelin/openzeppelin-contracts@4.6.0/" },
          },
        },
      })

      local keyopt = { noremap = true, silent = true, buffer = bufnr }
      keymap("n", "<Leader>d", "<cmd>lua vim.lsp.buf.definition()<CR>", keyopt)
      keymap("n", "<Leader>i", "<cmd>lua vim.lsp.buf.implementation()<CR>", keyopt)
      keymap("n", "<Leader>td", "<cmd>lua vim.lsp.buf.type_definition()<CR>", keyopt)
      keymap("n", "<C-f>", "<cmd>lua vim.lsp.buf.format {async=true}<CR>", keyopt)
    end,
  },
  {
    "williamboman/mason.nvim",
    event = "VeryLazy",
    build = ":MasonUpdate", -- :MasonUpdate updates registry contents
    opts = {},
    config = function(_, opts)
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    -- event = "VeryLazy",
    dependencies = {
      "neovim/nvim-lspconfig",
      "hrsh7th/cmp-nvim-lsp",
    },
    opts = {},
    config = function(_, opts)
      local lspconfig = require("lspconfig")
      require("mason-lspconfig").setup({
        -- list of LSP which can be installed automatically
        -- https://github.com/williamboman/mason-lspconfig.nvim?tab=readme-ov-file#available-lsp-servers
        ensure_installed = {
          -- js/ts
          "eslint",
          -- "tsserver",
          -- "typescript-language-server",

          -- go
          "gopls",

          -- python
          "pylsp",

          -- "ruff_lsp",
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

          -- sql,
          "sqls",

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
            lspconfig[server].setup(opt)
          end,
        },
      })
    end,
  },
  {
    "nvimdev/lspsaga.nvim",
    event = "VeryLazy",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {
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
    },
    config = function(_, opts)
      require("lspsaga").setup(opts)

      local keymap = vim.keymap.set
      keymap("n", "<Leader>h", "<cmd>Lspsaga hover_doc<CR>")
      keymap("n", "<Leader>r", "<cmd>Lspsaga finder<CR>")
      keymap("n", "<Leader>t", "<cmd>Lspsaga term_toggle<CR>")
      keymap("t", "<ESC><ESC>", "<C-\\><C-N><cmd>Lspsaga term_toggle<CR>")
      keymap("n", "<Leader>o", "<cmd>Lspsaga outline<CR>")
      keymap("n", "<Leader>ic", "<cmd>Lspsaga incoming_calls<CR>")
      keymap("n", "<Leader>oc", "<cmd>Lspsaga outgoing_calls<CR>")
      -- keymap("n", "<Leader>m", "<cmd>Lspsaga show_line_diagnostics<CR>")
      keymap("n", "<Leader>m", "<cmd>Lspsaga diagnostic_jump_prev<CR>")
      keymap("n", "<Leader>,", "<cmd>Lspsaga diagnostic_jump_next<CR>")
    end,
  },
  {
    "L3MON4D3/LuaSnip",
    version = "v2.*",
    event = "VeryLazy",
    run = "make install_jsregexp",
    opts = {},
    config = function(_, opts) end,
  },
  {
    "nvimtools/none-ls.nvim",
    dependencies = {
      "nvimtools/none-ls-extras.nvim",
      "nvim-lua/plenary.nvim",
    },
    event = "VeryLazy",
    config = function(_, opts)
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
    end,
  },
  {
    "jay-babu/mason-null-ls.nvim",
    event = "VeryLazy",
    opts = {
      ensure_installed = nil,
      automatic_installation = true,
    },
    config = function(_, opts)
      require("mason-null-ls").setup(opts)
    end,
  },
  --- diagnostic message
  {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "VeryLazy",
    config = function()
      require("tiny-inline-diagnostic").setup({
        preset = "powerline",
      })
      vim.diagnostic.config({ virtual_text = false })
    end,
  },
}
