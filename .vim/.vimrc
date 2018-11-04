
colorscheme molokai
syntax enable

set ic
set tabstop=4
set softtabstop=4
"set expandtab

set number
set showcmd

set cursorline

set wildmenu
filetype indent on " load filetype indentation files 

set showmatch " hightlight matching {}
set incsearch
set hlsearch


" folding 
set  foldenable
set  foldlevelstart=10 " open folds by default
set foldnestmax=10
" space open/closes folds
nnoremap <space> za
