call plug#begin('~/.config/nvim/plugged')
Plug 'preservim/nerdcommenter'
Plug 'joshdick/onedark.vim'
Plug 'vim-airline/vim-airline'
Plug 'airblade/vim-gitgutter'
call plug#end()

filetype plugin indent on

" Set completeopt to have a better completion experience
" menuone: pop up even when there's only one match
" noinsert: do not insert text until a selection is made
" noselect: do not automatically select, force user to select an option from the menu
set completeopt=menuone,noinsert,noselect
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

nmap <A-;> <plug>NERDCommenterToggle
let g:NERDSpaceDelims = 1  " Adds a space after the comment character itself

imap <C-G> <Esc>
vmap <C-G> <Esc>

" Select the last pasted text, similar to `gv`:
nnoremap <expr> gp '`[' . strpart(getregtype(), 0, 1) . '`]'

autocmd BufWritePre * call StripWhitespace()
function! StripWhitespace()
    let pos = getcurpos()
    %s/\s\+$//e " EOL
    %s#\($\n\s*\)\+\%$##e " EOF
    call setpos('.', pos)
endfunction
