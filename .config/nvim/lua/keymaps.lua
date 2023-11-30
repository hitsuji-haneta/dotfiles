keymap = vim.keymap.set
local opts = { silent = true }

-- Leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- General operation
keymap("i", "jk", "<ESC>", opts)
keymap("n", "<Leader>q", ":qall<CR>", opts)

-- Move
keymap("n", "J", "10j", opts)
keymap("n", "K", "10k", opts)
keymap("n", "H", "10h", opts)
keymap("n", "L", "10l", opts)
keymap("n", "j", "gj", opts)
keymap("n", "k", "gk", opts)
keymap("n", "$", "$l", opts)
keymap("n", "O", ":<C-u>call append(expand('.'), '')<CR>j", opts)

-- Search
keymap("n", "<ESC><ESC>", ":nohlsearch<CR><ESC>", opts)

-- Screen
keymap("n", "sh", "<C-w>h", opts)
keymap("n", "sl", "<C-w>l", opts)
keymap("n", "sj", "<C-w>j", opts)
keymap("n", "sk", "<C-w>k", opts)
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-l>", "<C-w>l", opts)
keymap("n", "sp", ":split<CR>", opts)
keymap("n", "sv", ":vsplit<CR>", opts)
keymap("n", "cl", ":close<CR>", opts)

-- Buffer
keymap("n", "<C-j>", ":bprev<CR>", opts)
keymap("n", "<C-k>", ":bnext<CR>", opts)
vim.cmd([[
  function! BufferDelete()
      if &modified
          echohl ErrorMsg
          echomsg "No write since last change. Not closing buffer."
          echohl NONE
      else
          let s:total_nr_buffers = len(filter(range(1, bufnr('$')), 'buflisted(v:val)'))

          if s:total_nr_buffers == 1
              bdelete
              echo "Buffer deleted. Created new buffer."
          else
              bprevious
              bdelete #
              echo "Buffer deleted."
          endif
      endif
  endfunction
  command! -bang BufferDelete call BufferDelete()
  nmap <C-d> :BufferDelete<CR> 
]])
