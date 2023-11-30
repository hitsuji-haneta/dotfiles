local builtin = require('telescope.builtin')
local actions = require('telescope.actions')

require("telescope").setup {
  defaults = {
    mappings = {
      i = {
        ["<esc>"] = actions.close,
        ["<C-c>"] = actions.close
      },
      n = {
        ["<esc>"] = actions.close,
        ["<C-c>"] = actions.close
      },
    },
  },
  -- extensions = {
  --   fzf = {
  --     fuzzy = true,                    -- false will only do exact matching
  --     override_generic_sorter = true,  -- override the generic sorter
  --     override_file_sorter = true,     -- override the file sorter
  --     case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
  --                                      -- the default case_mode is "smart_case"
  --   },
  -- }
}
-- require('telescope').load_extension('fzf')
require("telescope").load_extension("dir")

keymap("n", "<Leader>fd", ":Telescope dir live_grep<CR>", { silent = true })
keymap('n', '<Leader>ff', builtin.find_files)
keymap('n', '<Leader>fg', builtin.live_grep)
keymap('n', '<Leader>fb', builtin.buffers)
keymap('n', '<Leader>fh', builtin.help_tags)
