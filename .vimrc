set nocompatible

filetype off
"Set leader
let mapleader=","

" Load plugins
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
call plug#begin('~/.vim/plugged')

" Themes
Plug 'mhartington/oceanic-next'
Plug 'morhetz/gruvbox'
Plug 'romainl/Apprentice'

" Color codes
Plug 'chrisbra/Colorizer'
" {{{
  let g:colorizer_auto_filetype='css,less,html,vimrc'

" Set focus
Plug 'junegunn/limelight.vim'

" Fuzzy search
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install-all' }
Plug 'junegunn/fzf.vim'
" {{{
  nmap <c-p> :GFiles<CR>
  command! -bang -nargs=* Rg
        \ call fzf#vim#grep(
        \   'rg --column --line-number --no-heading --color=always --ignore-case '.shellescape(<q-args>), 1,
        \   <bang>0 ? fzf#vim#with_preview('up:60%')
        \           : fzf#vim#with_preview('right:50%:hidden', '?'),
        \   <bang>0)
  nmap <leader>a :Rg<space>
  nmap <leader>b :Buffers<CR>
" }}}

" File management
Plug 'scrooloose/nerdtree'
" {{{
  " Map toggling
  map <C-n> :NERDTreeToggle<CR>
  " Automatically close
  autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
  " Hide certain filetypes
  let NERDTreeIgnore = ['\.pyc$']
" }}}
" And make it pretty
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
" {{{
  let g:NERDTreeFileExtensionHighlightFullName = 1
  let g:NERDTreeExactMatchHighlightFullName = 1
  let g:NERDTreePatternMatchHighlightFullName = 1
  let g:NERDTreeLimitedSyntax = 1
  let g:NERDTreeHighlightCursorline = 0
" }}}
Plug 'ryanoasis/vim-devicons'


" Git
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
" {{{
  nnoremap :ga :Gstatus<CR>
  nnoremap :gc :Gcommit<CR>
" }}}
Plug 'zivyangll/git-blame.vim'

" Linting
Plug 'w0rp/ale'
" {{{
  let g:ale_fixers = {}
  let g:ale_fixers['javascript'] = ['prettier']
  let g:ale_fix_on_save = 1
  let g:ale_javascript_prettier_use_local_config = 1
" }}}

" Formatting
Plug 'ambv/black'
" {{{
  autocmd BufWritePre *.py execute ':Black'
  let g:black_virtualenv = '~/.envs/aurelia'
  let g:black_fast = 1
  let g:black_linelength = 110
" }}}

" Comments
Plug 'tpope/vim-commentary'

" Tags
Plug 'majutsushi/tagbar'
" {{{
  nmap <leader>t :TagbarToggle<CR>
" }}}

" Motions
Plug 'bkad/CamelCaseMotion'
" {{{
  map <silent> w <Plug>CamelCaseMotion_w
  map <silent> b <Plug>CamelCaseMotion_b
  map <silent> e <Plug>CamelCaseMotion_e
  map <silent> ge <Plug>CamelCaseMotion_ge
  sunmap w
  sunmap b
  sunmap e
  sunmap ge
" }}}

" Language plugins
Plug 'digitaltoad/vim-pug'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'leafgarland/typescript-vim'

" Autocompletion
Plug 'Valloric/YouCompleteMe', { 'do': './install.py' }
" {{{
  nnoremap <leader>jd :YcmCompleter GoToDefinitionElseDeclaration<CR>
" }}}

call plug#end()

" Syntax highlighting
syntax on

" For plugins to load correctly
filetype plugin indent on

" Security
set modelines=0

" Show line numbers
set number

" Speed up on large files
set lazyredraw

" Show file stats
set ruler

" Blink cursor on error instead of beeping
set visualbell

" Encoding
set encoding=utf-8

" Whitespace
set wrap linebreak nolist
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set noshiftround
set autoindent
set smartindent
au FileType python setl sw=4 sts=4 ts=4 et

" Cursor motion
set scrolloff=3
set backspace=indent,eol,start
set matchpairs+=<:> " use % to jump between pairs
set cursorline

" Move up/down editor lines
nnoremap j gj
nnoremap k gk

" Easier switch between windows
nnoremap <silent> <C-h> :wincmd h<CR>
nnoremap <silent> <C-j> :wincmd j<CR>
nnoremap <silent> <C-k> :wincmd k<CR>
nnoremap <silent> <C-l> :wincmd l<CR>

" Allow hidden buffers
set hidden

" Rendering
set ttyfast

" switch from block cursor to vertical line cursor between normal/insert mode
let &t_SI = "\<Esc>]50;CursorShape=1\x7" " Vertical bar in insert mode
let &t_EI = "\<Esc>]50;CursorShape=0\x7" " Block in normal mode"

" Status bar
set laststatus=2

" Last line
set showmode
set showcmd

" Searching
nnoremap / /\v
vnoremap / /\v
set hlsearch
set incsearch
set ignorecase
set smartcase
set showmatch
map <leader><space> :let @/=''<cr> " clear serach

" Visualize tabs and newlines
set listchars=tab:▸\ ,eol:¬

" Performance
set nocursorcolumn
set nocursorline
set norelativenumber
syntax sync minlines=256

" Easier pasting
nnoremap <leader>p o<ESC>p

" Easier save and quit
nnoremap ;w :w<CR>
nnoremap ;q :q<CR>
nnoremap ;wq :wq<CR>

" Easier access to vimrc
nnoremap <leader>ev :e ~/.vimrc<CR>
nnoremap <leader>sv :source ~/.vimrc<CR>

" Color scheme (terminal)
if (has("termguicolors"))
  set termguicolors
endif
colorscheme apprentice

" Triger `autoread` when files changes on disk
" https://unix.stackexchange.com/questions/149209/refresh-changed-content-of-file-opened-in-vim/383044#383044
" https://vi.stackexchange.com/questions/13692/prevent-focusgained-autocmd-running-in-command-line-editing-mode
autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() != 'c' | checktime | endif
" Notification after file change
" https://vi.stackexchange.com/questions/13091/autocmd-event-for-autoread
autocmd FileChangedShellPost *
  \ echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None
