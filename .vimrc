"VUNDLE STUFF 
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'mattn/emmet-vim'
Plugin 'scrooloose/nerdtree'
Plugin 'morhetz/gruvbox'
Plugin 'Yggdroot/indentLine'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" Put your non-Plugin stuff after this line

set history=100 " keep 100 lines of command line history
set ruler "show the cursor position all the time
set showcmd " display incomplete commands
set incsearch " do incremental searching
set rnu
set number
set lazyredraw          " redraw only when we need to
set tabstop=4
set softtabstop=4   " number of spaces in tab when editing
set shiftwidth=4
set expandtab
set autoindent
set linebreak   "break line only between words
set showbreak=>>    "indicate wrapped text
set scrolloff=6     "doesn't get close to the edge when scrolling
set wildmenu
set cursorline 
set laststatus=2
set noshowmode
set ttimeoutlen=30
set ttyfast
set ttyscroll=3
set synmaxcol=128

"new, self-definied keybindings
let mapleader = "\<Space>"
nnoremap <leader>q <esc>:wq<CR>
nnoremap <leader>w <esc>:w<CR>
nnoremap <leader>p "0p
autocmd! FileType vim nnoremap <leader>r <esc>:w<CR>:so $MYVIMRC<CR>

"insert mode keybindings with ALT
inoremap <A-h> <left>
inoremap <A-j> <down>
inoremap <A-k> <up>
inoremap <A-l> <right>

"deleted default keybindings
nnoremap <space> <nop>
nnoremap $ <nop>
nnoremap ^ <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
nnoremap <up> <nop>
nnoremap <down> <nop>
inoremap <backspace> <nop>

"modified default keybindings
nnoremap , ;
nnoremap ; ,

"plugin keybindings
map <silent> <C-n> :NERDTreeToggle<CR>

" SYNTAX HIGHLIGHTING:
set t_Co=256
syntax on
colorscheme gruvbox

" powerline symbols
  let g:airline_left_sep = ''
  let g:airline#extensions#tabline#left_sep = ''   
  let g:airline#extensions#tabline#left_alt_sep = ''
  let g:airline_left_alt_sep = ''
  let g:airline_right_sep = ''
  let g:airline_right_alt_sep = ''
  let g:airline_symbols_branch = ''
  let g:airline_symbols_readonly = ''
  let g:airline_symbols_linenr = ''

" Enable the list of buffers
let g:airline#extensions#tabline#enabled = 1
" Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'


set hidden  " ???
nmap <leader>t :enew<cr> " new empty buffer
nmap <leader>l :bnext<CR> " next buffer
nmap <leader>h :bprevious<CR> " prev buffer

" Close the current buffer and move to the previous one
" This replicates the idea of closing a tab
nmap <leader>bq :w<CR>:bp <BAR> bd #<CR>

" Show all open buffers and their status
nmap <leader>bl :ls<CR>
