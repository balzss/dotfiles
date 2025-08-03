-- Set <space> as the leader key
-- NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Install package manager
--   https://github.com/folke/lazy.nvim
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

-- [[ Setting options ]]
-- NOTE: I've moved your options to the top for better organization.
vim.o.termguicolors = true
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.undolevels = 10000
vim.o.shiftround = true
vim.o.hidden = false -- As requested, keeping this false
vim.o.completeopt = 'menu,menuone,noselect'
vim.o.showmode = false
vim.o.list = true
vim.o.scrolloff = 30
vim.o.cursorline = true
vim.o.hlsearch = false -- As requested
vim.wo.number = true
vim.wo.relativenumber = true
vim.o.undofile = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.wo.signcolumn = 'yes'
vim.o.updatetime = 250
vim.o.timeoutlen = 400
vim.o.mouse = ''

-- Default indentation
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2

-- [[ Basic Keymaps ]]
-- NOTE: I've moved your keymaps here for better organization.
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
vim.keymap.set({ 'n', 'v' }, 'H', '^')
vim.keymap.set('n', 'L', '$')
vim.keymap.set('v', 'L', '$h')
vim.keymap.set('v', '<', '<gv')
vim.keymap.set('v', '>', '>gv')
vim.keymap.set("v", "<c-j>", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "<c-k>", ":m '<-2<CR>gv=gv")
vim.keymap.set('n', '<c-s>', ':w<CR>')
vim.keymap.set('n', '<leader>q', ':q<CR>', { desc = 'Close window' })
vim.keymap.set('n', '<leader><leader>', ':b#<CR>', { desc = 'Switch to previous buffer' })
vim.keymap.set('n', '<leader>v', ':vsplit<CR>', { desc = 'Vertical split' })
vim.keymap.set('n', '<c-h>', '<c-w>W') -- As requested
vim.keymap.set('n', '<c-l>', '<c-w>w') -- As requested
vim.keymap.set('n', '<c-q>', '<c-w>q')
vim.keymap.set('v', 'y', 'ygv<esc>')
vim.keymap.set({ 'n', 'v' }, '<leader>y', '"+y', { desc = 'Copy to clipboard' })
vim.keymap.set({ 'n', 'v' }, 'U', '<c-r>')

-- Highlight active pane/window (modern Lua API)
local bg_highlight_group = vim.api.nvim_create_augroup('BgHighlight', { clear = true })
vim.api.nvim_create_autocmd('WinEnter', {
  group = bg_highlight_group,
  pattern = '*',
  command = 'set cul',
})
vim.api.nvim_create_autocmd('WinLeave', {
  group = bg_highlight_group,
  pattern = '*',
  command = 'set nocul',
})

