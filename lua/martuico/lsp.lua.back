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
  'cssls',
  'jsonls',
  'bashls',
  'marksman',
  'pyright',
}

-- Configure lua language server for neovim
require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())

local nvim_lsp = require("lspconfig")

nvim_lsp.solargraph.setup {
  filetypes = { "ruby", "rakefile" },
  root_dir = nvim_lsp.util.root_pattern("Gemfile", ".git", "."),
  settings = {
    solargraph = {
      autoformat = true,
      completion = true,
      diagnostic = true,
      folding = true,
      references = true,
      rename = true,
      symbols = true
    }
  }
}

require 'lspconfig'.solargraph.setup {
  cmd = { "solargraph", "stdio" },
  filetypes = { "ruby" },
  root_dir = nvim_lsp.util.root_pattern("Gemfile", ".git"),
  settings = {
    solargraph = {
      diagnostics = true
    }
  }
}

require 'lspconfig'.pyright.setup {
  on_attach = function(client, bufnr)
    client.resolved_capabilities.document_formatting = true
  end,
  settings = {
    pyright = { autoImportCompletion = true, },
    python = {
      analysis = {
        autoSearchPaths = true,
        diagnosticMode = 'openFilesOnly',
        useLibraryCodeForTypes = true,
        typeCheckingMode = 'off'
      }
    }
  }
}

local function eslint_config_exists()
  local eslintrc = vim.fn.glob(".eslintrc*", 0, 1)

  if not vim.tbl_isempty(eslintrc) then
    return true
  end

  if vim.fn.filereadable("package.json") then
    if vim.fn.json_decode(vim.fn.readfile("package.json"))["eslintConfig"] then
      return true
    end
  end

  return false
end



local eslint = {
  lintCommand = "eslint_d -f unix --stdin --stdin-filename ${INPUT}",
  lintStdin = true,
  lintFormats = { "%f:%l:%c: %m" },
  lintIgnoreExitCode = true,
  formatCommand = "eslint_d --fix-to-stdout --stdin --stdin-filename=${INPUT}",
  formatStdin = true
}
nvim_lsp.tsserver.setup {
  filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact", "tsx" },
  on_attach = function(client)
    if client.config.flags then
      client.config.flags.allow_incremental_sync = true
    end
    client.resolved_capabilities.document_formatting = false
    -- set_lsp_configh(client)
  end
}
nvim_lsp.efm.setup {
  on_attach = function(client)
    client.resolved_capabilities.document_formatting = true
    client.resolved_capabilities.goto_definition = false
    -- set_lsp_config(client)
  end,
  root_dir = function()
    if not eslint_config_exists() then
      return nil
    end
    return vim.fn.getcwd()
  end,
  settings = {
    languages = {
      javascript = { eslint },
      javascriptreact = { eslint },
      ["javascript.jsx"] = { eslint },
      typescript = { eslint },
      ["typescript.tsx"] = { eslint },
      typescriptreact = { eslint }
    }
  },
  filetypes = {
    "javascript",
    "javascriptreact",
    "javascript.jsx",
    "typescript",
    "typescript.tsx",
    "typescriptreact"
  },
}


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
  filetypes = { "css", "eruby", "html", "javascript", "javascriptreact", "less", "sass", "scss", "svelte", "pug",
    "typescriptreact", "vue" },
  init_options = {
    html = {
      options = {
        -- For possible options, see: https://github.com/emmetio/emmet/blob/master/src/config.ts#L79-L267
        ["bem.enabled"] = true,
      },
    },
  }
})


require 'lspconfig'.pylsp.setup {
  settings = {
    pylsp = {
      plugins = {
        pycodestyle = {
          ignore = { 'W391' },
          maxLineLength = 100
        }
      }
    }
  }
}

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

-- sonarlint
local solarlint_ext_path = vim.fn.stdpath('data') .. '/sonarlint-vscode/extension'
local solarlint_server_path = solarlint_ext_path .. '/server/sonarlint-ls.jar'

local analyzer_html = solarlint_ext_path .. '/analyzers/sonarhtml.jar'
local analyzer_js = solarlint_ext_path .. '/analyzers/sonarjs.jar'
local analyzer_php = solarlint_ext_path .. '/analyzers/sonarphp.jar'
local analyzer_text = solarlint_ext_path .. '/analyzers/sonartext.jar'
local analyzer_python = solarlint_ext_path .. '/analyzers/sonarpython.jar'
local analyzer_go = solarlint_ext_path .. '/analyzers/sonargo.jar'
local analyzer_php = solarlint_ext_path .. '/analyzers/sonarphp.jar'

require('sonarlint').setup({
  server = {
    cmd = {
      'java', '-jar', solarlint_server_path,
      '-stdio',
      '-analyzers', analyzer_js, analyzer_html, analyzer_php, analyzer_text, analyzer_python, analyzer_go, analyzer_php
    },
  },
  filetypes = {
    'css',
    'javascript',
    'typescript',
    'html',
    'python',
    'php',
    'go',
  },
  settings = {
    sonarlint = {
      pathToNodeExecutable = '/Users/gaudencioenriquezjr/.nvm/versions/node/v18.15.0/bin/node'
    }
  }
})
