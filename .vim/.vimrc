" ─────────────────────────────────────────────────────────────
"  .vimrc  —  leader is \  ·  plugins: vim-plug (:PlugInstall)
" ─────────────────────────────────────────────────────────────

" enter the current millenium
set nocompatible
set encoding=utf-8
set backspace=indent,eol,start
set hidden                      " keep buffers around when switching
set autoread                    " reload files changed outside vim
set ttyfast
set lazyredraw

syntax enable
filetype plugin indent on

" ── colours ──────────────────────────────────────────────────
set t_Co=256
if has('termguicolors') && $COLORTERM =~# 'truecolor\|24bit'
  set termguicolors
endif
silent! colorscheme OceanicNext

" ── files / search paths ─────────────────────────────────────
set path=.,src,node_modules,**
set suffixesadd=.js,.jsx,.ts,.tsx
set tags=./tags;

" ── keep the working tree clean ──────────────────────────────
set undofile
set undodir=~/.vim/tmp/undo//
set directory=~/.vim/tmp/swap//
set backupdir=~/.vim/tmp/backup//
for s:dir in [&undodir, &directory, &backupdir]
  if !isdirectory(expand(s:dir)) | call mkdir(expand(s:dir), 'p', 0700) | endif
endfor

" ── splits ───────────────────────────────────────────────────
set splitright
set splitbelow

" ── searching ────────────────────────────────────────────────
set ignorecase
set smartcase                   " ...unless the pattern has capitals
set incsearch
set hlsearch
set showmatch

" ── tabs etc ─────────────────────────────────────────────────
set tabstop=2
set softtabstop=2
set expandtab
set shiftwidth=2

set number
set showcmd
set cursorline
set scrolloff=3
set signcolumn=yes              " stop gitgutter jiggling the text

" scroll with mouse
set mouse=a

" wildmenu is :<command> <Tab> completion
set wildmenu
set wildmode=longest:list,full
set wildignore+=*/node_modules/*,*/.git/*,*/dist/*,*/build/*

" ── tab switching, vim style ─────────────────────────────────
map <C-t><up> :tabr<cr>
map <C-t><down> :tabl<cr>
map <C-l> :tabn<cr>
map <C-h> :tabp<cr>

" ── folding ──────────────────────────────────────────────────
set foldmethod=syntax
let javaScript_fold=1
set foldlevelstart=99           " start with all folds open

" ── fuzzy finding (replaces CtrlP) ──────────────────────────
nnoremap <C-p> :Files<cr>
nnoremap <leader>. :Tags<cr>
nnoremap <leader>b :Buffers<cr>

" keep cursor in middle of screen when moving around
nnoremap k kzz
nnoremap j jzz

" vim-gitgutter — revert a hunk
nmap <Leader>hr <Plug>(GitGutterUndoHunk)

" ── NERDTree ─────────────────────────────────────────────────
map <C-n> :NERDTreeToggle<CR>
map <C-m> :NERDTreeFind<CR>

" ── MINE ─────────────────────────────────────────────────────
" quit and save fast
nnoremap <Leader>q :q<cr>
nnoremap <Leader>w :w<cr>

" find word under cursor / clear highlight / replace word under cursor
nnoremap <Leader>f yiw /<C-r>"
nnoremap <Leader>, :noh<cr>
nnoremap <Leader>r yiw :%s/<C-r>"/

" ── copy to the system clipboard ─────────────────────────────
" picks the best available route: vim's own +clipboard, then a
" local cli tool, then OSC52 — an escape sequence that carries the
" yank out through tmux/ssh to whatever terminal you're really on.
function! s:ClipCmd() abort
  if executable('pbcopy')
    return 'pbcopy'
  elseif executable('wl-copy') && !empty($WAYLAND_DISPLAY)
    return 'wl-copy'
  elseif executable('xclip') && !empty($DISPLAY)
    return 'xclip -selection clipboard'
  endif
  return ''
endfunction

function! s:Clip(text) abort
  if has('clipboard')
    let @+ = a:text
  else
    let l:cmd = s:ClipCmd()
    if !empty(l:cmd)
      call system(l:cmd, a:text)
    else
      " OSC52. tmux forwards this on thanks to `set -g set-clipboard on`
      let l:b64 = substitute(system('base64 | tr -d "\n"', a:text), '\n', '', 'g')
      call writefile(["\e]52;c;" . l:b64 . "\x07"], '/dev/stderr', 'b')
      redraw!
    endif
  endif
  echo 'copied ' . len(a:text) . ' bytes'
endfunction

vnoremap <silent> <Leader>y y:call <SID>Clip(@")<CR>
nnoremap <silent> <Leader>y yy:call <SID>Clip(@")<CR>
nnoremap <silent> <Leader>Y y$:call <SID>Clip(@")<CR>
" ── project-wide search: ripgrep, falling back to ag ─────────
if executable('rg')
  set grepprg=rg\ --vimgrep\ --smart-case
  command! -bang -nargs=* Find call fzf#vim#grep(
        \ 'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>),
        \ 1, fzf#vim#with_preview(), <bang>0)
elseif executable('ag')
  set grepprg=ag\ --vimgrep
  command! -bang -nargs=* Find call fzf#vim#ag(<q-args>,
        \ {'options': '--delimiter : --nth 4..'}, <bang>0)
else
  command! -nargs=+ Find grep! <args> | copen
endif
command! -bang -nargs=* Ag Find<bang> <args>
nnoremap <C-f> :Find<space>

" GOYO no-distraction mode
nnoremap <Leader>dd :Goyo<cr>
nnoremap <Leader>do :Goyo!<cr>

" fucking clipboard
set guioptions+=a

" ─────────────────────────────────────────────────────────────
"  plugins
"  - avoid using standard Vim directory names like 'plugin'
" ─────────────────────────────────────────────────────────────

" auto-install vim-plug if it's missing
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" ── ALE: lint as you type, format on demand with \p ─────────
let g:ale_fixers = {
  \ '*': ['remove_trailing_lines', 'trim_whitespace'],
  \ 'javascript': ['prettier', 'eslint'],
  \ 'typescript': ['prettier', 'eslint'],
  \ 'javascriptreact': ['prettier', 'eslint'],
  \ 'typescriptreact': ['prettier', 'eslint'],
  \ 'json': ['prettier'],
  \ 'css': ['prettier'],
  \ 'scss': ['prettier'],
  \ 'html': ['prettier'],
  \ 'yaml': ['prettier'],
  \ 'markdown': ['prettier'],
  \}
let g:ale_fix_on_save = 0
nnoremap <Leader>p :ALEFix<cr>
nmap <silent> [w <Plug>(ale_previous_wrap)
nmap <silent> ]w <Plug>(ale_next_wrap)

let g:NERDCustomDelimiters = {
  \ 'javascript': { 'left': '//', 'right': '', 'leftAlt': '{/*', 'rightAlt': '*/}' },
  \}

call plug#begin('~/.vim/plugged')

" finding things
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'scrooloose/nerdtree'

" git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" editing
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'scrooloose/nerdcommenter'

" lint + format (handles prettier, so no separate plugin for it)
Plug 'dense-analysis/ale'

" looks
Plug 'mhartington/oceanic-next'
Plug 'vim-airline/vim-airline'
Plug 'junegunn/goyo.vim'

call plug#end()

" colorscheme again, now that the plugin providing it is on the runtimepath
silent! colorscheme OceanicNext
