
" enter the current millenium
set nocompatible

" enable syntax and filetype plugin
syntax enable
filetype plugin on

set t_Co=256
" for vim 8
" if (has("termguicolors"))
"   set termguicolors
" endif

set path+=**  

colorscheme OceanicNext 

" open split to the right
set splitright

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


" folding
set foldmethod=syntax 
"set foldcolumn=1 " thing on left side of screen indicating folds
let javaScript_fold=1 
set foldlevelstart=99 " start file with all folds open

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
map <C-m> :NERDTreeFind<CR>

" MINE
" Quit and save fast
nnoremap <Leader>q :q <cr>
nnoremap <Leader>w :w <cr>

" find word
nnoremap <Leader>f yiw /<C-r>"
nnoremap <Leader>, :noh <cr>
nnoremap <Leader>r yiw :%s/<C-r>"/

" Copy to clipboard
map <Leader>y :w !pbcopy<CR><CR> 

" coc completion
" inoremap <silent><expr> <TAB>
"      \ pumvisible() ? "\<C-n>" :
"      \ <SID>check_back_space() ? "\<TAB>" :
"      \ coc#refresh()
" inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

"webpack resolver
autocmd FileType javascript nmap <buffer> gf <Plug>(enhanced-resolver-go-cursor)
nnoremap <C-f> :Ag <cr>

"GOYO no distraction MODE quick key 
nnoremap <Leader>dd :Goyo <cr>
nnoremap <Leader>do :Goyo! <cr>

" enable Ag silver searcher ---> brew install the_silver_searcher
command! -bang -nargs=* Ag call fzf#vim#ag(<q-args>, {'options': '--delimiter : --nth 4..'}, <bang>0)

" COMMENT LINES
"vmap <Leader>c <C-I># <CR>

set path=.,src,node_modules
set suffixesadd=.js,.jsx

" fucking clipboard
set guioptions+=a

" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

" add Intellisence YouCompleteMe
" Start autocompletion after 4 chars
let g:ycm_min_num_of_chars_for_completion = 4
let g:ycm_min_num_identifier_candidate_chars = 4
let g:ycm_enable_diagnostic_highlighting = 0

" Don't show YCM's preview window [ I find it really annoying ]
set completeopt-=preview
let g:ycm_add_preview_to_completeopt = 0

" js syntax highlighting
let g:used_javascript_libs = 'react,ramda,chai'

" match tag always
let g:mta_filetypes ={
  \ 'javascript.jsx' : 1,
  \}
highlight MatchTag ctermfg=black ctermbg=lightgreen guifg=black guibg=lightgreen


" Trigger configuration (Optional)
" let g:UltiSnipsExpandTrigger="<C-l>"
" Set ultisnips triggers
let g:UltiSnipsExpandTrigger="<tab>"                                            
let g:UltiSnipsJumpForwardTrigger="<tab>"                                       
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"     

let g:NERDCustomDelimiters={
  \ 'javascript': { 'left': '//', 'right': '', 'leftAlt': '{/*', 'rightAlt': '*/}' },
  \}

Plug 'ctrlpvim/ctrlp.vim'
Plug 'davidosomething/vim-enhanced-resolver', { 'do': 'npm install --global enhanced-resolve-cli' }
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-cucumber'
Plug 'tpope/vim-surround'
Plug 'airblade/vim-gitgutter'
"Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'w0rp/ale'
Plug 'scrooloose/nerdtree'
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
"Plug 'neoclide/coc.nvim', {'do': { -> coc#util#build()}} 
Plug 'ruanyl/coverage.vim'
Plug 'junegunn/goyo.vim'
"Plug 'Valloric/YouCompleteMe', { 'do': './install.py --tern-completer' }
Plug 'mhartington/oceanic-next'
Plug 'othree/yajs.vim'
Plug 'othree/javascript-libraries-syntax.vim'
Plug 'Valloric/MatchTagAlways'
" ES2015 code snippets (Optional)
Plug 'epilande/vim-es2015-snippets'

" React code snippets
Plug 'epilande/vim-react-snippets'

" Ultisnips
Plug 'SirVer/ultisnips'
" js auto pretty
Plug 'prettier/vim-prettier', {
  \ 'do': 'yarn install',
  \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'yaml', 'html'] }

"
Plug 'scrooloose/nerdcommenter'
call plug#end()


