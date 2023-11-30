filetype plugin indent on

set nocompatible

" setting
set fenc=utf-8
set nobackup
set noswapfile
set autoread
set hidden
set showcmd
set guifont=UbuntuMonoDerivativePowerline-Regular:16
set guifontwide=UbuntuMonoDerivativePowerline-Regular:16
set whichwrap=h,l
let mapleader = " "
inoremap jk <esc>
nnoremap $ $l
nnoremap J 10j
nnoremap K 10k
nnoremap H 10h
nnoremap L 10l
nnoremap j gj
nnoremap k gk

" truecolor on tmux
set termguicolors
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

set number
set cursorline
set virtualedit=onemore
set smartindent
set visualbell
set showmatch
set laststatus=2
set wildmode=list:longest
syntax enable
set ruler
set showcmd

set list
set listchars=trail:-,tab:>-,nbsp:%
set expandtab
set tabstop=2
set shiftwidth=2


" search
set ignorecase
set smartcase
set incsearch
set wrapscan
set hlsearch
nmap <Esc><Esc> :nohlsearch<CR><Esc>

" その他
set wildmenu
set clipboard+=unnamed
nnoremap <silent> sh <C-w>h
nnoremap <silent> sl <C-w>l
nnoremap <silent> sj <C-w>j
nnoremap <silent> sk <C-w>k
nnoremap <silent> sp :split<CR>
nnoremap <silent> sv :vsplit<CR>
nnoremap <silent> cl :close<CR>
nnoremap <silent> <Leader>q :qall<CR>
" shift-oで挿入なしの行追加
nnoremap O :<C-u>call append(expand('.'), '')<CR>j

" vim-plug
if has('vim_starting')
  set rtp+=~/.vim/plugged/vim-plug
  if !isdirectory(expand('~/.config/nvim/plugged/vim-plug'))
    echo 'install vim-plug...'
    call system('mkdir -p ~/.config/nvim/plugged/vim-plug')
    call system('git clone https://github.com/junegunn/vim-plug.git ~/.config/nvim/plugged/vim-plug/autoload')
  end
endif

" Plugin setting
call plug#begin('~/.config/nvim/plugged')
  Plug 'junegunn/vim-plug',{'dir': '~/.config/nvim/plugged/vim-plug/autoload'}
  Plug 'tpope/vim-fugitive'
  Plug 'morhetz/gruvbox'
  Plug 'myusuf3/numbers.vim'
  Plug 'jiangmiao/auto-pairs'
  Plug 'tpope/vim-repeat'
  Plug 'svermeulen/vim-easyclip'
  Plug 'rhysd/clever-f.vim'
  Plug 'tyru/open-browser.vim'
  Plug 'tpope/vim-surround'
call plug#end()
