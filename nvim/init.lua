-- Set <space> as the leader key
-- NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Install package manager
--    https://github.com/folke/lazy.nvim
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  -- Detect tabstop and shiftwidth automatically
  'tpope/vim-sleuth',

  'nvim-tree/nvim-web-devicons',
  'tpope/vim-fugitive',
  'nvim-pack/nvim-spectre',
  'davidgranstrom/scnvim',
  'tidalcycles/vim-tidal',

  {
    'ethanholz/nvim-lastplace',
    opts = {
      lastplace_ignore_buftype = {'quickfix', 'nofile', 'help'},
      lastplace_ignore_filetype = {'gitcommit', 'gitrebase', 'svn', 'hgcommit'},
    }
  },

  -- NOTE: This is where your plugins related to LSP can be installed.
  --  The configuration is done below. Search for lspconfig to find it below.
  {
    -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs to stdpath for neovim
      { 'williamboman/mason.nvim', config = true },
      'williamboman/mason-lspconfig.nvim',

      -- Useful status updates for LSP
      { 'j-hui/fidget.nvim', tag = 'legacy', opts = {} },

      -- Additional lua configuration, makes nvim stuff amazing!
      { 'folke/neodev.nvim', opts = {
        override = function(root_dir, library)
          -- so neodev works when config is symlinked from a different dir (~/dotfiles)
          if root_dir:find(os.getenv('HOME') .. '/dotfiles', 1, true) == 1 then
            vim.notify(root_dir)
            library.enabled = true
            library.plugins = true
          end
        end,
      } }
    },
  },

  {
    -- Autocompletion
    'hrsh7th/nvim-cmp',
    dependencies = {
      -- Snippet Engine & its associated nvim-cmp source
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',

      -- Adds LSP completion capabilities
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',

      -- Adds a number of user-friendly snippets
      'rafamadriz/friendly-snippets',
    },
  },

  -- Useful plugin to show you pending keybinds.
  { 'folke/which-key.nvim', opts = {} },
  {
    -- Adds git related signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    opts = {
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns
        vim.keymap.set('n', '<leader>gd', gs.diffthis, {buffer = bufnr, desc = 'git [d]iff current file'})
      end,
    },
  },

  {
    'sainnhe/gruvbox-material',
    priority = 1000,
    config = function()
      vim.cmd.colorscheme 'gruvbox-material'
    end,
  },

  {
    -- Set lualine as statusline
    'nvim-lualine/lualine.nvim',
    -- See `:help lualine.txt`
    opts = {
      options = {
        theme = 'auto',
        icons_enabled = false,
        component_separators = '',
        section_separators = '',
      },
      sections = {
        lualine_a = {'mode'},
        lualine_b = {
          {'diagnostics', sources={'nvim_lsp'}}
        },
        lualine_c = {
          {'filename', path = 3},
        },
        lualine_x = {'branch'},
        lualine_y = {'progress'},
        lualine_z = {'location', 'filetype'}
      },
    },
  },

  { 'numToStr/Comment.nvim', opts = {} },

  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    opts = {}
  },

  {
    'kylechui/nvim-surround',
    version = '*', -- Use for stability; omit to use `main` branch for the latest features
    event = 'VeryLazy',
    opts = {},
  },

  -- Fuzzy Finder (files, lsp, etc)
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope-file-browser.nvim',
      'debugloop/telescope-undo.nvim',
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        -- NOTE: If you are having trouble with this installation,
        --       refer to the README for telescope-fzf-native for more instructions.
        build = 'make',
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
    },
  },

  {
    -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    build = ':TSUpdate',
  },

}, {})

-- [[ Setting options ]]
vim.o.termguicolors = true
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.undolevels = 10000
vim.o.shiftround = true

-- Do not allow switching between buffers without saving them
vim.o.hidden = false

-- menuone: show menu when there's only one option; noselect: don't select an option
vim.o.completeopt = 'menu,menuone,noselect'

-- Hide -- INSERT --, etc. at the bottom because lualine also displays that
vim.o.showmode = false

-- Show tabs as `>`, trailing spaces as `-`, &nbsp as `+`
vim.o.list = true

-- Keep active line in the middle of the screen
vim.o.scrolloff = 30

-- Highlight the current active line the cursor in on
vim.o.cursorline = true

-- Set highlight on search
vim.o.hlsearch = false

-- Make line numbers default
vim.wo.number = true
vim.wo.relativenumber = true

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250
-- Increase timeout
vim.o.timeoutlen = 400

-- Disable mouse (this is vim)
vim.o.mouse = ''

-- Keymaps for better default experience
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
vim.keymap.set({'n', 'v'}, 'H', '^')
vim.keymap.set('n', 'L', '$')
vim.keymap.set('v', 'L', '$h')

-- Keep visual selection when indenting/outdenting
vim.keymap.set('v', '<', '<gv')
vim.keymap.set('v', '>', '>gv')

