local status, null_ls = pcall(require, "null-ls")
if (not status) then return end

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

null_ls.setup {
  sources = {
    null_ls.builtins.formatting.prettierd.with({
      filetypes = {
        "css", "json", "jsonc", "javascript", "typescript",
        "javascript.glimmer", "typescript.glimmer",
        "handlebars"
      }
    }),
    -- Code actions for staging hunks, blame, etc
    null_ls.builtins.code_actions.gitsigns,
    null_ls.builtins.completion.luasnip,
    null_ls.builtins.diagnostics.fish,

    -- PhpCs and PhpCbf
    null_ls.builtins.diagnostics.phpcs.with {    -- Use the local installation first
      diagnostics_format = '#{m} (#{c}) [#{s}]', -- Makes PHPCS errors more readeable
      only_local = 'vendor/bin',
    },
    null_ls.builtins.formatting.phpcbf.with {
      prefer_local = 'vendor/bin',
    },
    -- Markdown.
    null_ls.builtins.formatting.markdownlint,
    null_ls.builtins.diagnostics.markdownlint.with {
      extra_args = { '--disable', 'line-length' },
    },
    -- Spell check that has better tooling
    -- all stored locally
    -- https://github.com/streetsidesoftware/cspell
    null_ls.builtins.diagnostics.cspell.with({
      -- This file is symlinked from my dotfiles repo
      extra_args = { "--config", "~/.cspell.json" }
    }),
    null_ls.builtins.code_actions.cspell.with({
      -- This file is symlinked from my dotfiles repo
      extra_args = { "--config", "~/.cspell.json" }
    }),
    null_ls.builtins.diagnostics.flake8.with({ extra_args = { "--max-line-length 88" } })
  },
  on_attach = function(client, bufnr)
    -- the Buffer will be null in buffers like nvim-tree or new unsaved files
    if (not bufnr) then
      return
    end

    if client.supports_method("textDocument/formatting") then
      vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function()
          -- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
          -- on later neovim version, you should use vim.lsp.buf.format({ async = false }) instead
          --vim.lsp.buf.formatting_sync({ bufnr = bufnr })
          vim.lsp.buf.format({ async = false })
        end,
      })
    end
  end
}

vim.api.nvim_create_user_command(
  'DisableLspFormatting',
  function()
    vim.api.nvim_clear_autocmds({ group = augroup, buffer = 0 })
  end,
  { nargs = 0 }
)
