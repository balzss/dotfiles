call plug#begin()

" lsp
  Plug 'neovim/nvim-lspconfig'
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
  Plug 'glepnir/lspsaga.nvim', { 'branch': 'main' }

" telescope
  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-telescope/telescope.nvim'
  Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }

" snippets and completion
  Plug 'hrsh7th/cmp-nvim-lsp'
  Plug 'hrsh7th/cmp-buffer'
  Plug 'hrsh7th/cmp-path'
  Plug 'hrsh7th/nvim-cmp'
  Plug 'L3MON4D3/LuaSnip'
  Plug 'rafamadriz/friendly-snippets'

" editing
  Plug 'numToStr/Comment.nvim'
  Plug 'editorconfig/editorconfig-vim'
  Plug 'tpope/vim-surround'
  Plug 'ethanholz/nvim-lastplace'
  Plug 'windwp/nvim-autopairs'
  Plug 'mattn/emmet-vim'
  Plug 'tpope/vim-repeat'

" appearance and UI
  Plug 'gruvbox-community/gruvbox'
  Plug 'lewis6991/gitsigns.nvim'
  Plug 'mbbill/undotree'
  Plug 'nvim-lualine/lualine.nvim'
  Plug 'kshenoy/vim-signature' " place, toggle and display marks
  Plug 'kyazdani42/nvim-web-devicons'
  Plug 'tpope/vim-fugitive'
  Plug 'romgrk/barbar.nvim'

call plug#end()

filetype plugin indent on

" colorscheme
    set synmaxcol=420
    colorscheme gruvbox

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
    set foldmethod=expr
    set foldlevel=99
    set foldexpr=nvim_treesitter#foldexpr()

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
    set undofile
    set undolevels=10000
    set undoreload=10000
    set nohidden "doesn't allow switching between buffers without saving them
    set shiftround
    set updatetime=50
    set signcolumn=yes
    set suffixesadd+=.js,.jsx
    set mouse=

    " completion
    set completeopt=menu,menuone,noselect

" keybindings
    let mapleader=" "

    " modified default keybindings
    onoremap H ^
    vnoremap H ^
    nnoremap H ^
    onoremap L $
    vnoremap L $h
    nnoremap L $
    nnoremap M J
    vnoremap M J
    nnoremap U <c-r> " better redo
    vnoremap y ygv<esc>

    " keep visual selection when indenting/outdenting
    vmap < <gv
    vmap > >gv

    " remove highlights on escape
    nnoremap <esc> :nohlsearch<cr><C-l>

    nnoremap <leader><cr> :so ~/.config/nvim/init.vim<cr>

    " save and quit
    nnoremap <leader>s :w<cr>
    nnoremap <c-s> :w<cr>
    nnoremap <leader>q :q<cr>
    nnoremap <leader>Q :q!<cr>

    " copy/paste
    nnoremap <leader>y "+y
    vnoremap <leader>y "+y
    onoremap <leader>y "+y
    xnoremap <leader>p "_dP
    nmap <leader>Y "+Y
    nnoremap <leader>d "_d
    vnoremap <leader>d "_d

    " search and replace visually selected text
    vnoremap <leader>/ y:%s/<C-r>"//g<left><left>

    nnoremap <c-l> <c-w>l
    nnoremap <c-h> <c-w>h
    nnoremap <c-j> <c-w>j
    nnoremap <c-k> <c-w>k

    " navigation
    nnoremap <leader>e <cmd>Telescope find_files<cr>
    nnoremap <leader>a <cmd>Telescope live_grep<cr>
    nnoremap <leader>b <cmd>Telescope buffers<cr>
    nnoremap <leader>o <cmd>Telescope oldfiles<cr>
    nnoremap <leader><leader> :b#<cr>
    nnoremap <leader>n :bnext<cr>
    nnoremap <leader>p :bprev<cr>

    " git
    nnoremap <leader>gb :Git blame<cr>
    nnoremap <leader>gd :Gitsigns diffthis ~1<cr>
    nnoremap <leader>gs :lua require'telescope.builtin'.git_status{}<cr>

    nnoremap <leader>u :UndotreeToggle<cr>

    " code navigation + formatting
    nnoremap <silent>gd :Telescope lsp_definitions<cr>
    nnoremap <silent>gr :Telescope lsp_references<cr>
    nnoremap <silent>K :Lspsaga hover_doc<cr>

    nnoremap <leader>cc :Lspsaga show_cursor_diagnostics<cr>
    nnoremap <leader>cr :Lspsaga rename<cr>
    nnoremap <leader>ca :Lspsaga code_action<cr>
    vnoremap <leader>ca :<C-U>Lspsaga range_code_action<cr>
    nnoremap <leader>cn :Lspsaga diagnostic_jump_next<cr>
    vnoremap <leader>cp :Lspsaga diagnostic_jump_prev<cr>

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
    lualine_c = {
      {'filename'},
    },
    lualine_x = {'branch'},
    lualine_y = {'progress'},
    lualine_z = {'location', 'filetype'}
  },
}

