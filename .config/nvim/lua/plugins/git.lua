return {
  {
    "sindrets/diffview.nvim",
    config = function()
      vim.keymap.set("n", "<Leader>gi", ":DiffviewOpen<CR>", { silent = true })
      vim.keymap.set("n", "<Leader>gc", ":DiffviewClose<CR>", { silent = true })
      vim.keymap.set("n", "<Leader>gh", ":DiffviewFileHistory<CR>", { silent = true })
    end,
  },
  {
    "tpope/vim-fugitive",
    config = function()
    end,
  },
}
