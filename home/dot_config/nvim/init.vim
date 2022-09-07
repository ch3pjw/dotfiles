call plug#begin('~/.config/nvim/plugged')
" Collection of common configurations for nvim Language Server Protocol Clients:
Plug 'airblade/vim-gitgutter'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/vim-vsnip'
Plug 'joshdick/onedark.vim'
Plug 'lukas-reineke/virt-column.nvim'
Plug 'neovim/nvim-lspconfig'
Plug 'preservim/nerdcommenter'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline'
Plug 'Yggdroot/indentLine'
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

set colorcolumn=80
autocmd BufEnter *.rs set colorcolumn=120
lua <<EOF
  require('virt-column').setup { char = '▕'}
EOF
let g:indentLine_char = '┊'
map <A-\> :IndentLinesToggle<Cr>

map <A-;> <plug>NERDCommenterToggle
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

" Set completeopt to have a better completion experience
" menuone: pop up even when there's only one match
" noinsert: do not insert text until a selection is made
" noselect: do not automatically select, force user to select an option from the menu
set completeopt=menuone,noinsert,noselect

lua <<EOF
  local opts = { noremap=true, silent=true }
  vim.keymap.set('n', '<F8>', vim.diagnostic.goto_next, opts)
  vim.keymap.set('n', '<S-F8>', vim.diagnostic.goto_prev, opts)

  vim.o.updatetime = 250
  vim.cmd [[autocmd! CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]
  vim.api.nvim_create_autocmd("CursorHold", {
    buffer = bufnr,
    callback = function()
      local opts = {
        focusable = false,
        close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
        -- border = 'rounded',
        source = 'always',
        prefix = ' ',
        scope = 'cursor',
      }
      vim.diagnostic.open_float(nil, opts)
    end
  })

  local cmp = require'cmp'

  cmp.setup({
    snippet = {
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body)
      end
    },
    window = {},
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      -- `true` accepts currently selected item.
      -- Set `select` to `false` to only confirm explicitly selected items.
      ['<CR>'] = cmp.mapping.confirm({ select = false }),
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
    }, {
      { name = 'buffer' },
    })
  })

  -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline('/', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
  })

   -- Setup lspconfig.
  local capabilities = require('cmp_nvim_lsp').update_capabilities(
    vim.lsp.protocol.make_client_capabilities()
  )
  require'lspconfig'.pyright.setup{ capabilities = capabilities }
  require'lspconfig'.rust_analyzer.setup{ capabilities = capabilities }
EOF