require'telescope'.setup{
  defaults = {
    mappings = {
      i = {
        ["<esc>"] = require('telescope.actions').close,
        ["<c-j>"] = require('telescope.actions').move_selection_next,
        ["<c-k>"] = require('telescope.actions').move_selection_previous,
        ["<c-t>"] = require('telescope.actions.layout').toggle_preview,
        ["<c-l>"] = require('telescope.actions').select_vertical,
      },
    },
    sorting_strategy = 'ascending',
    layout_config = {
      prompt_position = 'top'
    }
  },
  pickers = {
      buffers = {
          ignore_current_buffer = true,
          sort_lastused = true,
      },
  },
  extensions = {
    fzf = {
      fuzzy = true,                    -- false will only do exact matching
      override_generic_sorter = true,  -- override the generic sorter
      override_file_sorter = true,     -- override the file sorter
      case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                                       -- the default case_mode is "smart_case"
    }
  }
}
require'telescope'.load_extension('fzf')

require'lspconfig'.tsserver.setup{}
require'lspconfig'.eslint.setup{}

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = false
  }
)

local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local luasnip = require'luasnip'
local cmp = require'cmp'
cmp.setup({
  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
      require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
    end,
  },
  mapping = {
    ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
    ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
    ['<C-e>'] = cmp.mapping({
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    }),
    -- Accept currently selected item. If none selected, `select` first item.
    -- Set `select` to `false` to only confirm explicitly selected items.
    ['<cr>'] = cmp.mapping.confirm({ select = false }),
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      elseif has_words_before() then
        cmp.complete()
      else
        fallback()
      end
    end, { "i", "s" }),

    ["<C-j>"] = cmp.mapping(function(fallback)
      if luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      end
    end, { "i", "s" }),

    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'buffer' },
  })
})

require'luasnip'.filetype_extend("typescriptreact", {"javascript"})
require'luasnip'.filetype_extend("typescript", {"javascript"})
require'luasnip/loaders/from_vscode'.lazy_load()
require'Comment'.setup()
require'gitsigns'.setup()
require'nvim-web-devicons'.setup()
require'nvim-lastplace'.setup {
    lastplace_ignore_buftype = {"quickfix", "nofile", "help"},
    lastplace_ignore_filetype = {"gitcommit", "gitrebase", "svn", "hgcommit"},
}
require'nvim-treesitter.configs'.setup {
  ensure_installed = {
    "bash",
    "css",
    "html",
    "javascript",
    "lua",
    "markdown",
    "toml",
    "typescript",
    "yaml",
    "vim",
    "python",
    "haskell",
    "prisma",
    "graphql",
  },
  highlight = {
    enable = true,
  },
}

require'nvim-autopairs'.setup{}

require'lspsaga'.init_lsp_saga {}
EOF