vim.keymap.set('n', '<c-s>', ':w<CR>')
vim.keymap.set('n', '<leader>q', ':q<CR>', { desc = 'Quit neovim' })
vim.keymap.set('n', '<leader><leader>', ':b#<CR>', { desc = 'Switch to previous buffer'} )
vim.keymap.set('n', '<leader>v', ':vsplit<CR>', { desc = 'Vertical split'} )
vim.keymap.set('n', '<c-h>', '<c-w>W')
vim.keymap.set('n', '<c-l>', '<c-w>w')
vim.keymap.set('n', '<c-q>', '<c-w>q')

-- Don't jump cursor on yank
vim.keymap.set('v', 'y', 'ygv<esc>')

-- Copy to system clipboard
vim.keymap.set({'n', 'v'}, '<leader>y', '"+y', { desc = 'Copy to clipboard' })

-- Better redo
vim.keymap.set({'n', 'v'}, 'U', '<c-r>')

vim.keymap.set('n', '<leader>gb', ':Git blame<CR>', { desc = 'git blame' })
vim.keymap.set('n', '<leader>S', '<cmd>lua require("spectre").toggle()<CR>', {
    desc = "Toggle Spectre"
})

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

-- [[ Highlight active pane/window ]]
vim.cmd [[
  augroup BgHighlight
    autocmd!
    autocmd WinEnter * set cul
    autocmd WinLeave * set nocul
  augroup END
]]

-- [[ Configure Telescope ]]
-- See `:help telescope` and `:help telescope.setup()`
local actions = require 'telescope.actions'
require'telescope'.setup{
  defaults = {
    mappings = {
      i = {
        ['<esc>'] = require('telescope.actions').close,
        ['<c-j>'] = require('telescope.actions').move_selection_next,
        ['<c-k>'] = require('telescope.actions').move_selection_previous,
        ['<c-t>'] = require('telescope.actions.layout').toggle_preview,
        ['<c-l>'] = require('telescope.actions').select_vertical,
      },
    },
    sorting_strategy = 'ascending',
    layout_config = {
      prompt_position = 'top'
    }
  },
  pickers = {
    find_files = {
      find_command = { 'fd', '--type', 'f', '--strip-cwd-prefix', '--hidden', '--exclude', '**/.git/' }
    },
    buffers = {
      ignore_current_buffer = true,
      sort_mru = true,
      mappings = {
        i = {
          ['<c-d>'] = actions.delete_buffer + actions.move_to_top,
        }
      }
    }
  }
}

-- Enable telescope extensions, if installed
pcall(require('telescope').load_extension, 'fzf')
pcall(require('telescope').load_extension, 'undo')
pcall(require('telescope').load_extension, 'file_browser')

-- See `:help telescope.builtin`
vim.keymap.set('n', '<leader>o', require('telescope.builtin').oldfiles, { desc = 'Find recently opened files' })
vim.keymap.set('n', '<leader>b', require('telescope.builtin').buffers, { desc = 'Find existing buffers' })
vim.keymap.set('n', '<leader>/', function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = 'Fuzzy search in current buffer' })
vim.keymap.set('n', '<leader>gf', require('telescope.builtin').git_files, { desc = 'Search git files' })
vim.keymap.set('n', '<leader>e', require('telescope.builtin').find_files, { desc = 'Search files' })
-- vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
-- vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>a', require('telescope.builtin').live_grep, { desc = 'Search by grep' })
vim.keymap.set('n', '<leader>cl', require('telescope.builtin').diagnostics, { desc = 'List diagnostics' })
vim.keymap.set('n', '<leader>r', require('telescope.builtin').resume, { desc = '[S]earch [R]esume' })
vim.keymap.set('n', '<leader>gs', require('telescope.builtin').git_status, { desc = 'Git status' })
vim.keymap.set('n', '<leader>t', require 'telescope'.extensions.file_browser.file_browser, { desc = 'File browser' })
vim.keymap.set('n', '<leader>u', require 'telescope'.extensions.undo.undo, { desc = 'Undo history' })

-- [[ Configure Treesitter ]]
-- See `:help nvim-treesitter`
-- Defer Treesitter setup after first render to improve startup time of 'nvim {filename}'
vim.defer_fn(function()
  require('nvim-treesitter.configs').setup {
    -- Add languages to be installed here that you want installed for treesitter
    ensure_installed = { 'bash', 'css', 'html', 'markdown', 'haskell', 'graphql', 'c', 'cpp', 'go', 'lua', 'python', 'rust', 'tsx', 'javascript', 'typescript', 'vimdoc', 'vim' },

    -- Install parsers synchronously (only applied to `ensure_installed`)
    sync_install = false,

    -- List of parsers to ignore installing (or "all")
    ignore_install = {},

    modules = {},

    -- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
    auto_install = false,

    highlight = { enable = true },
    indent = { enable = true },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = '<c-e>',
        node_incremental = '<c-e>',
        -- scope_incremental = '<c-e>',
        -- node_decremental = '<M-space>',
      },
    },
    textobjects = {
      select = {
        enable = true,
        lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
        keymaps = {
          -- You can use the capture groups defined in textobjects.scm
          ['aa'] = '@parameter.outer',
          ['ia'] = '@parameter.inner',
          ['af'] = '@function.outer',
          ['if'] = '@function.inner',
          ['ac'] = '@class.outer',
          ['ic'] = '@class.inner',
        },
      },
      move = {
        enable = true,
        set_jumps = true, -- whether to set jumps in the jumplist
        goto_next_start = {
          [']m'] = '@function.outer',
          [']]'] = '@class.outer',
        },
        goto_next_end = {
          [']M'] = '@function.outer',
          [']['] = '@class.outer',
        },
        goto_previous_start = {
          ['[m'] = '@function.outer',
          ['[['] = '@class.outer',
        },
        goto_previous_end = {
          ['[M'] = '@function.outer',
          ['[]'] = '@class.outer',
        },
      },
      swap = {
        enable = true,
        swap_next = {
          ['<leader>p'] = '@parameter.inner',
        },
        swap_previous = {
          ['<leader>P'] = '@parameter.inner',
        },
      },
    },
  }
