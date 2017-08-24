call plug#begin()

Plug 'chriskempson/base16-vim'
Plug 'itchyny/lightline.vim'
Plug 'daviesjamie/vim-base16-lightline'
Plug 'mattn/emmet-vim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'ConradIrwin/vim-bracketed-paste'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' } 
Plug 'junegunn/fzf.vim'

call plug#end()

if filereadable(expand("~/.vimrc_background"))
  let base16colorspace=256
  source ~/.vimrc_background
endif

augroup general
    autocmd!
    if !isdirectory($HOME."/.vim/backup")
        call mkdir($HOME."/.vim/backup", "p")
    endif
    if !isdirectory($HOME."/.vim/undo")
        call mkdir($HOME."/.vim/undo", "p")
    endif
    if !filereadable($HOME."/.vim/autoload/plug.vim")
        call system("curl -fLo ~/.vim/autoload/plug.vim --create-dirs 
                    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim")
    endif

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
set laststatus=2 " statusline always visible
set showtabline=0 " tabline never visible
set ruler "show the cursor position all the time
set showcmd " display incomplete commands
set relativenumber " relative numbering to the current line
set number " hybrid mode with relative number: current is the actual and not 0
set wildmenu
set cursorline
set noshowmode
set nolist
set fillchars=vert:│
set colorcolumn=80 " displays a vertical line at column 80
set foldcolumn=0

" syntax highlighting
syntax on
set t_Co=256
set synmaxcol=120
colorscheme base16-default-dark
set background=dark

let g:lightline = {
      \ 'colorscheme': 'base16',
      \ }

" behavior settings
set ignorecase
set smartcase
set history=1000 " keep 100 lines of command line history
set incsearch " do incremental searching
set lazyredraw          " redraw only when we need to
set scrolloff=30     "doesn't get close to the edge when scrolling
set ttimeoutlen=30
set ttyfast
set ttyscroll=3
set cryptmethod=blowfish2
set splitbelow
set splitright
set backupdir=$HOME/.vim/backup
set undofile
set undodir=$HOME/.vim/undo
set undolevels=10000
set undoreload=10000
set nohidden " doesn't allow switching between buffers without saving them
set shiftround
set backspace=2     " otherwise backspace wont't work in macOS


" new, self-definied keybindings
nnoremap gs <C-w>w
nnoremap gS <C-w>W
nnoremap s :w<cr>
vnoremap <C-r> "hy:%s/<C-r>h//gc<left><left><left> " find and replace 
" jump right a char
inoremap <c-l> <c-o>a

nnoremap J <c-d>
nnoremap K <c-u>
nnoremap M J
nnoremap U <c-r>

nnoremap gn :bnext<CR>
nnoremap gp :bprevious<CR>
nnoremap gd :bdelete<CR>
nnoremap gd :bdelete<CR>


" deleted default deleted
inoremap <left> <nop>
inoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <backspace> <nop>
nnoremap <c-r> <nop>

" modified default keybindings
nnoremap , ;
nnoremap ; ,
onoremap H ^
vnoremap H ^
nnoremap H ^
onoremap L $h
vnoremap L $h
nnoremap L $
nnoremap D D"_dd

let mapleader=" "
nnoremap <leader>e :Files<CR>
nnoremap <leader><leader> :b#<cr>
nnoremap <leader>b :b */*<C-d>

inoremap <tab> <c-f>
nnoremap <tab> >
onoremap <tab> >
vnoremap <tab> >
nnoremap <s-tab> <
onoremap <s-tab> <
vnoremap <s-tab> <

" line text-objects
xnoremap il g_o0
omap il :<C-u>normal vil<CR>
xnoremap al $o0
omap al :<C-u>normal val<CR>
