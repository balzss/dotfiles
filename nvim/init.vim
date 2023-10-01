call plug#begin()

" lsp
  Plug 'neovim/nvim-lspconfig'
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
  Plug 'glepnir/lspsaga.nvim', { 'branch': 'main' }

" telescope
  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-telescope/telescope.nvim'
  Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
  Plug 'debugloop/telescope-undo.nvim'
  Plug 'nvim-telescope/telescope-file-browser.nvim'

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

" syntax
  Plug 'jparise/vim-graphql'
  Plug 'pantharshit00/vim-prisma'
  Plug 'MrcJkb/haskell-tools.nvim'
  Plug 'tidalcycles/vim-tidal'
  Plug 'davidgranstrom/scnvim'

" appearance and UI
  Plug 'gruvbox-community/gruvbox'
  Plug 'nvim-lualine/lualine.nvim'
  Plug 'kyazdani42/nvim-web-devicons'
  Plug 'nvim-tree/nvim-tree.lua'
  Plug 'lewis6991/gitsigns.nvim'

call plug#end()

filetype plugin indent on

" colorscheme
    colorscheme gruvbox

" settings
    " code formatting
    set tabstop=2
    set shiftwidth=2
    set expandtab
    set showbreak=>>    " indicate wrapped text

    " layout
    set noshowmode "hide -- INSERT --, etc. at the bottom because lualine also displays that
    set showtabline=0
    set relativenumber " relative numbering to the current line
    set number " hybrid mode with relative number: current is the actual and not 0
    set cursorline
    set list

    " behavior settings
    set ignorecase
    set smartcase
    set scrolloff=30 " keep active line in the middle of the screen
    set splitbelow
    set splitright
    set undofile
    set undolevels=10000
    set undoreload=10000
    set nohidden "doesn't allow switching between buffers without saving them
    set shiftround
    set suffixesadd+=.js,.jsx
    set mouse=

    " completion
    set completeopt=menu,menuone,noselect

au BufNewFile,BufRead *.frag,*.vert,*.fp,*.vp,*.glsl set filetype=glsl

" keybindings
    let mapleader=" "

    " modified default keybindings
    onoremap H ^
    vnoremap H ^
    nnoremap H ^
    onoremap L $
    vnoremap L $h
    nnoremap L $
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

    " navigation
    nnoremap <leader>e <cmd>Telescope find_files<cr>
    nnoremap <leader>a <cmd>Telescope live_grep<cr>
    nnoremap <leader>b <cmd>Telescope buffers<cr>
    nnoremap <leader>o <cmd>Telescope oldfiles<cr>
    nnoremap <leader><leader> :b#<cr>
    nnoremap <leader>n :bnext<cr>
    nnoremap <leader>p :bprev<cr>

    nnoremap <leader>t :Telescope file_browser<cr>

    nnoremap <leader>v :vsplit<cr>
    nnoremap <leader>l <c-w>l
    nnoremap <leader>h <c-w>h

    " git
    nnoremap <leader>gs :lua require'telescope.builtin'.git_status{}<cr>

    " code navigation + formatting
    nnoremap <silent>gd :Telescope lsp_definitions<cr>
    nnoremap <silent>gr :Telescope lsp_references<cr>
    nnoremap <silent>K :Lspsaga hover_doc<cr>

    nnoremap <leader>cc :Lspsaga show_cursor_diagnostics<cr>
    nnoremap <leader>cr :Lspsaga rename<cr>
    nnoremap <leader>ca :Lspsaga code_action<cr>
    vnoremap <leader>ca :<C-U>Lspsaga range_code_action<cr>
    nnoremap <silent>gn :Lspsaga diagnostic_jump_next<cr>
    nnoremap <silent>gp :Lspsaga diagnostic_jump_prev<cr>

    nnoremap <leader>u :Telescope undo<cr>

lua << EOF

-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- empty setup using defaults
require("nvim-tree").setup({
  view = {
    width = 48,
  },
})


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
require'telescope'.load_extension('undo')
require'telescope'.load_extension('file_browser')

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
require'luasnip'.filetype_extend("tidal", {"haskell"})
require'luasnip'.filetype_extend("typescript", {"javascript"})
require'luasnip/loaders/from_vscode'.lazy_load()
require'gitsigns'.setup{
  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns

    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    map('n', '<leader>gb', function() gs.blame_line{full=true} end)
    map('n', '<leader>gd', gs.diffthis)
  end
}

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

local scnvim = require 'scnvim'
local map = scnvim.map
local map_expr = scnvim.map_expr
scnvim.setup {
  keymaps = {
    ['<M-e>'] = map('editor.send_line', {'i', 'n'}),
    ['<C-e>'] = {
      map('editor.send_block', {'i', 'n'}),
      map('editor.send_selection', 'x'),
    },
    ['<CR>'] = map('postwin.toggle'),
    ['<M-CR>'] = map('postwin.toggle', 'i'),
    ['<M-L>'] = map('postwin.clear', {'n', 'i'}),
    ['<C-k>'] = map('signature.show', {'n', 'i'}),
    ['<F1>'] = map_expr('s.boot'),
    ['<F2>'] = map_expr('s.meter'),
  },
  editor = {
    highlight = {
      color = 'IncSearch',
    },
  },
  postwin = {
    float = {
      enabled = true,
    },
  },
}

require'Comment'.setup()
local ft = require('Comment.ft')
ft.set('tidal', ft.get('haskell'))

require('lspsaga').setup({})

EOF
