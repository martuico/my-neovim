-- Show something more than a mere bullet on the list of installed servers
require("mason").setup({
	ui = {
		border = "rounded",
		icons = {
			package_installed = "✓",
			package_pending = "➜",
			package_uninstalled = "✗",
		},
	},
})

-- Display LSP status on the bottom right corner
require("fidget").setup()

local lspconfig_status, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status then
	return
end

local cmp_nvim_lsp_status, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not cmp_nvim_lsp_status then
	return
end

local keymap = vim.keymap
local lspzero = require("lsp-zero").preset("recommended")
lspzero.setup()

-- inlay cmd
-- vim.api.nvim_create_augroup("LspAttach_inlayhints", {})

local on_attach = function(client, bufnr)
	local opts = { noremap = true, silent = true, buffer = bufnr }

	lspzero.default_keymaps({ buffer = bufnr, preserve_mappings = true })
	-- attach inlay hint
	-- vim.api.nvim_create_augroup("LspAttach_inlayhints", {})
	-- vim.api.nvim_create_autocmd("LspAttach", {
	-- 	group = "LspAttach_inlayhints",
	-- 	callback = function(args)
	-- 		if not (args.data and args.data.client_id) then
	-- 			return
	-- 		end

	-- 		local bufnr = args.buf
	-- 		local client = vim.lsp.get_client_by_id(args.data.client_id)
	-- 		require("lsp-inlayhints").on_attach(client, bufnr)
	-- 	end,
	-- })

	-- Additional keymappings for 60% keybards.
	vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "[R]e[n]ame", buffer = bufnr })
	vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "[C]ode [A]ction", buffer = bufnr })
	vim.keymap.set("n", "<leader>bf", vim.lsp.buf.format, { desc = "[B]uffer [F]ormat", buffer = bufnr })

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

require("lspconfig").intelephense.setup({
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

require("lspconfig").phpactor.setup({
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

require("lspconfig").efm.setup({
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

-- require("lspconfig").eslint.setup({
-- 	on_attach = on_attach,
-- })

require("lspconfig").solargraph.setup({
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

require("lspconfig").pyright.setup({
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

require("lspconfig").volar.setup({
	filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue", "json" },
	capabilities = capabilities,
	on_attach = on_attach,
	init_options = {
		languageFeatures = {
			references = true,
			definition = true,
			typeDefinition = true,
			callHierarchy = true,
			hover = false,
			rename = true,
			signatureHelp = true,
			codeAction = true,
			completion = {
				defaultTagNameCase = "both",
				defaultAttrNameCase = "kebabCase",
			},
			schemaRequestService = true,
			documentHighlight = true,
			codeLens = true,
			semanticTokens = true,
			diagnostics = true,
		},
		documentFeatures = {
			selectionRange = true,
			foldingRange = true,
			linkedEditingRange = true,
			documentSymbol = true,
			documentColor = true,
		},
	},
	settings = {
		volar = {
			codeLens = {
				references = true,
				pugTools = true,
				scriptSetupTools = true,
			},
		},
	},
	root_dir = lspconfig.util.root_pattern("package.json", "vue.config.js", "nuxt.config.js", "tsconfig.json"),
})

-- cmp
local cmp = require("cmp")
local cmp_action = require("lsp-zero").cmp_action()

-- require("luasnip.loaders.from_vscode").lazy_load()

cmp.setup({
	sources = {
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
	},
	mapping = {
		["<C-f>"] = cmp_action.luasnip_jump_forward(),
		["<C-b>"] = cmp_action.luasnip_jump_backward(),
		["<CR>"] = cmp.mapping.confirm({ select = true }),
	},
	automatic_installation = true,
})
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lspzero.defaults.cmp_mappings({
	["<Tab>"] = cmp.mapping(function(fallback)
		if cmp.visible() then
			cmp.confirm({ select = true })
		else
			fallback()
		end
	end, { "i", "c" }),
	["<C-e>"] = cmp.mapping({
		i = cmp.mapping.abort(),
		c = cmp.mapping.close(),
	}),
	["<Down>"] = cmp.mapping(cmp.mapping.select_next_item(cmp_select), { "i", "c" }),
	["<Up>"] = cmp.mapping(cmp.mapping.select_prev_item(cmp_select), { "i", "c" }),
	-- ["<C-p>"] = cmp_loader.mapping.select_prev_item(cmp_select),
	-- ["<C-n>"] = cmp_loader.mapping.select_next_item(cmp_select),
	-- ["<C-y>"] = cmp_loader.mapping.confirm({ select = true }),
	-- ["<C-Space>"] = cmp_loader.mapping.complete(),
})

cmp_mappings["<Tab>"] = nil
cmp_mappings["<S-Tab>"] = nil

lspzero.setup_nvim_cmp({
	mapping = cmp_mappings,
})

-- sonarlint
local solarlint_ext_path = vim.fn.stdpath("data") .. "/sonarlint-vscode/extension"
local solarlint_server_path = solarlint_ext_path .. "/server/sonarlint-ls.jar"

local analyzer_html = solarlint_ext_path .. "/analyzers/sonarhtml.jar"
local analyzer_js = solarlint_ext_path .. "/analyzers/sonarjs.jar"
local analyzer_text = solarlint_ext_path .. "/analyzers/sonartext.jar"
local analyzer_python = solarlint_ext_path .. "/analyzers/sonarpython.jar"
local analyzer_go = solarlint_ext_path .. "/analyzers/sonargo.jar"
local analyzer_php = solarlint_ext_path .. "/analyzers/sonarphp.jar"

require("sonarlint").setup({
	server = {
		cmd = {
			"java",
			"-jar",
			solarlint_server_path,
			"-stdio",
			"-analyzers",
			analyzer_js,
			analyzer_html,
			analyzer_php,
			analyzer_text,
			analyzer_python,
			analyzer_go,
			analyzer_php,
		},
	},
	filetypes = {
		"css",
		"javascript",
		"typescript",
		"html",
		"python",
		"php",
		"go",
	},
	settings = {
		sonarlint = {
			pathToNodeExecutable = "/Users/marcarlotuico/.nvm/versions/node/v18.16.0/bin/node",
		},
	},
})
