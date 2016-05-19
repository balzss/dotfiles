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
Plug 'majutsushi/tagbar'
Plug 'davidhalter/jedi-vim'
Plug 'ervandew/supertab'
Plug 'Raimondi/delimitMate'

call plug#end()

" autorun commands
augroup format_code
    autocmd!
    autocmd BufWritePre * :FixWhitespace
    " autocmd BufWritePre * :normal gg=G''
augroup END

augroup vim_souce
    autocmd!
    autocmd BufWritePost .vimrc so $MYVIMRC | AirlineRefresh
augroup END

augroup xres_source
    autocmd!
    autocmd BufWritePost .Xresources !xrdb ~/.Xresources
augroup END

augroup zshrc_source
    autocmd!
    autocmd BufWritePost .zshrc !source ~/.zshrc
augroup END

augroup color_hi
    autocmd!
    autocmd ColorScheme * highlight VertSplit cterm=NONE ctermbg=NONE
augroup END

augroup python_mapping
    autocmd!
    autocmd FileType python nnoremap <silent> <F5> :!clear;python %<CR>
    autocmd FileType python setlocal completeopt-=preview
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
" set foldenable
" set foldmethod=indent
" let g:vim_markdown_math = 1

" new, self-definied keybindings
let mapleader = "\<Space>"
nnoremap <leader><tab> <C-w>w
nnoremap <leader><S-tab> <C-w>W
nnoremap <leader>w :update<CR>
nnoremap <leader>k :<c-u>execute 'move -1-'. v:count1<cr> " replaces the current line with the one below it
nnoremap <leader>j :<c-u>execute 'move +'. v:count1<cr> " same but with the one above it
map <silent><C-n> :NERDTreeToggle<CR>
nmap <F8> :TagbarToggle<CR>
let g:ctrlp_map = '<c-p>'

"deleted default deleted
nnoremap <space> <nop>
nnoremap $ <nop>
nnoremap ^ <nop>
nnoremap E <nop>
nnoremap B <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <backspace> <nop>

"modified default keybindings
nnoremap , ;
nnoremap ; ,
onoremap B ^
nnoremap B ^
onoremap E $
nnoremap E $

" plugin config
let g:airline_powerline_fonts = 1
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']
let g:SuperTabContextDefaultCompletionType = "<c-x><c-o>"
let g:SuperTabDefaultCompletionType = "context"
let g:jedi#popup_on_dot = 0
