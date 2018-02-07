call plug#begin()

Plug 'chriskempson/base16-vim'
Plug 'itchyny/lightline.vim'
Plug 'daviesjamie/vim-base16-lightline'
Plug 'mgee/lightline-bufferline'
Plug 'mattn/emmet-vim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' } 
Plug 'junegunn/fzf.vim'
Plug 'mileszs/ack.vim'
Plug 'posva/vim-vue'
Plug 'digitaltoad/vim-pug'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" Plug 'jiangmiao/auto-pairs'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'tomlion/vim-solidity'
Plug 'othree/html5.vim'
Plug 'Yggdroot/indentLine'
Plug 'w0rp/ale'

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
set textwidth=120

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
set colorcolumn=120 " displays a vertical line at column 120
set showtabline=2

" syntax highlighting
syntax on
set t_Co=256
set synmaxcol=120
colorscheme base16-default-dark
set background=dark

" behavior settings
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

" buffer navigation
nnoremap gn :bnext<CR>
nnoremap gp :bprevious<CR>
nnoremap gd :bdelete<CR>
nnoremap gs <C-w>w
nnoremap gS <C-w>W

" new keybindings
let mapleader=" "
nnoremap <leader>s :w ! sudo tee %<cr>
nnoremap <leader>e :Files<CR>
nnoremap <leader>g :Ag<CR>
nnoremap <leader>t :Tags<CR>
nnoremap <leader>b :Buffers<CR>
nnoremap <leader><leader> :b#<cr>
nnoremap <leader>l :nohlsearch<CR><C-l>
nnoremap <leader>d "_d
vnoremap <leader>d "_d
onoremap <leader>d "_d
nnoremap <leader>p "0p
vnoremap <leader>p "0p
onoremap <leader>p "0p

inoremap <c-l> <esc>la
inoremap <c-b> {<cr>}<esc>==O<esc>cc

" deoplete tab-complete
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
inoremap <expr><s-tab> pumvisible() ? "\<c-p>" : "\<tab>"

" jump to next/prev error msg
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

function! s:fzf_statusline()
    " Override statusline as you like
    highlight fzf1 ctermfg=161 ctermbg=251
    highlight fzf2 ctermfg=23 ctermbg=251
    highlight fzf3 ctermfg=237 ctermbg=251
    setlocal statusline=%#fzf1#\ >\ %#fzf2#fz%#fzf3#f
endfunction

autocmd! User FzfStatusLine call <SID>fzf_statusline()
let g:ackprg = 'ag --nogroup --nocolor --column'

let g:lightline = { 'colorscheme': 'base16' }

let g:lightline#bufferline#unnamed      = '[No Name]'
let g:lightline#bufferline#filename_modifier = ':t'
let g:lightline.tabline          = {'left': [['buffers']]}
let g:lightline.component_expand = {'buffers': 'lightline#bufferline#buffers'}
let g:lightline.component_type   = {'buffers': 'tabsel'}

let $FZF_DEFAULT_COMMAND = 'ag -l -g ""'

let g:deoplete#enable_at_startup = 1

let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsSnippetDirectories=["custom_snippets"]

call deoplete#custom#set('ultisnips', 'matchers', ['matcher_fuzzy'])
