set nu

"Set up colours nicely:
set t_Co=256
runtime! plugin plugin/guicolorscheme.vim
GuiColorScheme rdark

"Highlight trailing whitespace
highlight ExtraWhitespace ctermbg=red guibg=red
autocmd Syntax * syn match ExtraWhitespace /\s\+$\| \+\ze\t/

"Highlight 81st column
set colorcolumn=81
highlight ColorColumn ctermbg=red guibg=red

"Highlight overlength lines
highlight OverLength ctermbg=red guibg=red
match OverLength /\%81v.\+/

set smartindent
set autoindent
set tabstop=4
set shiftwidth=4
set expandtab
set wildmode=longest,list,full
set wildmenu
function InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-p>"
    endif
endfunction
inoremap <tab> <c-r>=InsertTabWrapper()<cr>
