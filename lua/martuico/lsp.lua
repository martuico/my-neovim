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

-- Add keymappings to the current buffer
lsp.on_attach(function(client, bufnr)
  lsp.default_keymaps { buffer = bufnr, preserve_mappings = true }

  -- Additional keymappings for 60% keybards.
  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { desc = '[R]e[n]ame', buffer = bufnr })
  vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { desc = '[C]ode [A]ction', buffer = bufnr })
  vim.keymap.set('n', '<leader>bf', vim.lsp.buf.format, { desc = '[B]uffer [F]ormat', buffer = bufnr })
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

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

require('lspconfig').emmet_ls.setup({
    -- on_attach = on_attach,
    capabilities = capabilities,
    filetypes = { "css", "eruby", "html", "javascript", "javascriptreact", "less", "sass", "scss", "svelte", "pug", "typescriptreact", "vue" },
    init_options = {
      html = {
        options = {
          -- For possible options, see: https://github.com/emmetio/emmet/blob/master/src/config.ts#L79-L267
          ["bem.enabled"] = true,
        },
      },
    }
})


lsp.setup()


-- Install linting and formating apps using Mason.
local mason_nullls = require 'mason-null-ls'
mason_nullls.setup {
  ensure_installed = { 'stylua', 'jq', 'prettierd', 'markdownlint' },
  automatic_installation = true,
  automatic_setup = true,
}



-- cmp
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
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
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
