" plugins
call plug#begin()

Plug 'mattn/emmet-vim', { 'for': 'html' }
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'morhetz/gruvbox'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'bronson/vim-trailing-whitespace', { 'on': 'FixWhitespace' }
Plug 'vim-airline/vim-airline'
Plug 'scrooloose/syntastic'
Plug 'Raimondi/delimitMate'
Plug 'pangloss/vim-javascript'
Plug 'SirVer/ultisnips'
Plug 'Shougo/neocomplete.vim'
Plug 'ervandew/supertab'
Plug 'honza/vim-snippets'

call plug#end()


augroup general
    autocmd!
    autocmd BufWritePre * :FixWhitespace
    autocmd ColorScheme * highlight VertSplit cterm=NONE ctermbg=NONE
    autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
    autocmd FileType html nnoremap <silent><F5> :!chromium %<CR>
augroup END


augroup python_mapping
    autocmd!
    autocmd FileType python nnoremap <F5> :!clear;python %<CR>
    autocmd FileType python nnoremap <S-F5> :!tmux new-window -d 'exec python %'<CR><CR>
    autocmd FileType python setlocal completeopt-=preview
    autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
augroup END

augroup js_mapping
    autocmd!
    autocmd FileType javascript nnoremap <silent><leader> <F5> :!tmux new-window -d 'exec nodemon %'<CR><CR>
    autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
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
set textwidth=80

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
set colorcolumn=80
set foldcolumn=0
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
set undodir=~/.vim/undo_files//
set undofile
set undodir=$HOME/.vim/undo
set undolevels=1000
set undoreload=10000
set hidden " allows switching between buffers without saving them
set shiftround

" new, self-definied keybindings
nnoremap gs <C-w>w
nnoremap gS <C-w>W
nnoremap s :w<cr>
nnoremap <silent><F2> :NERDTreeToggle<CR>
nnoremap <c-v> "+P
nnoremap <c-V> "+p


nnoremap gn :bnext<CR>
nnoremap gp :bprevious<CR>
nnoremap gd :bdelete<CR>
nnoremap gd :bdelete<CR>
nnoremap g1 :b 1<CR>
nnoremap g2 :b 2<CR>
nnoremap g3 :b 3<CR>
nnoremap g4 :b 4<CR>
nnoremap g5 :b 5<CR>

" insert mode mappingsssss
inoremap <c-v> <c-o>"+P
inoremap <c-w> <c-o>w

"deleted default deleted
nnoremap <space> <nop>
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
nnoremap p ]p


" plugin config
let g:airline_powerline_fonts = 0
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline_left_sep = ''
let g:airline_right_sep = ''
let g:airline#extensions#tabline#buffer_nr_show = 1

let g:SuperTabContextDefaultCompletionType = "<c-x><c-o>"
let g:SuperTabDefaultCompletionType = "context"

let NERDTreeQuitOnOpen=1

let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_python_checkers = ['flake8']
let g:syntastic_python_flake8_args='--ignore=E128,E302,E127,E201,E231,E202,E251,E126,F401'
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" let g:acp_enableAtStartup = 0

let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#sources#syntax#min_keyword_length = 2
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

let g:UltiSnipsExpandTrigger="<c-j>"

let delimitMate_expand_cr = 1

inoremap <expr> <c-l> delimitMate#JumpAny()
