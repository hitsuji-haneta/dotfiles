local configs = require('nvim-treesitter.configs')

configs.setup {
  auto_install = true,
  ensure_installed = { "markdown_inline" },
  highlight = {
    enable = true,
  }
}
