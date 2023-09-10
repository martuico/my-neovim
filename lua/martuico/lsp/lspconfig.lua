local lspconfig_status, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status then
	return
end

local cmp_nvim_lsp_status, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not cmp_nvim_lsp_status then
	return
end

local keymap = vim.keymap

-- inlay cmd
vim.api.nvim_create_augroup("LspAttach_inlayhints", {})

local on_attach = function(client, bufnr)
	local opts = { noremap = true, silent = true, buffer = bufnr }

	-- attach inlay hint
	vim.api.nvim_create_autocmd("LspAttach", {
		group = "LspAttach_inlayhints",
		callback = function(args)
			if not (args.data and args.data.client_id) then
				return
			end
			require("lsp-inlayhints").on_attach(client, args.buf)
		end,
	})
	-- set keybinds for lsp saga
	keymap.set("n", "gf", "<cmd>Lspsaga lsp_finder<CR>", opts) -- show definition, references
	keymap.set("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts) -- got to declaration
	keymap.set("n", "gd", "<cmd>Lspsaga peek_definition<CR>", opts) -- see definition and make edits in window
	keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts) -- go to implementation
	keymap.set("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", opts) -- see available code actions
	keymap.set("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", opts) -- smart rename
	keymap.set("n", "<leader>d", "<cmd>Lspsaga show_line_diagnostics<CR>", opts) -- show  diagnostics for line
	keymap.set("n", "<leader>d", "<cmd>Lspsaga show_cursor_diagnostics<CR>", opts) -- show diagnostics for cursor
	keymap.set("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts) -- jump to previous diagnostic in buffer
	keymap.set("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts) -- jump to next diagnostic in buffer
	keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts) -- show documentation for what is under cursor
	keymap.set("n", "<leader>o", "<cmd>LSoutlineToggle<CR>", opts) -- see outline on right hand side

	-- typescript specific keymaps (e.g. rename file and update imports)
	if client.name == "tsserver" then
		keymap.set("n", "<leader>rf", ":TypescriptRenameFile<CR>") -- rename file and update imports
		keymap.set("n", "<leader>oi", ":TypescriptOrganizeImports<CR>") -- organize imports (not in youtube nvim video)
		keymap.set("n", "<leader>ru", ":TypescriptRemoveUnused<CR>") -- remove unused variables (not in youtube nvim video)
	end
	if client.name == "eslint" then
		vim.api.nvim_create_autocmd("BufWritePre", {
			buffer = bufnr,
			command = "EslintFixAll",
		})
	end
end

-- used to enable autocompletion (assign to every lsp server config)
local capabilities = cmp_nvim_lsp.default_capabilities()

-- sign for gutters
local signs = { Error = " ", Warn = " ", Hint = "ﴞ ", Info = " " }
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

-- configure html server
lspconfig["html"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

-- tsserver
require("typescript").setup({
	disable_commands = false,
	debug = false,
	go_to_source_definition = {
		fallback = true,
	},
	server = {
		on_attach = on_attach,
		capabilities = capabilities,
		filetypes = {
			"javascript",
			"javascriptreact",
			"javascript.jsx",
			"typescript",
			"typescriptreact",
			"typescript.tsx",
		},
		root_dir = function()
			return vim.loop.cwd()
		end,
		settings = {
			javascript = {
				inlayHints = {
					includeInlayEnumMemberValueHints = true,
					includeInlayFunctionLikeReturnTypeHints = true,
					includeInlayFunctionParameterTypeHints = true,
					includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all';
					includeInlayParameterNameHintsWhenArgumentMatchesName = true,
					includeInlayPropertyDeclarationTypeHints = true,
					includeInlayVariableTypeHints = true,
				},
			},
			typescript = {
				inlayHints = {
					includeInlayEnumMemberValueHints = true,
					includeInlayFunctionLikeReturnTypeHints = true,
					includeInlayFunctionParameterTypeHints = true,
					includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all';
					includeInlayParameterNameHintsWhenArgumentMatchesName = true,
					includeInlayPropertyDeclarationTypeHints = true,
					includeInlayVariableTypeHints = true,
				},
			},
		},
	},
})

-- configure css server
lspconfig["cssls"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

-- configure tailwindcss server
lspconfig["tailwindcss"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

-- configure emmet language server
lspconfig["emmet_ls"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
	filetypes = {
		"html",
		"typescriptreact",
		"javascriptreact",
		"css",
		"sass",
		"scss",
	},
})

-- configure lua server (with special settings)
lspconfig["lua_ls"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
	settings = { -- custom settings for lua
		Lua = {
			-- make the language server recognize "vim" global
			diagnostics = {
				globals = { "vim", "use" },
			},
			workspace = {
				-- make language server aware of runtime files
				library = {
					[vim.fn.expand("$VIMRUNTIME/lua")] = true,
					[vim.fn.stdpath("config") .. "/lua"] = true,
				},
			},
			hint = {
				arrayIndex = "Enable",
				await = true,
				enable = true,
				paramName = "All",
				paramType = "",
				semicolon = "SameLine",
				setType = true,
			},
		},
	},
})

lspconfig.intelephense.setup({
	capabilities = capabilities,
	on_attach = on_attach,
	settings = {
		intelephense = {
			files = {
				maxSize = 5000000,
			},
		},
	},
})

local phpactor_capabilities = vim.lsp.protocol.make_client_capabilities()
phpactor_capabilities.textDocument.foldingRange = {
	dynamicRegistration = false,
	lineFoldingOnly = true,
}

lspconfig.phpactor.setup({
	on_attach = on_attach,
	capabilities = phpactor_capabilities,
	filetypes = {
		"php",
	},
})

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
	formatStdin = true,
}

lspconfig.tsserver.setup({
	filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact", "tsx" },
	on_attach = function(client)
		if client.config.flags then
			client.config.flags.allow_incremental_sync = true
		end
		client.resolved_capabilities.document_formatting = false
		-- set_lsp_configh(client)
	end,
})
lspconfig.efm.setup({
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
			typescriptreact = { eslint },
		},
	},
	filetypes = {
		"javascript",
		"javascriptreact",
		"javascript.jsx",
		"typescript",
		"typescript.tsx",
		"typescriptreact",
	},
})

lspconfig.eslint.setup({
	on_attach = on_attach,
})

lspconfig.solargraph.setup({
	filetypes = { "ruby", "rakefile" },
	root_dir = lspconfig.util.root_pattern("Gemfile", ".git", "."),
	settings = {
		solargraph = {
			autoformat = true,
			completion = true,
			diagnostic = true,
			folding = true,
			references = true,
			rename = true,
			symbols = true,
		},
	},
})

lspconfig.solargraph.setup({
	cmd = { "solargraph", "stdio" },
	filetypes = { "ruby" },
	root_dir = lspconfig.util.root_pattern("Gemfile", ".git"),
	settings = {
		solargraph = {
			diagnostics = true,
		},
	},
})

lspconfig.pyright.setup({
	on_attach = function(client, bufnr)
		client.resolved_capabilities.document_formatting = true
	end,
	settings = {
		pyright = { autoImportCompletion = true },
		python = {
			analysis = {
				autoSearchPaths = true,
				diagnosticMode = "openFilesOnly",
				useLibraryCodeForTypes = true,
				typeCheckingMode = "off",
			},
		},
	},
})
