set nocompatible

set hidden " hides buffers instead of closing them
set nowrap " don't wrap lines
set backspace=indent,eol,start " backspace over all the things

set autoread " auto reload files changed outside vim

" yay searching
set hlsearch
set incsearch

set so=7
set showmatch " matching parens
set showcmd " show command as its typed

" woo wildmenu
set wildmenu
set wildignore=*.swp,*.bak,*.pyc,*.class

set mat=2
set scrolloff=10

set number " yay numbers
set title " change the temrinal title

" more history
set history=1000
set undolevels=1000

set pastetoggle=<leader>P " turn this on when pasting text with indentation

execute pathogen#infect()
syntax on
filetype plugin indent on
set t_Co=256
colorscheme OceanicNext
set background=dark
let g:airline_theme="serene"
set encoding=utf8
set cursorline
set ruler
set lazyredraw
set ttyfast

set expandtab
set smarttab
set tabstop=2
set shiftwidth=2
set softtabstop=2
set ai
set si
set wrap
set lbr
set tw=500
set mouse=a

" folding
set foldenable
set foldnestmax=10
" set foldcolumn=10
set foldlevelstart=5
" space opens/closes folds
nnoremap <space> za
set foldmethod=indent

" save views
set viewoptions=cursor,folds,slash,unix

nnoremap j gj
nnoremap k gk
nnoremap <silent> <C-h> :wincmd h<CR>
nnoremap <silent> <C-j> :wincmd j<CR>
nnoremap <silent> <C-k> :wincmd k<CR>
nnoremap <silent> <C-l> :wincmd l<CR>

" make typing commands simpler
nnoremap ; :

" gV visually selects block of characters added in last INSERT
nnoremap gV `[v`]

" <Ctrl-l> stops highlighting search
nnoremap <C-w> :noh<CR><C-l>

" ;w quickly saves; maybe sketchy but yolo
nnoremap ;w :w<CR>
" ;q quickly closes; same as above
nnoremap ;q :q<CR>
" finally ;wq
nnoremap ;wq :wq<CR>

let mapleader=","
inoremap jk <esc>

" in Visual mode, make p replace highlighted text with yanked text
vnoremap p <Esc>:let current_reg = @"<CR>gvdi<C-R>=current_reg<CR><Esc>

" use ,d (or ,dd or ,dj or 20,dd) to delete a line without adding it to yanked stack (also, in visual mode)
nnoremap <silent> <leader>d "_d
vnoremap <silent> <leader>d "_d

" quick yanking to end of line
nnoremap Y y$

" pull word under cursor into LHS of a substitute (fast search-and-replace)
nnoremap <leader>z :%s/\<<C-r>=expand("<cword>")<CR>\>/

" Ctrl-u in insert/normal mode to uppercase word under cursor
" have to use U for compatibility with autcomplete
inoremap <C-U> <esc>viwUea
nnoremap <C-u> viwUe

" switch from block cursor to vertical line cursor between normal/insert mode
let &t_SI = "\<Esc>]50;CursorShape=1\x7" " Vertical bar in insert mode
let &t_EI = "\<Esc>]50;CursorShape=0\x7" " Block in normal mode"

nnoremap <leader>u :GundoToggle<CR>

" open ag.vim
nnoremap <leader>a :Ag<space>

" Nerd tree settings
map <C-n> :NERDTreeToggle<CR> " toggles NERD tree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif " closes vim if NERD tree is last open window

" strip trailing whitespace/\s\+$//e
fun! TrimWhitespace()
		let l:save_cursor = getpos('.')
		%s/\s\+$//e
    call setpos('.', l:save_cursor)
endfun
command! TrimWhitespace call TrimWhitespace()
nnoremap <leader>w :call TrimWhitespace()<CR>

" toggles showing diff between current version and last saved version of file
nnoremap <leader>ds :DiffChangesDiffToggle<cr>

nnoremap <leader>q :call <SID>QuickfixToggle()<cr>
let g:quickfix_is_open = 0
function! s:QuickfixToggle()
    if g:quickfix_is_open
        cclose
        let g:quickfix_is_open = 0
        execute g:quickfix_return_to_window . "wincmd w"
    else
        let g:quickfix_return_to_window = winnr()
        copen
        let g:quickfix_is_open = 1
    endif
endfunction

" toggle TagBar with ,t
nnoremap <leader>t :TagbarToggle<CR>

" turn on statusline
set laststatus=2

" Gaming swap files "{{{
" create the directory if it doesn't exist
silent !mkdir ~/.vim/swap > /dev/null 2>&1
set backupdir=~/.vim/swap/
set directory=~/.vim/swap/
"}}}

" Automatically reload vimrc when it's saved
augroup VimrcSo
  au!
  autocmd BufWritePost $MYVIMRC so $MYVIMRC
augroup END

" Easy resourcing of vimrc with ,s
nnoremap <leader>sv :source $MYVIMRC<CR>

" Easy reopening of vimrc
nnoremap <leader>ev :e $MYVIMRC<CR>

" YouCompleteMe stuff:
" Disable haskell-vim omnifunc
let g:haskellmode_completion_ghc = 0
autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc

command! DeleteOldViews ! find ~/.vim/view -maxdepth 1 -mtime +7d | xargs -0 rm