-- [[ lazy.nvim setup ]]
require('lazy').setup({
  -- Automatically detect indentation
  { 'NMAC427/guess-indent.nvim', config = true },

  -- Icons
  'nvim-tree/nvim-web-devicons',

  -- Find and Replace
  {
    'MagicDuck/grug-far.nvim',
    opts = {
      engines = {
        ripgrep = {
          extraArgs = '--multiline',
        },
      },
    },
    keys = {
      { '<leader>S', '<cmd>lua require("grug-far").open({ transient = true })<CR>', desc = "Find and Replace" },
      { '<leader>S', '<cmd>lua require("grug-far").with_visual_selection()<CR>', mode = 'v', desc = "Find and Replace in Selection" },
    },
  },

  -- TypeScript tooling
  {
    'pmizio/typescript-tools.nvim',
    dependencies = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig' },
    opts = {},
  },

  -- Code formatter
  {
    'stevearc/conform.nvim',
    opts = {
      formatters_by_ft = {
        lua = { 'stylua' },
        ['javascript,javascriptreact,typescript,typescriptreact'] = { 'prettierd', 'prettier' },
      },
    },
    keys = {
      {
        '<c-f>',
        function()
          require('conform').format({ async = true, lsp_fallback = true })
        end,
        mode = 'n',
        desc = 'Format buffer',
      },
    },
  },

  -- Restore cursor position
  {
    'ethanholz/nvim-lastplace',
    opts = {
      lastplace_ignore_buftype = { 'quickfix', 'nofile', 'help' },
      lastplace_ignore_filetype = { 'gitcommit', 'gitrebase', 'svn', 'hgcommit' },
    },
  },

  {
    -- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
    -- used for completion, annotations and signatures of Neovim apis
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        -- Load luvit types when the `vim.uv` word is found
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
      },
    },
  },
  -- Main LSP Configuration
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      { 'williamboman/mason.nvim', config = true },
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',

      -- Useful status updates for LSP.
      { 'j-hui/fidget.nvim', opts = {} },
    },
    config = function()
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc, mode)
            mode = mode or 'n'
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          map('<leader>cr', vim.lsp.buf.rename, 'Rename')
          map('<leader>ca', vim.lsp.buf.code_action, 'Code action')
          map('gd', vim.lsp.buf.definition, 'Goto definition')
          map('gr', require('telescope.builtin').lsp_references, 'Goto references')
          map('gI', require('telescope.builtin').lsp_implementations, 'Goto implementation')
          map('K', vim.lsp.buf.hover, 'Hover Documentation')
          map('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')
        end,
      })

      vim.diagnostic.config {
        severity_sort = true,
        float = { border = 'rounded', source = 'if_many' },
        underline = { severity = vim.diagnostic.severity.ERROR },
        signs = vim.g.have_nerd_font and {
          text = {
            [vim.diagnostic.severity.ERROR] = '󰅚 ',
            [vim.diagnostic.severity.WARN] = '󰀪 ',
            [vim.diagnostic.severity.INFO] = '󰋽 ',
            [vim.diagnostic.severity.HINT] = '󰌶 ',
          },
        } or {},
      }

      local capabilities = require('cmp_nvim_lsp').default_capabilities()

      -- Language servers to install
      local servers = {
        eslint = {},
        html = { filetypes = { 'html', 'twig', 'hbs' } },
        lua_ls = {
          Lua = {
            completion = {
              callSnippet = 'Replace',
            },
            -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
            -- diagnostics = { disable = { 'missing-fields' } },
          },
        },
      }

      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
        'stylua', -- Used to format Lua code
      })
      require('mason-tool-installer').setup { ensure_installed = ensure_installed }

      require('mason-lspconfig').setup {
        ensure_installed = {}, -- explicitly set to an empty table (Kickstart populates installs via mason-tool-installer)
        automatic_installation = false,
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            -- This handles overriding only values explicitly passed
            -- by the server configuration above. Useful when disabling
            -- certain features of an LSP (for example, turning off formatting for ts_ls)
            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
            require('lspconfig')[server_name].setup(server)
          end,
        },
      }
    end,
  },

  -- Autocompletion
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'rafamadriz/friendly-snippets',
    },
    config = function()
      local cmp = require 'cmp'
      local luasnip = require 'luasnip'
      require('luasnip.loaders.from_vscode').lazy_load()
      luasnip.config.setup {}

      -- Extend snippets for typescript/react
      require('luasnip').filetype_extend('typescriptreact', { 'javascript' })
      require('luasnip').filetype_extend('tidal', { 'haskell' })
      require('luasnip').filetype_extend('typescript', { 'javascript' })

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
          ['<C-u>'] = cmp.mapping.scroll_docs(4),
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
            select = false,
          },
          ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_locally_jumpable() then
              luasnip.expand_or_jump()
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
          { name = 'buffer' },
          { name = 'path' },
        },
      }
    end,
  },

  -- Git signs
  {
    'lewis6991/gitsigns.nvim',
    opts = {
      on_attach = function(bufnr)
        local gitsigns = require('gitsigns')
        vim.keymap.set('n', '<leader>gd', gitsigns.diffthis, { buffer = bufnr, desc = 'Git diff' })
        vim.keymap.set('n', '<leader>gb', gitsigns.blame, { buffer = bufnr, desc = 'Git blame' })
      end,
    },
  },

  -- Add animated glow/highlight effects to undo, redo, yank and paste
  {
    "y3owk1n/undo-glow.nvim",
    event = { "VeryLazy" },
    opts = {
      animation = {
        enabled = true,
        duration = 250,
        animtion_type = "zoom",
        window_scoped = true,
      },
      highlights = {
        undo = {
          hl_color = { bg = "#693232" }, -- Dark muted red
        },
        redo = {
          hl_color = { bg = "#2F4640" }, -- Dark muted green
        },
        yank = {
          hl_color = { bg = "#7A683A" }, -- Dark muted yellow
        },
        paste = {
          hl_color = { bg = "#325B5B" }, -- Dark muted cyan
        },
      },
      priority = 2048 * 3,
    },
    keys = {
      {
        "u",
        function()
          require("undo-glow").undo()
        end,
        mode = "n",
        desc = "Undo with highlight",
        noremap = true,
      },
      {
        "U",
        function()
          require("undo-glow").redo()
        end,
        mode = "n",
        desc = "Redo with highlight",
        noremap = true,
      },
      {
        "p",
        function()
          require("undo-glow").paste_below()
        end,
        mode = "n",
        desc = "Paste below with highlight",
        noremap = true,
      },
      {
        "P",
        function()
          require("undo-glow").paste_above()
        end,
        mode = "n",
        desc = "Paste above with highlight",
        noremap = true,
      },
    },
    init = function()
      vim.api.nvim_create_autocmd("TextYankPost", {
        desc = "Highlight when yanking (copying) text",
        callback = function()
          require("undo-glow").yank()
        end,
      })

    end,
  },

  -- Colorscheme
  {
    'sainnhe/gruvbox-material',
    priority = 1000,
    config = function()
      vim.cmd.colorscheme 'gruvbox-material'
    end,
  },

  -- Statusline
  {
    'nvim-lualine/lualine.nvim',
    opts = {
      options = {
        theme = 'auto',
        icons_enabled = false,
        component_separators = '',
        section_separators = '',
      },
      sections = {
        lualine_a = { 'mode' },
        lualine_b = { { 'diagnostics', sources = { 'nvim_lsp' } } },
        lualine_c = { { 'filename', path = 3 } },
        lualine_x = { 'branch' },
        lualine_y = { 'progress' },
        lualine_z = { 'location', 'filetype' },
      },
    },
  },

  -- Commenting
  {
    'numToStr/Comment.nvim',
    opts = {}
  },

  -- Autopairs
  { 'windwp/nvim-autopairs', event = 'InsertEnter', opts = {} },

  -- Surrounding text objects
  { 'kylechui/nvim-surround', version = '*', event = 'VeryLazy', opts = {} },

  -- Fuzzy Finder
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope-file-browser.nvim',
      'debugloop/telescope-undo.nvim',
      'axkirillov/easypick.nvim',
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
    },
    config = function()
      local telescope = require('telescope')
      local actions = require('telescope.actions')
      local builtin = require('telescope.builtin')

      telescope.setup {
        defaults = {
          mappings = {
            i = {
              ['<esc>'] = actions.close,
              ['<c-j>'] = actions.move_selection_next,
              ['<c-k>'] = actions.move_selection_previous,
              ['<c-l>'] = actions.select_vertical,
            },
          },
          sorting_strategy = 'ascending',
          layout_config = {
            prompt_position = 'top',
          },
        },
        pickers = {
          find_files = {
            find_command = { 'fd', '--type', 'f', '--strip-cwd-prefix', '--hidden', '--exclude', '**/.git/' },
          },
          buffers = {
            ignore_current_buffer = true,
            sort_mru = true,
            mappings = {
              i = {
                ['<c-d>'] = actions.delete_buffer + actions.move_to_top,
              },
            },
          },
        },
      }

      -- Enable telescope extensions
      pcall(telescope.load_extension, 'fzf')
      pcall(telescope.load_extension, 'undo')
      pcall(telescope.load_extension, 'file_browser')

      -- Easypick setup
      local easypick = require("easypick")
      local get_default_branch = "git rev-parse --symbolic-full-name refs/remotes/origin/HEAD | sed 's!.*/!!'"
      local base_branch = vim.fn.system(get_default_branch) or "main"

      easypick.setup({
        pickers = {
          {
            name = "changed_files",
            command = "git diff --name-only $(git merge-base HEAD " .. base_branch .. " )",
            previewer = easypick.previewers.branch_diff({base_branch = base_branch})
          },
        }
      })

      -- Set keymaps
      vim.keymap.set('n', '<leader>o', builtin.oldfiles, { desc = 'Find recently opened files' })
      vim.keymap.set('n', '<leader>b', builtin.buffers, { desc = 'Find existing buffers' })
      vim.keymap.set('n', '<leader>/', function()
        builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
          winblend = 10,
          previewer = false,
        })
      end, { desc = 'Fuzzy search in current buffer' })
      vim.keymap.set('n', '<leader>gf', builtin.git_files, { desc = 'Search git files' })
      vim.keymap.set('n', '<leader>e', builtin.find_files, { desc = 'Search files' })
      vim.keymap.set('n', '<leader>a', builtin.live_grep, { desc = 'Search by grep' })
      vim.keymap.set('n', '<leader>d', builtin.diagnostics, { desc = 'List diagnostics' })
      vim.keymap.set('n', '<leader>r', builtin.lsp_references, { desc = 'LSP References' })
      vim.keymap.set('n', '<leader>t', telescope.extensions.file_browser.file_browser, { desc = 'File browser' })
      vim.keymap.set('n', '<leader>u', telescope.extensions.undo.undo, { desc = 'Undo history' })
    end,
  },

  -- Treesitter
  {
    'nvim-treesitter/nvim-treesitter',
    dependencies = { 'nvim-treesitter/nvim-treesitter-textobjects' },
    build = ':TSUpdate',
    config = function()
      -- Defer setup to improve startup time
      vim.defer_fn(function()
        require('nvim-treesitter.configs').setup {
          ensure_installed = { 'bash', 'css', 'html', 'markdown', 'haskell', 'graphql', 'c', 'cpp', 'go', 'lua', 'python', 'rust', 'tsx', 'javascript', 'typescript', 'vimdoc', 'vim', 'astro' },
          sync_install = false,
          auto_install = false,
          highlight = { enable = true },
          indent = { enable = true },
          incremental_selection = {
            enable = true,
            keymaps = {
              init_selection = '<c-e>',
              node_incremental = '<c-e>',
            },
          },
          textobjects = {
            select = {
              enable = true,
              lookahead = true,
              keymaps = {
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
              set_jumps = true,
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
    end,
  },
}, {})

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
