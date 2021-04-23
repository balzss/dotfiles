call plug#begin()

let mapleader=" "

" webdev
    Plug 'mattn/emmet-vim'
    Plug 'othree/html5.vim'
    Plug 'hail2u/vim-css3-syntax'
    Plug 'cakebaker/scss-syntax.vim', { 'for': 'scss' }
    Plug 'Jxnblk/vim-mdx-js'
    Plug 'yuezk/vim-js'
    Plug 'maxmellon/vim-jsx-pretty'
    let g:vim_jsx_pretty_highlight_close_tag = 1

" language server
    Plug 'neoclide/coc.nvim', {'branch': 'release'}

    let g:coc_node_path = trim(system('which node'))
    let g:coc_npm_path = trim(system('which npm'))

    " Use `gp` and `gn` to navigate diagnostics
    nmap <silent>gp <Plug>(coc-diagnostic-prev)
    nmap <silent>gn <Plug>(coc-diagnostic-next)

    " Remap keys for gotos
    nmap <silent> gd <Plug>(coc-definition)
    nmap <silent> gi <Plug>(coc-implementation)
    nmap <silent> gr <Plug>(coc-references)

    nmap <leader>rn <Plug>(coc-rename)
    nmap <leader>rf <Plug>(coc-refactor)

    nmap <leader>f  <Plug>(coc-fix-current)

    " Use tab for trigger completion with characters ahead and navigate.
    inoremap <silent><expr> <TAB>
          \ pumvisible() ? "\<C-n>" :
          \ <SID>check_back_space() ? "\<TAB>" :
          \ coc#refresh()
    inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

    function! s:check_back_space() abort
      let col = col('.') - 1
      return !col || getline('.')[col - 1]  =~# '\s'
    endfunction

    " Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
    " Coc only does snippet and additional edit on confirm.
    " inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
    " Or use `complete_info` if your vim support it, like:
    inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

    " Highlight symbol under cursor on CursorHold
    autocmd CursorHold * silent call CocActionAsync('highlight')


" snippets
    Plug 'SirVer/ultisnips'
    let g:UltiSnipsExpandTrigger="<c-j>"

    Plug 'honza/vim-snippets'

" appearance
    Plug 'kshenoy/vim-signature'
    Plug 'daviesjamie/vim-base16-lightline'
    Plug 'itchyny/lightline.vim'
    Plug 'chriskempson/base16-vim'

    let g:lightline = {
      \ 'colorscheme': 'base16',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'filename' ],
      \             [ 'readonly', 'cocstatus', 'currentfunction', 'modified' ] ],
      \  'right': [ [ 'lineinfo' ],
      \              [ 'percent' ],
      \              [ 'gitbranch' ] ]
      \ },
      \ 'component_function': {
      \   'cocstatus': 'coc#status',
      \   'currentfunction': 'CocCurrentFunction',
      \   'gitbranch': 'FugitiveHead'
      \ },
      \ }
    let g:coc_status_error_sign = '✘'
    let g:coc_status_warning_sign = '♠'

    " syntax highlighting
    set t_Co=256
    set synmaxcol=420
    set background=dark

" fzf/ag
    Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' } 
    Plug 'junegunn/fzf.vim'
    Plug 'mileszs/ack.vim'

" misc
    Plug 'mbbill/undotree'
    Plug 'tpope/vim-fugitive'
    Plug 'jreybert/vimagit'
    Plug 'editorconfig/editorconfig-vim'
    Plug 'tpope/vim-commentary'
    Plug 'tpope/vim-surround'

    command! -bang -nargs=* Ag call fzf#vim#ag(<q-args>, {'options': '--delimiter : --nth 4..'}, <bang>0)

    if executable('ag')
      let g:ackprg = 'ag --vimgrep'
    endif

    let $FZF_DEFAULT_COMMAND = 'ag -l -g ""'

call plug#end()

" colorscheme
    if filereadable(expand("~/.vimrc_background"))
        let base16colorspace=256
        source ~/.vimrc_background
    else
        colorscheme base16-default-dark
    endif

    syntax on
    filetype plugin indent on

augroup general
    autocmd!
    if !isdirectory($HOME."/.vim/backup")
        call mkdir($HOME."/.vim/backupp", "p")
    endif
    if !isdirectory($HOME."/.vim/undo")
        call mkdir($HOME."/.vim/undo", "p")
    endif
    if !filereadable($HOME."/.vim/autoload/plug.vim")
        call system("curl -fLo ~/.vim/autoload/plug.vim --create-dirs 
                    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim")
    endif

    autocmd TermOpen * setlocal nonumber norelativenumber
augroup END

" settings
    " code formatting
    set breakindent
    set tabstop=2
    set softtabstop=2   " number of spaces in tab when editing
    set shiftwidth=2
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
    set laststatus=2 " show statusline (same for tabline): (0|never, 1|when needed; 2|always)
    set noshowmode "hide -- INSERT --, etc. at the bottom because lightline takes care of that
    set showtabline=0
    set ruler "show the cursor position all the time at bottom right corner
    set showcmd " display incomplete commands
    set relativenumber " relative numbering to the current line
    set number " hybrid mode with relative number: current is the actual and not 0
    set wildmenu
    set cursorline
    set list
    set listchars=trail:•,nbsp:≡
    set fillchars=vert:│
    set colorcolumn=120 " displays a vertical line at column 120

    " behavior settings
    set autoread " detect when a file is changed
    set inccommand=nosplit
    set ignorecase
    set smartcase
    set history=1000 " number of commands to keep in history
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
    set backspace=indent,eol,start  " more powerful backspacing
    set updatetime=300
    set shortmess+=c " don't give |ins-completion-menu| messages.
    set signcolumn=yes

" keybindings
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

    " keep visual selection when indenting/outdenting
    vmap < <gv
    vmap > >gv

    " new keybindings
    nnoremap <esc> :nohlsearch<CR><C-l>

    nnoremap <leader>s :%s/
    vnoremap <leader>s y:%s/<C-r>"//g<left><left>

    nnoremap <leader>S :w ! sudo tee %<cr>

    nnoremap <leader>e :Files<CR>
    nnoremap <leader>a :Ag<CR>
    nnoremap <leader>/ :BLines<CR>
    nnoremap <leader>g :GFiles?<CR>
    nnoremap <leader>b :Buffers<CR>
    nnoremap <leader><leader> :b#<cr>

    nnoremap <leader>d "_d
    vnoremap <leader>d "_d
    onoremap <leader>d "_d
    nnoremap <leader>y "+y
    vnoremap <leader>y "+y
    onoremap <leader>y "+y

    nnoremap <leader>m :Marks<CR>
    nnoremap <leader>u :UndotreeToggle<CR>

    " nnoremap <leader>r :te time ./%<cr>
    " nnoremap <leader>R :te time ./%<space>

    inoremap <c-l> <esc>la
    inoremap <c-h> <esc>i
    inoremap <c-b> {<cr>}<esc>==O<esc>cc
