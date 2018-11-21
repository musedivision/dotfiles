
" enter the current millenium
set nocompatible

" enable syntax and filetype plugin
syntax enable
filetype plugin on

set path+=**  
set wildmenu

set wildignore+=*/node_modules/*

colorscheme molokai

"set ic
"set tabstop=4
"set softtabstop=4
"set expandtab

set number
"set showcmd

set cursorline

"set wildmenu
"filetype indent on " load filetype indentation files 


" add ctrl p 
set runtimepath^=~/.vim/bundle/ctrlp.vim

" map tabs swtiching to vim style naviagtion etc
map <C-t><up> :tabr<cr>
map <C-t><down> :tabl<cr>
map <C-l> :tabp<cr>
map <C-h> :tabn<cr>

"set showmatch " hightlight matching {}
"set incsearch
"set hlsearch


" folding 
"set  foldenable
"set  foldlevelstart=10 " open folds by default
"set foldnestmax=10
" space open/closes folds
"nnoremap <space> za





