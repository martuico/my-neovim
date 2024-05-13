local ok, null_ls = pcall(require, "null-ls")
if not ok then
	return
end

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
local code_actions = null_ls.builtins.code_actions

-- format on save
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

-- configure null_ls
null_ls.setup({
	{
		command = "prettierd",
		filetype = { "typescript", "typescriptreact", "jsonc", "json", "javascript", "javascriptreact" },
	},
	-- setup formatters & linters
	sources = {
		--  to disable file types use
		--  "formatting.prettier.with({disabled_filetypes: {}})" (see null-ls docs)
		formatting.prettierd.with({
			filetypes = {
				"css",
				"json",
				"jsonc",
				"javascript",
				"javascriptreact",
				"typescript",
				"typescriptreact",
				"typescript.tsx",
				"javascript.glimmer",
				"typescript.glimmer",
				"handlebars",
				"vue",
				"tsx",
				"jsx",
			},
		}), -- js/ts formatter
		formatting.stylua, -- lua formatter
		diagnostics.eslint_d.with({ -- js/ts linter
			-- only enable eslint if root has .eslintrc.js
			condition = function(utils)
				return utils.root_has_file(
					".eslintrc.js",
					".eslintrc.cjs",
					".eslintrc.yaml",
					".eslintrc.yml",
					".eslintrc.json"
				) -- change file extension if you use something else
			end,
		}),
		null_ls.builtins.formatting.black,

		diagnostics.phpcs.with({ -- Use the local installation first
			diagnostics_format = "#{m} (#{c}) [#{s}]", -- Makes PHPCS errors more readeable
			only_local = "vendor/bin",
		}),
		formatting.phpcbf.with({
			prefer_local = "vendor/bin",
		}),
		-- Markdown.
		formatting.markdownlint,
		diagnostics.markdownlint.with({
			extra_args = { "--disable", "line-length" },
		}),
		-- Spell check that has better tooling
		-- all stored locally
		-- https://github.com/streetsidesoftware/cspell
		diagnostics.cspell.with({
			-- This file is symlinked from my dotfiles repo
			extra_args = { "--config", "~/.cspell.json" },
		}),
		code_actions.cspell.with({
			-- This file is symlinked from my dotfiles repo
			extra_args = { "--config", "~/.cspell.json" },
		}),
		diagnostics.flake8.with({ extra_args = { "--max-line-length 88" } }),
	},
	-- configure format on save
	on_attach = function(current_client, bufnr)
		if current_client.supports_method("textDocument/formatting") then
			vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = augroup,
				buffer = bufnr,
				callback = function()
					vim.lsp.buf.format({
						filter = function(client)
							--  only use null-ls for formatting instead of lsp server
							return client.name == "null-ls"
						end,
						bufnr = bufnr,
					})
				end,
			})
		end
	end,
})
