set nocompatible

filetype off

" Load plugins
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
call plug#begin('~/.vim/plugged')

" Themes
Plug 'mhartington/oceanic-next'

" Fuzzy search
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'

" File management
Plug 'scrooloose/nerdtree'

" Git
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'zivyangll/git-blame.vim'

" Linting
Plug 'w0rp/ale'

" Formatting
Plug 'ambv/black'

" Comments
Plug 'tpope/vim-commentary'

" Tags
Plug 'majutsushi/tagbar'

" Motions
Plug 'bkad/CamelCaseMotion'

" Multi-cursor
Plug 'terryma/vim-multiple-cursors'

" Language plugins
Plug 'digitaltoad/vim-pug'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'leafgarland/typescript-vim'

" Autocompletion
Plug 'Valloric/YouCompleteMe', { 'do': './install.py' }

call plug#end()

" Syntax highlighting
syntax on

" For plugins to load correctly
filetype plugin indent on

"Set leader
let mapleader=","

" Security
set modelines=0

" Show line numbers
set number

" Show file stats
set ruler

" Blink cursor on error instead of beeping
set visualbell

" Encoding
set encoding=utf-8

" Whitespace
set nowrap
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

" Color scheme (terminal)
if (has("termguicolors"))
  set termguicolors
endif
colorscheme OceanicNext

" Nerdtree
" Map toggling
map <C-n> :NERDTreeToggle<CR>
" Automatically close
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" FZF
map <c-p> :GFiles<CR>
command! -bang -nargs=* Rg
      \ call fzf#vim#grep(
      \   'rg --column --line-number --no-heading --color=always --ignore-case '.shellescape(<q-args>), 1,
      \   <bang>0 ? fzf#vim#with_preview('up:60%')
      \           : fzf#vim#with_preview('right:50%:hidden', '?'),
      \   <bang>0)
nnoremap <leader>a :Rg<space>

" Tagbar
nmap <leader>t :TagbarToggle<CR>

" Git
nnoremap :ga :Gstatus
nnoremap :gc :Gcommit

" CamelCaseMotion
map <silent> w <Plug>CamelCaseMotion_w
map <silent> b <Plug>CamelCaseMotion_b
map <silent> e <Plug>CamelCaseMotion_e
map <silent> ge <Plug>CamelCaseMotion_ge
sunmap w
sunmap b
sunmap e
sunmap ge

" Multi-cursor
let g:multi_cursor_use_default_mapping=0
let g:multi_cursor_start_word_key      = '<C-@>'
let g:multi_cursor_select_all_word_key = '<A-n>'
let g:multi_cursor_start_key           = 'g<C-n>'
let g:multi_cursor_select_all_key      = 'g<A-n>'
let g:multi_cursor_next_key            = '<C-n>'
let g:multi_cursor_prev_key            = '<C-p>'
let g:multi_cursor_skip_key            = '<C-x>'
let g:multi_cursor_quit_key            = '<Esc>'

" YouCompleteMe
nnoremap <leader>jd :YcmCompleter GoToDefinitionElseDeclaration<CR>

" Formatting
" Black
autocmd BufWritePre *.py execute ':Black'
let g:black_virtualenv = '~/.envs/aurelia'
let g:black_fast = 1
let g:black_linelength = 110
" Prettier
let g:ale_fixers = {}
let g:ale_fixers['javascript'] = ['prettier']
let g:ale_fix_on_save = 1
let g:ale_javascript_prettier_use_local_config = 1
