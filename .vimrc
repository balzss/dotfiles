" plugins
call plug#begin()

Plug 'mattn/emmet-vim', { 'for': 'html' }
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'morhetz/gruvbox'
Plug 'Yggdroot/indentLine'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'bronson/vim-trailing-whitespace', { 'on': 'FixWhitespace' }
Plug 'vim-airline/vim-airline'
Plug 'scrooloose/syntastic'
Plug 'Raimondi/delimitMate'
Plug 'digitaltoad/vim-pug', { 'for': 'jade' }
Plug 'tpope/vim-fugitive'

call plug#end()

" autorun commands
augroup general
    autocmd!
    autocmd BufWritePre * :FixWhitespace
    autocmd BufNewFile * startinsert
    autocmd ColorScheme * highlight VertSplit cterm=NONE ctermbg=NONE
augroup END

augroup sourcing
    autocmd!
    autocmd BufWritePost .vimrc so $MYVIMRC | AirlineRefresh
    " autocmd BufWritePost .Xresources !xrdb ~/.Xresources
    " autocmd BufWritePost .zshrc !source ~/.zshrc
augroup END

augroup python_mapping
    autocmd!
    autocmd FileType python nnoremap <silent> <F5> :!clear;python %<CR>
    autocmd FileType python setlocal completeopt-=preview
    au FileType python map <silent> <leader>b oimport ipdb; ipdb.set_trace()<esc>
augroup END

augroup js_mapping
    autocmd!
    autocmd FileType javascript nnoremap <silent> <F5> :!clear;node %<CR>
    autocmd FileType javascript setlocal shiftwidth=2 tabstop=2
augroup END

" code formatting
filetype plugin indent on
set breakindent
set tabstop=4
set softtabstop=4   " number of spaces in tab when editing
set shiftwidth=4
set expandtab
set autoindent
set linebreak   "break line only between words
set showbreak=>>    "indicate wrapped text
set formatoptions=qj " allows writing long lines and reformat it manually
set textwidth=120

" layout
set ruler "show the cursor position all the time
set showcmd " display incomplete commands
set rnu
set number
set wildmenu
set cursorline
set laststatus=2
set noshowmode
set nolist
set fillchars=vert:│
let g:indentLine_char = '│'

" syntax highlighting
syntax on
set t_Co=256
set synmaxcol=120
colorscheme gruvbox

" behavior settings
set ignorecase
set smartcase
set history=100 " keep 100 lines of command line history
set incsearch " do incremental searching
set lazyredraw          " redraw only when we need to
set scrolloff=6     "doesn't get close to the edge when scrolling
set ttimeoutlen=30
set ttyfast
set ttyscroll=3
set cryptmethod=blowfish2
set splitbelow
set splitright
set backupdir=~/.vim/backup_files//
set directory=~/.vim/swap_files//
set undodir=~/.vim/undo_files//

" new, self-definied keybindings
let mapleader = "\<Space>"
nnoremap <leader><tab> <C-w>w
nnoremap <leader><S-tab> <C-w>W
nnoremap <silent><F4> :w<cr>
nnoremap <silent><F3> ZZ
nnoremap <silent><F2> :NERDTreeToggle<CR>
nnoremap <c-v> "+P
inoremap <c-v> <c-o>"+P
inoremap é <c-o>h
inoremap á <c-o>a

"deleted default deleted
nnoremap <space> <nop>
nnoremap $ <nop>
nnoremap ^ <nop>
nnoremap E <nop>
nnoremap B <nop>
inoremap <left> <nop>
inoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <backspace> <nop>

"modified default keybindings
nnoremap , ;
nnoremap ; ,
onoremap B ^
vnoremap B ^
nnoremap B ^
onoremap E $
vnoremap E $
nnoremap E $

" plugin config
let g:airline_powerline_fonts = 1
let g:SuperTabContextDefaultCompletionType = "<c-x><c-o>"
let g:SuperTabDefaultCompletionType = "context"
let g:jedi#popup_on_dot = 0
let NERDTreeQuitOnOpen=1
let g:jedi#show_call_signatures = "2"
let g:airline#extensions#tabline#enabled = 1
" let g:airline#extensions#tabline#fnamemod = ':t'

let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_python_checkers = ['flake8']

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
