vim.cmd([[let g:fern#renderer = "nerdfont"]])
vim.cmd([[let g:fern#default_hidden = 1]])
keymap("n", "<C-e>", ":Fern . -drawer -reveal=%:p -width=30 -toggle<CR>", { silent = true })
keymap("n", "<Plug>(fern-close-drawer)", ":FernDo close -drawer -stay<CR>", { noremap = false })

local init_fern = function()
  vim.api.nvim_buf_set_keymap(0, "n", "o", "<Plug>(fern-action-open)<Plug>(fern-close-drawer)",
    { noremap = false, silent = true })
  vim.api.nvim_buf_set_keymap(0, "n", "O", "<Plug>(fern-action-open)<C-h>", { noremap = false })
  vim.api.nvim_buf_set_keymap(0, "n", "<CR>", "<Plug>(fern-action-open)<C-h>", { noremap = false })
  vim.api.nvim_buf_set_keymap(0, "n", "r", "<Plug>(fern-action-reload:all)", { noremap = false })
  vim.api.nvim_buf_set_keymap(0, "n", "L", "<Plug>(fern-action-enter)", { noremap = false })
  vim.api.nvim_buf_set_keymap(0, "n", "H", "<Plug>(fern-action-leave)", { noremap = false })
  vim.api.nvim_buf_set_keymap(0, "n", "c", "<Plug>(fern-action-cancel)", { noremap = false })
  vim.api.nvim_buf_set_keymap(0, "n", "C", "<Plug>(fern-action-copy)", { noremap = false })
  vim.api.nvim_buf_set_keymap(0, "n", "m", "<Plug>(fern-action-cancel)", { noremap = false })
  vim.api.nvim_buf_set_keymap(0, "n", "M", "<Plug>(fern-action-move)", { noremap = false })
  vim.api.nvim_buf_set_keymap(0, "n", "n", "<Plug>(fern-action-new-file)", { noremap = false })
  vim.api.nvim_buf_set_keymap(0, "n", "N", "<Plug>(fern-action-new-dir)", { noremap = false })
  vim.api.nvim_buf_set_keymap(0, "n", "p", "<Plug>(fern-action-preview:auto:toggle)", { noremap = false, silent = true })
  vim.api.nvim_buf_set_keymap(0, "n", "<C-l>", "<C-w>l", { noremap = true, silent = true })
  vim.api.nvim_buf_set_keymap(0, "n", "K", "10k", { noremap = true })
  vim.api.nvim_buf_set_keymap(0, "n", "s", "", { noremap = true })

  local opts = { silent = true }
  keymap("n", "J", "10j", opts)
  keymap("n", "K", "10k", opts)
  keymap("n", "sh", "<C-w>h", opts)
  keymap("n", "sl", "<C-w>l", opts)
  keymap("n", "sj", "<C-w>j", opts)
  keymap("n", "sk", "<C-w>k", opts)
  keymap("n", "<C-h>", "<C-w>h", opts)
  keymap("n", "<C-l>", "<C-w>l", opts)

  vim.fn['glyph_palette#apply']()
  vim.opt.number = false
end

vim.api.nvim_create_augroup("fern_config", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
  pattern = "fern",
  group = "fern_config",
  callback = init_fern,
})
