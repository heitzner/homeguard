-- vim settings
vim.g.mapleader = " "
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.termguicolors = true

-- bootstrap lazynvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath
  })
end
vim.opt.rtp:prepend(lazypath)

-- plugins
require("lazy").setup({

-- file explorer
  {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("nvim-tree").setup({
        view = {
          width = 30,
          side = "left",
        },
        renderer = {
          group_empty = true,
        },
        filters = {
          dotfiles = false,
        },
      })
      
-- keybind for file explorer
      vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<CR>', { desc = 'Toggle File Explorer', silent = true })
    end,
  },

-- bufferline
  {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
      require("bufferline").setup({
        options = {
          mode = "buffers",
          diagnostics = "nvim_lsp",
          show_buffer_close_icons = false,
          show_close_icon = false,
          offsets = {
            {
              filetype = "NvimTree",
              text = "File Explorer",
              highlight = "Directory",
              separator = true 
            }
          }
        }
      })
      
      vim.keymap.set('n', '<Tab>', ':BufferLineCycleNext<CR>', { desc = 'Next Tab', silent = true })
      vim.keymap.set('n', '<S-Tab>', ':BufferLineCyclePrev<CR>', { desc = 'Previous Tab', silent = true })
      vim.keymap.set('n', '<leader>x', ':bdelete<CR>', { desc = 'Close current buffer', silent = true })
    end
  },

-- statusline
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('lualine').setup({
        options = {
          theme = 'auto', 
          component_separators = { left = '', right = ''},
          section_separators = { left = '', right = ''},
          globalstatus = true,
        },
        sections = {
          lualine_a = {'mode'},
          lualine_b = {'branch', 'diff', 'diagnostics'},
          lualine_c = {
            {
              'filename',
              path = 1, 
            }
          },
          lualine_x = {'encoding', 'fileformat', 'filetype'},
          lualine_y = {'progress'},
          lualine_z = {'location'}
        },
      })
    end
  },

-- better commandline ui
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
    config = function()
      require("notify").setup({
        background_colour = "#000000",
        stages = "fade",
        timeout = 2000,
      })

      require("noice").setup({
        presets = {
          command_palette = true,
          bottom_search = false, 
          inc_rename = false,    
          lsp_doc_border = true, 
        },
        routes = {
          {
            view = "notify",
            filter = { event = "msg_showmode" },
          },
        },
      })
    end
  },

-- syntax highlighting
  { 
    "nvim-treesitter/nvim-treesitter", 
    branch = "master",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = { "c", "cpp", "lua", "vim", "vimdoc" },
        auto_install = true,
        highlight = { enable = true },
      })
    end
  },

-- autocompletion
  { 
    "hrsh7th/nvim-cmp",
    dependencies = { "hrsh7th/cmp-nvim-lsp", "L3MON4D3/LuaSnip" },
    config = function()
      local cmp = require("cmp")
      cmp.setup({
        snippet = { expand = function(args) require("luasnip").lsp_expand(args.body) end },
        mapping = cmp.mapping.preset.insert({
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
        }),
        sources = { { name = "nvim_lsp" } }
      })
    end
  },
  
-- file search
  { 
    'nvim-telescope/telescope.nvim', 
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      local builtin = require('telescope.builtin')
      vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Find files' })
      vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Live grep' })
    end
  }, -- <-- Added a comma here so we can add more plugins

  -- LSP Management (Mason)
  {
    "williamboman/mason.nvim",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "neovim/nvim-lspconfig",
    },
    config = function()
      require("mason").setup()
      
      require("mason-lspconfig").setup({
        -- Pre-load LSPs for C, React, and Tailwind
        ensure_installed = { "clangd", "ts_ls", "tailwindcss", "html", "cssls" },
      })

      -- Set global capabilities for autocomplete using Neovim's native 0.11+ API
      -- This applies automatically to all LSPs installed by Mason
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      vim.lsp.config("*", {
        capabilities = capabilities,
      })
    end
  },

  -- Colorscheme
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000, 
    config = function()
      vim.cmd([[colorscheme tokyonight-night]])
    end,
  }

}, {
-- disable luarocks
  rocks = { enabled = false } 
})


-- Universal LSP Keybinds (Native Neovim, so it stays outside the Lazy setup)
vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
        local opts = { buffer = args.buf }
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
        vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts) 
    end
})
