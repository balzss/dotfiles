﻿call plug#begin()

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

    let g:coc_global_extensions = [
          \ 'coc-tsserver',
          \ 'coc-eslint',
          \ 'coc-prettier',
          \ ]

    let g:coc_node_path = trim(system('which node'))
    let g:coc_npm_path = trim(system('which npm'))

    function! s:check_back_space() abort
      let col = col('.') - 1
      return !col || getline('.')[col - 1]  =~# '\s'
    endfunction

    " Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
    " Coc only does snippet and additional edit on confirm.
    " inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
    " Or use `complete_info` if your vim support it, like:
    inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

    inoremap <silent><expr> <TAB>
          \ pumvisible() ? "\<C-n>" :
          \ <SID>check_back_space() ? "\<TAB>" :
          \ coc#refresh()
    inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"


" snippets
    Plug 'SirVer/ultisnips'
    let g:UltiSnipsExpandTrigger="<c-j>"

    Plug 'honza/vim-snippets'
    " TODO add more snippets

" appearance
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

" fzf/ag
    Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' } 
    Plug 'junegunn/fzf.vim'
    Plug 'mileszs/ack.vim'

    command! -bang -nargs=* Ag call fzf#vim#ag(<q-args>, {'options': '--delimiter : --nth 4..'}, <bang>0)

    if executable('ag')
      let g:ackprg = 'ag --vimgrep'
    endif
    " TODO try ripgrep instead

    let g:fzf_layout = { 'window': { 'width': 0.8, 'height': 0.8 } }
    let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --glob "!**/.git/**"'
    let $FZF_DEFAULT_OPTS="--preview-window 'right:60%' --layout reverse"

" new text objects
    Plug 'kana/vim-textobj-user'
    Plug 'kana/vim-textobj-function'
    Plug 'haya14busa/vim-textobj-function-syntax'
    Plug 'inside/vim-textobj-jsxattr'

" misc
    Plug 'tpope/vim-fugitive'
    Plug 'kshenoy/vim-signature' " place, toggle and display marks
    Plug 'mbbill/undotree'
    Plug 'editorconfig/editorconfig-vim'
    Plug 'tpope/vim-commentary'
    Plug 'tpope/vim-surround'
    Plug 'voldikss/vim-floaterm'

    let g:floaterm_opener = 'edit'
    let g:floaterm_autoclose = 1

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
        call mkdir($HOME."/.vim/backup", "p")
    endif

    if !isdirectory($HOME."/.vim/undo")
        call mkdir($HOME."/.vim/undo", "p")
    endif

    if !filereadable($HOME."/.vim/autoload/plug.vim")
        call system("curl -fLo ~/.vim/autoload/plug.vim --create-dirs 
                    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim")
    endif

    autocmd TermOpen * setlocal nonumber norelativenumber
    autocmd TermOpen * startinsert

    " Highlight symbol under cursor on CursorHold
    autocmd CursorHold * silent call CocActionAsync('highlight')

    autocmd BufReadPost,FileReadPost,BufNewFile,BufEnter * call system("tmux rename-window vim")
    autocmd VimLeave * call system("tmux setw automatic-rename")
augroup END

" settings
    " code formatting
    set tabstop=2       " only needed for files that have mixed tabs and spaces so probably could be dropped
    set softtabstop=2   " number of spaces in tab when editing
    set shiftwidth=2
    set expandtab
    set breakindent
    set linebreak       " break line only between words
    set showbreak=>>    " indicate wrapped text
    set textwidth=120
    set foldmethod=syntax
    set foldlevel=99

    " layout
    set noshowmode "hide -- INSERT --, etc. at the bottom because lightline takes care of that
    set showtabline=0
    set relativenumber " relative numbering to the current line
    set number " hybrid mode with relative number: current is the actual and not 0
    set cursorline
    set list
    set colorcolumn=120 " displays a vertical line at column 120

    " behavior settings
    set inccommand=nosplit
    set ignorecase
    set smartcase
    set lazyredraw "redraw only when we need to
    set scrolloff=30 "doesn't get close to the edge when scrolling
    set splitbelow
    set splitright
    set backupdir=$HOME/.vim/backup
    set undofile
    set undodir=$HOME/.vim/undo
    set undolevels=10000
    set undoreload=10000
    set nohidden "doesn't allow switching between buffers without saving them
    set shiftround
    set updatetime=300
    set signcolumn=yes
    set suffixesadd+=.js,.jsx

" keybindings
    " modified default keybindings
    onoremap H ^
    vnoremap H ^
    nnoremap H ^
    onoremap L $
    vnoremap L $h
    nnoremap L $
    nnoremap J }
    vnoremap J }
    nnoremap K {
    vnoremap K {
    nnoremap M J
    nnoremap U <c-r>
    vnoremap y ygv<esc>

    " keep visual selection when indenting/outdenting
    vmap < <gv
    vmap > >gv

    " remove highlights on escape
    nnoremap <esc> :nohlsearch<CR><C-l>

    " save and quit
    nnoremap <leader>s :w<cr>
    nnoremap <leader>S :w ! sudo tee %<cr>
    nnoremap <leader>q :q<cr>
    nnoremap <leader>Q :q!<cr>
    " temporarily disabling `s` until I stop using it for saving
    nnoremap s <nop>

    nnoremap <leader>y "+y
    vnoremap <leader>y "+y
    onoremap <leader>y "+y

    " search and replace visually selected text
    vnoremap <leader>/ y:%s/<C-r>"//g<left><left>

    function! RipgrepFzf (query, fullscreen)
      let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case -- %s || true'
      let initial_command = printf(command_fmt, shellescape(a:query))
      call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview({'options': '--delimiter : --nth 2..'}))
    endfunction
    command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)

    nnoremap <leader>a :RG<CR>
    nnoremap <leader>e :Files<cr>
    nnoremap <leader>p :Commands<CR>
    nnoremap <leader>b :Buffers<CR>
    nnoremap <leader><leader> :b#<cr>

    nnoremap <leader>gg :FloatermNew --width=0.8 --height=0.8 --title=lazygit --name=lazygit lazygit<cr>
    nnoremap <leader>t :FloatermToggle --width=0.8 --height=0.8 --title=sh --name=sh<cr>
    nnoremap <leader>u :UndotreeToggle<CR>

    nnoremap <silent><nowait> <leader>co  :<C-u>CocList outline<cr>
    nnoremap <leader>cf :CocFix<cr>
    nmap <leader>cr <Plug>(coc-rename)
    nmap <silent>gp <Plug>(coc-diagnostic-prev)
    nmap <silent>gn <Plug>(coc-diagnostic-next)
    nmap <silent>gd <Plug>(coc-definition)
    nmap <silent> <C-s> <Plug>(coc-range-select)
    xmap <silent> <C-s> <Plug>(coc-range-select)

    inoremap <c-l> <Right>
    inoremap <c-h> <Left>
    inoremap <c-b> {<cr>}<esc>==O<esc>cc
