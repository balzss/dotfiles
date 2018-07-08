call plug#begin()

" language plugins
Plug 'neovimhaskell/haskell-vim'
Plug 'tomlion/vim-solidity'
Plug 'digitaltoad/vim-pug'
Plug 'mattn/emmet-vim'
Plug 'posva/vim-vue'
Plug 'othree/html5.vim'
Plug 'hail2u/vim-css3-syntax'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'

" misc plugins
Plug 'simnalamburt/vim-mundo'
Plug 'tpope/vim-fugitive'
Plug 'jreybert/vimagit'
Plug 'chriskempson/base16-vim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' } 
Plug 'junegunn/fzf.vim'
Plug 'mileszs/ack.vim'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'Yggdroot/indentLine'
Plug 'w0rp/ale'
Plug 'editorconfig/editorconfig-vim'

call plug#end()

au TermOpen * setlocal nonumber norelativenumber

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
set textwidth=120
set conceallevel=0
set foldmethod=syntax
set foldlevel=99

" layout
set laststatus=1 " show statusline (same for tabline): (0|never, 1|when needed; 2|always)
set showtabline=1
set ruler "show the cursor position all the time at bottom right corner
set showcmd " display incomplete commands
set relativenumber " relative numbering to the current line
set number " hybrid mode with relative number: current is the actual and not 0
set wildmenu
set cursorline
set showmode
set list
set listchars=trail:•,nbsp:≡
set fillchars=vert:│
set colorcolumn=120 " displays a vertical line at column 120

" syntax highlighting
syntax on
set t_Co=256
set synmaxcol=120
colorscheme base16-default-dark
set background=dark

" behavior settings
set inccommand=nosplit
set ignorecase
set smartcase
set history=1000 "number of commands to keep in history
set incsearch "do incremental searching
set lazyredraw "redraw only when we need to
set scrolloff=30 "doesn't get close to the edge when scrolling
set ttimeoutlen=30
set ttyfast
set splitbelow
set splitright
set backupdir=$HOME/.vim/backup
set undofile
set undodir=$HOME/.vim/undo
set undolevels=10000
set undoreload=10000
set nohidden "doesn't allow switching between buffers without saving them
set shiftround
set backspace=2 "otherwise backspace wont't work in mac OS

" modified default keybindings
nnoremap s :w<cr>
vnoremap s :w<cr>
onoremap H ^
vnoremap H ^
nnoremap H ^
onoremap L $
vnoremap L $h
nnoremap L $
nnoremap J <c-d>
vnoremap J <c-d>
nnoremap K <c-u>
vnoremap K <c-u>
nnoremap M J
nnoremap U <c-r>
vnoremap y y`]
nnoremap <CR> za
nnoremap Q q:

" new keybindings
nnoremap <esc> :nohlsearch<CR><C-l>
nnoremap \ :Buffers<CR>
let mapleader=" "

nnoremap <leader>s :%s/
vnoremap <leader>s y:%s/<C-r>"//g<left><left>

nnoremap <leader>S :w ! sudo tee %<cr>
nnoremap <leader>e :Files<CR>
nnoremap <leader>q :History:<CR>
nnoremap <leader>a :Ag<CR>
nnoremap <leader>b :Buffers<CR>
nnoremap <leader><leader> :b#<cr>
nnoremap <leader>d "_d
vnoremap <leader>d "_d
onoremap <leader>d "_d
nnoremap <leader>y "+y
vnoremap <leader>y "+y
onoremap <leader>y "+y
nnoremap <leader>p "+p
vnoremap <leader>p "+p
onoremap <leader>p "+p

nnoremap <leader>f :ALEFix<CR>
nnoremap <leader>m :Magit<CR>
nnoremap <leader>u :MundoToggle<CR>

nnoremap <leader>gb :Gblame<CR>
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>gpl :Gpull<CR>
nnoremap <leader>gph :Gpush<CR>
nnoremap <leader>gd :Gdiff<CR>

" buffer navigation
nnoremap gd :bdelete<CR>
nnoremap gn <C-w>w
nnoremap gp <C-w>W

nnoremap <leader>r :te time ./%<cr>
nnoremap <leader>R :te time ./%<space>

inoremap <c-l> <esc>la
inoremap <c-b> {<cr>}<esc>==O<esc>cc

" deoplete tab-complete
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
inoremap <expr><s-tab> pumvisible() ? "\<c-p>" : "\<tab>"

" jump to next/prev error msg
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

let g:ackprg = 'ag --nogroup --nocolor --column'

let $FZF_DEFAULT_COMMAND = 'ag -l -g ""'

let g:deoplete#enable_at_startup = 1

let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsSnippetDirectories=["custom_snippets"]

call deoplete#custom#source('ultisnips', 'matchers', ['matcher_fuzzy'])

let g:ale_linters = {'javascript': ['eslint']}
let g:ale_python_flake8_options = '--ignore=E501'

let g:indentLine_setConceal = 0
let g:jsx_ext_required = 0
let b:ale_fixers = {'javascript': ['prettier', 'eslint']}
