
" enter the current millenium
set nocompatible

" enable syntax and filetype plugin
syntax enable
filetype plugin on

set path+=**  

colorscheme molokai

" /searching
set ic
set incsearch
set hlsearch
set showmatch

" tabs etc
set tabstop=2
set softtabstop=2
set expandtab
set shiftwidth=2

set number
set showcmd

set cursorline


" scrll with mouse
set mouse=a

" wildmenu is :<command> <Tab> completion
set wildmenu
set wildmode=longest:list,full
set wildignore+=*/node_modules/*

" map tabs swtiching to vim style naviagtion etc
map <C-t><up> :tabr<cr>
map <C-t><down> :tabl<cr>
map <C-l> :tabn<cr>
map <C-h> :tabp<cr>


" CtrlP Settings
" set ctrl window bigger
let g:ctrlp_match_window = 'min:4,max:999'
nnoremap <leader>. :CtrlPTag<cr>

"TAGS
set tags=./tags;
" search to tags with ctrlp

" keep cursor in middle of screen when moving around
nnoremap k kzz
nnoremap j jzz

" vim jsx work on .js
let g:jsx_ext_required = 0

"nnoremap <C-F>f <Plug>CtrlSFPrompt 
"nnoremap <C-F>n <Plug>CtrlSFCwordPath
"nnoremap <C-F>p <Plug>CtrlSFPwordPath

" vim-gitgutter
" git gutter revert a hunk
nmap <Leader>hr <Plug>GitGutterUndoHunk

" Nerd Tree
map <C-n> :NERDTreeToggle<CR>

" coc completion
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

"webpack resolver
autocmd FileType javascript nmap <buffer> gf <Plug>(enhanced-resolver-go-cursor)
nnoremap <C-f> :Ag  

" enable Ag silver searcher ---> brew install the_silver_searcher
command! -bang -nargs=* Ag call fzf#vim#ag(<q-args>, {'options': '--delimiter : --nth 4..'}, <bang>0)


set path=.,src,node_modules
set suffixesadd=.js,.jsx

" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

Plug 'ctrlpvim/ctrlp.vim'
Plug 'davidosomething/vim-enhanced-resolver', { 'do': 'npm install --global enhanced-resolve-cli' }
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'w0rp/ale'
Plug 'scrooloose/nerdtree'
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
Plug 'neoclide/coc.nvim', {'tag': '*', 'do': { -> coc#util#install()}}


call plug#end()