end, 0)

-- Diagnostic keymaps
vim.keymap.set('n', 'gp', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', 'gn', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>cd', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })

-- [[ Configure LSP ]]
--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(_, bufnr)
  -- NOTE: Remember that lua is a real programming language, and as such it is possible
  -- to define small helper and utility functions so you don't have to repeat yourself
  -- many times.
  --
  -- In this case, we create a function that lets us more easily define mappings specific
  -- for LSP related items. It sets the mode, buffer and description for us each time.
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  nmap('<leader>cr', vim.lsp.buf.rename, 'Rename')
  nmap('<leader>ca', vim.lsp.buf.code_action, 'Code action')

  nmap('gd', vim.lsp.buf.definition, 'Goto definition')
  nmap('gr', require('telescope.builtin').lsp_references, 'Goto references')
  nmap('gI', require('telescope.builtin').lsp_implementations, 'Goto implementation')

  -- See `:help K` for why this keymap
  nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
  nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

  -- Lesser used LSP functionality
  nmap('gD', vim.lsp.buf.declaration, 'Goto declaration')

  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    vim.lsp.buf.format()
  end, { desc = 'Format current buffer with LSP' })
end

-- document existing key chains
require('which-key').register {
  ['<leader>c'] = { name = 'LSP', _ = 'which_key_ignore' },
  ['<leader>g'] = { name = 'Git', _ = 'which_key_ignore' },
}

require('which-key').setup({
  plugins = {
    presets = {
      operators = false
    }
  },
})

-- mason-lspconfig requires that these setup functions are called in this order
-- before setting up the servers.
require('mason').setup()
require('mason-lspconfig').setup()

-- Enable the following language servers
--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
--
--  Add any additional override configuration in the following tables. They will be passed to
--  the `settings` field of the server config. You must look up that documentation yourself.
--
--  If you want to override the default filetypes that your language server will attach to you can
--  define the property 'filetypes' to the map in question.
local servers = {
  tsserver = {},
  eslint = {},
  html = { filetypes = { 'html', 'twig', 'hbs'} },
  emmet_language_server = {},
  lua_ls = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
    },
  },
}

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Ensure the servers above are installed
local mason_lspconfig = require 'mason-lspconfig'

mason_lspconfig.setup {
  ensure_installed = vim.tbl_keys(servers),
}

mason_lspconfig.setup_handlers {
  function(server_name)
    require('lspconfig')[server_name].setup {
      capabilities = capabilities,
      on_attach = on_attach,
      settings = servers[server_name],
      filetypes = (servers[server_name] or {}).filetypes,
    }
  end,
}

-- [[ Configure nvim-cmp ]]
-- See `:help cmp`
local cmp = require 'cmp'
local luasnip = require 'luasnip'
require('luasnip.loaders.from_vscode').lazy_load()
luasnip.config.setup {}

require'luasnip'.filetype_extend('typescriptreact', {'javascript'})
require'luasnip'.filetype_extend('tidal', {'haskell'})
require'luasnip'.filetype_extend('typescript', {'javascript'})

-- local has_words_before = function()
--   local line, col = unpack(vim.api.nvim_win_get_cursor(0))
--   return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') == nil
-- end

---@diagnostic disable-next-line: missing-fields
cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert {
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete {},
    ['<C-j>'] = cmp.mapping(function(fallback)
      if luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      -- Set `select` to `false` to only confirm explicitly selected items.
      select = false,
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_locally_jumpable() then
        luasnip.expand_or_jump()
      -- elseif has_words_before() then
      --   cmp.complete()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.locally_jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  },
}

-- [[ scnvim ]]
local scnvim = require 'scnvim'
local map = scnvim.map

scnvim.setup({
  keymaps = {
    ['<C-e>'] = {
      map('editor.send_block', {'i', 'n'}),
      map('editor.send_selection', 'x'),
    },
    ['<CR>'] = map('postwin.toggle'),
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
})

-- require'luasnip'.filetype_extend('typescriptreact', {'javascript'})
-- require'luasnip'.filetype_extend('tidal', {'haskell'})
-- require'luasnip'.filetype_extend('typescript', {'javascript'})
-- require'luasnip/loaders/from_vscode'.lazy_load()

-- haskell comments in tidal
require'Comment'.setup()
local ft = require('Comment.ft')
ft.set('tidal', ft.get('haskell') or '')

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
