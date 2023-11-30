keymap("n", "<Leader>/", "<Plug>NERDCommenterToggle", { silent = true })
keymap("v", "<Leader>/", "<Plug>NERDCommenterToggle", { silent = true })
vim.cmd([[let g:NERDSpaceDelims = 1]])
vim.cmd([[let g:NERDCommentEmptyLines = 1]])
vim.cmd([[let g:NERDDefaultAlign = 'left']])
vim.cmd([[let g:NERDCustomDelimiters = { 'solidity': { 'left': '//' }}]])