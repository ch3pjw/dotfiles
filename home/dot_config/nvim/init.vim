call plug#begin('~/.config/nvim/plugged')
Plug 'joshdick/onedark.vim'
Plug 'vim-airline/vim-airline'
Plug 'airblade/vim-gitgutter'
call plug#end()

filetype plugin indent on

set hlsearch             " highlight searches
set incsearch            " 'incremental' searching: highlight search as you type it
set number               " show line numbers
set nocompatible         " disable vi compatibility

" Tab handling:
set autoindent
set expandtab            " turns tabs into spaces
set softtabstop=4        " makes backspace delete spaces as if tabs
set tabstop=4
set ttyfast              " speed up scrolling

colorscheme onedark

" highlight the line the cursor is currently on *in the currently active pane*
augroup CursorLine
  au!
  au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
  au WinLeave * setlocal nocursorline
augroup END
