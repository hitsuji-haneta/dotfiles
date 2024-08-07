vim.cmd([[highlight ColorColumn guibg=#202020 ctermbg=lightgrey]])
vim.cmd([[syntax enable]])
vim.api.nvim_exec('language en_US', true)
vim.cmd('command! Open silent exe "!open " . expand("%:p:h")') -- open dir

local options = {
  number = true,
  numberwidth = 4,
  langmenu = "en_US",
  fileencoding = "utf-8",
  backup = false,
  swapfile = false,
  autoread = true,
  hidden = true,
  showcmd = true,
  cursorline = true,
  colorcolumn = "100",
  virtualedit = "onemore",
  smartindent = true,
  visualbell = true,
  showmatch = true,
  laststatus = 3,
  wildmode = "list:longest",
  ruler = true,
  showcmd = true,
  list = true,
  listchars = true,
  listchars = "trail:-,tab:>-,nbsp:%",
  expandtab = true,
  tabstop = 2,
  shiftwidth = 2,
  ignorecase = true,
  smartcase = true,
  wrapscan = true,
  termguicolors = true,
  guifont = "UbuntuMonoDerivativePowerline-Regular:16",
  guifontwide = "UbuntuMonoDerivativePowerline-Regular:16",
  wildmenu = true,
  clipboard = "unnamedplus",
  background = "dark",
  mouse = "a",
  whichwrap = "h,l",
}

for k, v in pairs(options) do
  vim.opt[k] = v
end
