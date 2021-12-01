call plug#begin()

let mapleader=" "

" neovim 0.5 stuff
  Plug 'neovim/nvim-lspconfig'
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update
  Plug 'nvim-lua/popup.nvim'
  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-telescope/telescope.nvim'
  Plug 'hrsh7th/nvim-cmp'

" webdev
  Plug 'mattn/emmet-vim'
  Plug 'othree/html5.vim'
  Plug 'hail2u/vim-css3-syntax'
  Plug 'cakebaker/scss-syntax.vim', { 'for': 'scss' }
  Plug 'Jxnblk/vim-mdx-js'
  Plug 'yuezk/vim-js'
  Plug 'maxmellon/vim-jsx-pretty'
  let g:vim_jsx_pretty_highlight_close_tag = 1
  Plug 'jparise/vim-graphql'

" snippets
  Plug 'SirVer/ultisnips'
  let g:UltiSnipsExpandTrigger="<c-j>"

  Plug 'honza/vim-snippets'
  " TODO add more snippets

" appearance
  Plug 'nvim-lualine/lualine.nvim'
  Plug 'gruvbox-community/gruvbox'

  " syntax highlighting
  set t_Co=256
  set synmaxcol=420

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
    syntax on
    set background=dark
    colorscheme gruvbox

    filetype plugin indent on

augroup general
    autocmd!
    if !filereadable($HOME."/.vim/autoload/plug.vim")
        call system("curl -fLo ~/.vim/autoload/plug.vim --create-dirs 
                    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim")
    endif

    autocmd TermOpen * setlocal nonumber norelativenumber
    autocmd TermOpen * startinsert

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

    " completion
    set completeopt=menuone,noselect
    let g:compe = {}
    let g:compe.enabled = v:true
    let g:compe.autocomplete = v:true
    let g:compe.debug = v:false
    let g:compe.min_length = 1
    let g:compe.preselect = 'enable'
    let g:compe.throttle_time = 80
    let g:compe.source_timeout = 200
    let g:compe.resolve_timeout = 800
    let g:compe.incomplete_delay = 400
    let g:compe.max_abbr_width = 100
    let g:compe.max_kind_width = 100
    let g:compe.max_menu_width = 100
    let g:compe.documentation = v:true

    let g:compe.source = {}
    let g:compe.source.path = v:true
    let g:compe.source.buffer = v:true
    let g:compe.source.calc = v:true
    let g:compe.source.nvim_lsp = v:true
    let g:compe.source.nvim_lua = v:false
    let g:compe.source.vsnip = v:false
    let g:compe.source.ultisnips = v:true
    let g:compe.source.luasnip = v:false
    let g:compe.source.emoji = v:false

    inoremap <silent><expr> <TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
    inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

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

    nnoremap <leader>e <cmd>Telescope find_files<cr>
    nnoremap <leader>a <cmd>Telescope live_grep<cr>
    nnoremap <leader>b <cmd>Telescope buffers<cr>
    nnoremap <leader>p <cmd>Telescope commands<cr>
    nnoremap <leader>h <cmd>Telescope oldfiles<cr>
    nnoremap <leader><leader> :b#<cr>

    nnoremap <leader>gg :FloatermNew --width=0.8 --height=0.8 --title=lazygit --name=lazygit lazygit<cr>
    nnoremap <leader>gb :Git blame<cr>
    nnoremap <leader>t :FloatermToggle --width=0.8 --height=0.8 --title=sh --name=sh<cr>
    nnoremap <leader>u :UndotreeToggle<CR>

    nnoremap <silent>gn :lua vim.lsp.diagnostic.goto_next()<cr>
    nnoremap <silent>gp :lua vim.lsp.diagnostic.goto_prev()<cr>
    nnoremap <silent>gd <cmd>Telescope lsp_definitions<cr>
    nnoremap <silent>gr <cmd>Telescope lsp_references<cr>
    nnoremap <leader>ca <cmd>Telescope lsp_code_actions<cr>
    nnoremap <leader>cc :lua vim.lsp.diagnostic.show_line_diagnostics()<cr>

    inoremap <c-l> <Right>
    inoremap <c-h> <Left>
    inoremap <c-b> {<cr>}<esc>==O<esc>cc

lua << EOF
require'lualine'.setup{
  options = {
    section_separators = '',
    component_separators = '',
    icons_enabled = false,
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {
                  {'diagnostics', sources={'nvim_lsp'}}},
    lualine_c = {'filename'},
    lualine_x = {'branch'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
}

require'telescope'.setup{
  defaults = {
    file_sorter =  require'telescope.sorters'.get_fzy_sorter,
  }
}

require'lspconfig'.tsserver.setup{}
require'lspconfig'.eslint.setup{}

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = false
  }
)
EOF
