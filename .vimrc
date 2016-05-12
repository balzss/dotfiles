" plugins
call plug#begin()

Plug 'mattn/emmet-vim', { 'for': 'html' }
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'morhetz/gruvbox'
Plug 'Yggdroot/indentLine'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'bronson/vim-trailing-whitespace'
Plug 'vim-airline/vim-airline'

call plug#end()

if has('nvim')
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
    let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
    set background=dark

    " u VimEnter * colorscheme gruvbox
    colorscheme gruvbox
endif

" autorun commands
" autocmd BufWritePre * :FixWhitespace
" autocmd BufWritePre * :normal gg=G
autocmd! FileType vim nnoremap <leader>r <esc>:w<CR>:so $MYVIMRC<CR>
autocmd ColorScheme * highlight VertSplit cterm=NONE ctermbg=NONE

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
" set ttyscroll=3
" set cryptmethod=blowfish2

" new, self-definied keybindings
let mapleader = "\<Space>"
nnoremap <leader><tab> <C-w>w
nnoremap <leader><S-tab> <C-w>W
nnoremap <leader>q <esc>:wq<CR>
nnoremap <leader>w <esc>:w<CR>
nnoremap <leader>p p
nnoremap <leader>P P
nnoremap p "0p
nnoremap P "0P
" nnoremap <leader>k :<c-u>execute 'move -1-'. v:count1<cr> " replaces the current line with the one below it
" nnoremap <leader>j :<c-u>execute 'move +'. v:count1<cr> " same but with the one above it
nnoremap <leader>O :<c-u>put! =repeat(nr2char(10), v:count1)<cr>'[ " pastes empty line above the current one and stay in normal mode
nnoremap <leader>o :<c-u>put =repeat(nr2char(10), v:count1)<cr> " same but pastes below
map <silent><C-n> :NERDTreeToggle<CR>

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

" powerline symbols
let g:airline_powerline_fonts = 1

