-- easy-motion
vim.cmd([[let g:EasyMotion_keys = 'HKLYNMQERTGZXCJ']])
vim.cmd([[let g:EasyMotion_smartcase = 1]])
vim.cmd([[let g:EasyMotion_use_upper = 1]])
vim.cmd([[let g:EasyMotion_enter_jump_first = 1]])

keymap("n", "f", "<Plug>(easymotion-overwin-f)")
keymap("n", "ff", "<Plug>(easymotion-overwin-f2)")
keymap("n", "<Leader>l", "<Plug>(easymotion-overwin-f2)")
