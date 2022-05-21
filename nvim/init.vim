call plug#begin()

let mapleader=" "

" neovim >0.5 stuff
  Plug 'neovim/nvim-lspconfig'
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update
  Plug 'alexlafroscia/tree-sitter-glimmer'
  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-telescope/telescope.nvim'
  Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
  Plug 'SmiteshP/nvim-gps'
  Plug 'kyazdani42/nvim-web-devicons'
  Plug 'ethanholz/nvim-lastplace'
  Plug 'windwp/nvim-autopairs'

" snippets and completion
  Plug 'hrsh7th/cmp-nvim-lsp'
  Plug 'hrsh7th/cmp-buffer'
  Plug 'hrsh7th/cmp-path'
  Plug 'hrsh7th/cmp-cmdline'
  Plug 'hrsh7th/nvim-cmp'
  Plug 'L3MON4D3/LuaSnip'
  Plug 'rafamadriz/friendly-snippets'

  Plug 'numToStr/Comment.nvim'
  Plug 'lewis6991/gitsigns.nvim'

" webdev
  Plug 'mattn/emmet-vim' " TODO still needed?
  Plug 'maxmellon/vim-jsx-pretty' " TODO still needed?
  let g:vim_jsx_pretty_highlight_close_tag = 1
  Plug 'jparise/vim-graphql'
  Plug 'joukevandermaas/vim-ember-hbs'
  Plug 'evanleck/vim-svelte', {'branch': 'main'}
  Plug 'pantharshit00/vim-prisma'

" appearance
  Plug 'gruvbox-community/gruvbox'

  Plug 'mbbill/undotree'
  Plug 'kyazdani42/nvim-tree.lua'
  Plug 'nvim-lualine/lualine.nvim'

" misc
  Plug 'kshenoy/vim-signature' " place, toggle and display marks
  Plug 'editorconfig/editorconfig-vim'
  Plug 'tpope/vim-surround'

  Plug 'glepnir/dashboard-nvim'
  let g:dashboard_default_executive ='telescope'
  let g:dashboard_custom_header = [
\ ' ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗',
\ ' ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║',
\ ' ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║',
\ ' ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║',
\ ' ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║',
\ ' ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝',
\]

call plug#end()

" colorscheme
    set synmaxcol=420
    colorscheme gruvbox

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
    set undofile
    set undolevels=10000
    set undoreload=10000
    set nohidden "doesn't allow switching between buffers without saving them
    set shiftround
    set updatetime=300
    set signcolumn=yes
    set suffixesadd+=.js,.jsx

    " completion
    set completeopt=menu,menuone,noselect

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

    nnoremap <leader>gb :Gitsigns blame_line<CR>
    nnoremap <leader>gd :Gitsigns diffthis ~1<CR>
    nnoremap <leader>u :UndotreeToggle<CR>
    nnoremap <leader>f :NvimTreeFindFileToggle<CR>

    nnoremap <silent>gn :lua vim.lsp.diagnostic.goto_next()<cr>
    nnoremap <silent>gp :lua vim.lsp.diagnostic.goto_prev()<cr>
    nnoremap <silent>gd <cmd>Telescope lsp_definitions<cr>
    nnoremap <silent>gr <cmd>Telescope lsp_references<cr>
    nnoremap <leader>ca <cmd>Telescope lsp_code_actions theme=cursor<cr>
    nnoremap <leader>cc :lua vim.lsp.diagnostic.show_line_diagnostics()<cr>
    nnoremap <leader>cr :lua vim.lsp.buf.rename()<cr>

    inoremap <c-l> <Right>
    inoremap <c-h> <Left>

lua << EOF
local gps = require("nvim-gps")
gps.setup{
    icons = {
        ["class-name"] = '',      -- Classes and class-like objects
        ["function-name"] = '',   -- Functions
        ["method-name"] = '',     -- Methods (functions inside class-like objects)
        ["tag-name"] = ''         -- Tags (example: html tags)
    },
}

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
      {
          gps.get_location,
          cond = gps.is_available,
          fmt = function(str) if #str ~= 0 then return '> ' .. str else return '' end end,
          padding = {left = 0}}},
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
require('telescope').load_extension('fzf')

require'lspconfig'.tsserver.setup{}
require'lspconfig'.eslint.setup{}
require'lspconfig'.ember.setup{}

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = false
  }
)

local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local luasnip = require("luasnip")
local cmp = require("cmp")
cmp.setup({
  mapping = {
    ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
    ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
    ['<C-e>'] = cmp.mapping({
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    }),
    -- Accept currently selected item. If none selected, `select` first item.
    -- Set `select` to `false` to only confirm explicitly selected items.
    ['<CR>'] = cmp.mapping.confirm({ select = false }),
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
require("luasnip/loaders/from_vscode").lazy_load()
require('Comment').setup()
require('gitsigns').setup()
require'nvim-tree'.setup{
  view = {
    width = 40
  }
}
require'nvim-web-devicons'.setup()
require'nvim-lastplace'.setup {
    lastplace_ignore_buftype = {"quickfix", "nofile", "help"},
    lastplace_ignore_filetype = {"gitcommit", "gitrebase", "svn", "hgcommit"},
}
require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
  },
}

require('nvim-autopairs').setup{}
EOF
