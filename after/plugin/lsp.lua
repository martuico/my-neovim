-- Show something more than a mere bullet on the list of installed servers
require('mason').setup {
  ui = {
    border = 'rounded',
    icons = {
      package_installed = '✓',
      package_pending = '➜',
      package_uninstalled = '✗',
    },
  },
}

-- Display LSP status on the bottom right corner
require('fidget').setup()

-- Config LSP Zero
local lsp = require('lsp-zero').preset 'recommended'

lsp.nvim_workspace()


local cmp = require('cmp')
local cmp_action = require('lsp-zero').cmp_action()

require('luasnip.loaders.from_vscode').lazy_load()
cmp.setup({
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  },
  mapping = {
    ['<C-f>'] = cmp_action.luasnip_jump_forward(),
    ['<C-b>'] = cmp_action.luasnip_jump_backward(),
    ['<CR>'] = cmp.mapping.confirm({ select = true })
  },
  automatic_installation = true
})
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings({
  ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
  ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
  ['<C-y>'] = cmp.mapping.confirm({ select = true }),
  ["<C-Space>"] = cmp.mapping.complete(),
})

cmp_mappings['<Tab>'] = nil
cmp_mappings['<S-Tab>'] = nil

lsp.setup_nvim_cmp({
  mapping = cmp_mappings
})
-- Add keymappings to the current buffer
lsp.set_preferences({
  suggest_lsp_servers = false,
  sign_icons = {
    error = 'E',
    warn = 'W',
    hint = 'H',
    info = 'I'
  }
})

lsp.on_attach(function(client, bufnr)
  local opts = { buffer = bufnr, remap = false }

  vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
  vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
  vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
  vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
  vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
  vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
  vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
  vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
  vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
  vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
end)

lsp.ensure_installed {
  'lua_ls',
  'intelephense',
  'tsserver',
  'cssls',
  'jsonls',
  'bashls',
  'marksman',
}

-- Configure lua language server for neovim
require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())

-- Enable autompletion of keys in conf files like `package.json` or `.eslintrc.json`
require('lspconfig').jsonls.setup {
  settings = {
    json = {
      schemas = require('schemastore').json.schemas(),
    },
  },
}

lsp.setup()

-- Null-Ls for formatting
local null_ls = require 'null-ls'
null_ls.setup {
  sources = {
    -- Eslint
    null_ls.builtins.code_actions.eslint_d,
    null_ls.builtins.formatting.eslint_d.with {
      condition = function(utils)
        return utils.root_has_file { '.eslintrc.js', '.eslintrc.json' }
      end,
    },
    null_ls.builtins.diagnostics.eslint_d.with {
      condition = function(utils)
        return utils.root_has_file { '.eslintrc.js', '.eslintrc.json' }
      end,
    },

    -- Markdown.
    null_ls.builtins.formatting.markdownlint,
    null_ls.builtins.diagnostics.markdownlint.with {
      extra_args = { '--disable', 'line-length' },
    },

    -- PhpCs and PhpCbf
    null_ls.builtins.diagnostics.phpcs.with {    -- Use the local installation first
      diagnostics_format = '#{m} (#{c}) [#{s}]', -- Makes PHPCS errors more readeable
      only_local = 'vendor/bin',
    },
    null_ls.builtins.formatting.phpcbf.with {
      prefer_local = 'vendor/bin',
    },

    -- Prettier and spelling
    null_ls.builtins.formatting.prettierd,
    null_ls.builtins.completion.spell, -- You still need to execute `:set spell`
  },
}

-- Install linting and formating apps using Mason.
local mason_nullls = require 'mason-null-ls'
mason_nullls.setup {
  ensure_installed = { 'stylua', 'jq', 'prettierd', 'markdownlint' },
  automatic_installation = true,
  automatic_setup = true,
}

