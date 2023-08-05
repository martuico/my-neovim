-- This file can be (loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
-- vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'
  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.1',
    -- or                            , branch = '0.1.x',
    requires = { { 'nvim-lua/plenary.nvim' } }
  }

  use {
    'nvim-treesitter/nvim-treesitter',
    run = function()
      local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
      ts_update()
    end,
  }

  use("nvim-treesitter/playground")
  use("theprimeagen/harpoon")
  use("mbbill/undotree")
  use("tpope/vim-fugitive")
  use("nvim-tree/nvim-web-devicons")
  use {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v2.x',
    requires = {
      -- LSP Support
      { 'neovim/nvim-lspconfig' }, -- Required
      {
        -- Optional
        'williamboman/mason.nvim',
        build = function()
          pcall(vim.cmd, 'MasonUpdate')
        end,
      },
      { 'williamboman/mason-lspconfig.nvim' }, -- Optional

      -- Autocompletion
      { 'hrsh7th/nvim-cmp' },     -- Required
      { 'hrsh7th/cmp-nvim-lsp' }, -- Required
      { 'L3MON4D3/LuaSnip' },     -- Required

      -- Show a fidget at the bottom-right when LSP is working
      {
        'j-hui/fidget.nvim',
        tag = 'legacy'
      },
      { 'b0o/schemastore.nvim' },

      -- null-ls integration
      -- { 'jose-elias-alvarez/null-ls.nvim' },
      { 'jay-babu/mason-null-ls.nvim' },
    },
    config = function()
      require 'martuico.lsp'
    end,
  }

  use {
    "jose-elias-alvarez/null-ls.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local null_ls = require("null-ls")

      local root_has_file = function(files)
        return function(utils)
          return utils.root_has_file(files)
        end
      end

      local eslint_root_files = { ".eslintrc", ".eslintrc.js", ".eslintrc.json" }
      local prettier_root_files = { ".prettierrc", ".prettierrc.js", ".prettierrc.json" }
      local stylua_root_files = { "stylua.toml", ".stylua.toml" }
      local elm_root_files = { "elm.json" }

      local opts = {
        eslint_formatting = {
          condition = function(utils)
            local has_eslint = root_has_file(eslint_root_files)(utils)
            local has_prettier = root_has_file(prettier_root_files)(utils)
            return has_eslint and not has_prettier
          end,
        },
        eslint_diagnostics = {
          condition = root_has_file(eslint_root_files),
        },
        prettier_formatting = {
          condition = root_has_file(prettier_root_files),
        },
        stylua_formatting = {
          condition = root_has_file(stylua_root_files),
        },
        elm_format_formatting = {
          condition = root_has_file(elm_root_files),
        },
      }

      local function on_attach(client, _)
        if client.server_capabilities.document_formatting then
          vim.cmd("command! -buffer Formatting lua vim.lsp.buf.formatting()")
          vim.cmd("command! -buffer FormattingSync lua vim.lsp.buf.formatting_sync()")
        end
      end

      null_ls.setup({
        sources = {
          null_ls.builtins.diagnostics.eslint_d.with(opts.eslint_diagnostics),
          null_ls.builtins.formatting.eslint_d.with(opts.eslint_formatting),
          null_ls.builtins.formatting.prettier.with(opts.prettier_formatting),
          null_ls.builtins.formatting.stylua.with(opts.stylua_formatting),
          null_ls.builtins.formatting.elm_format.with(opts.elm_format_formatting),
          null_ls.builtins.code_actions.eslint_d.with(opts.eslint_diagnostics),
        },
        on_attach = on_attach,
        autostart = true,
      })
    end,
  }

  use { 'mhartington/formatter.nvim' }
  use { 'hrsh7th/nvim-compe' }
  use({
    "kdheepak/lazygit.nvim",
    -- optional for floating window border decoration
    requires = {
      "nvim-telescope/telescope.nvim",
      "nvim-lua/plenary.nvim",
    },

    config = function()
      require("telescope").load_extension("lazygit")
    end,
  })

  use { "bluz71/vim-moonfly-colors", as = "moonfly" }
  use { "mg979/vim-visual-multi" }
  use {
    "aca/emmet-ls"
  }

  use {
    'Exafunction/codeium.vim',
    config = function()
      -- Change '<C-g>' here to any keycode you like.
      vim.keymap.set('i', '<C-g>', function() return vim.fn['codeium#Accept']() end, { expr = true })
      vim.keymap.set('i', '<c-;>', function() return vim.fn['codeium#CycleCompletions'](1) end, { expr = true })
      vim.keymap.set('i', '<c-,>', function() return vim.fn['codeium#CycleCompletions'](-1) end, { expr = true })
      vim.keymap.set('i', '<c-x>', function() return vim.fn['codeium#Clear']() end, { expr = true })
    end
  }

  use {
    'akinsho/flutter-tools.nvim',
    requires = {
      'nvim-lua/plenary.nvim',
      'stevearc/dressing.nvim', -- optional for vim.ui.select
    },
  }

  use {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
  }

  use { "akinsho/toggleterm.nvim", tag = '*', config = function()
    require("toggleterm").setup()
  end }

  use { 'https://gitlab.com/schrieveslaach/sonarlint.nvim' }
  use({
    "kylechui/nvim-surround",
    tag = "*", -- Use for stability; omit to use `main` branch for the latest features
    config = function()
      require("nvim-surround").setup({
        -- Configuration here, or leave empty to use defaults
      })
    end
  })
end)
