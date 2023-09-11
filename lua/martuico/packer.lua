-- This file can be (loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
-- vim.cmd [[packadd packer.nvim]]

return require("packer").startup(function(use)
	-- Packer can manage itself
	use("wbthomason/packer.nvim")
	use({
		"nvim-telescope/telescope.nvim",
		tag = "0.1.1",
		-- or                            , branch = '0.1.x',
		requires = { { "nvim-lua/plenary.nvim" } },
	})

	-- [[ Better Syntax Analysis ]]
	use({
		"nvim-treesitter/nvim-treesitter",
		run = function()
			local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
			ts_update()
		end,
		config = function()
			require("martuico.lsp.treesitter")
		end,
	})

	use({ "windwp/nvim-ts-autotag", after = "nvim-treesitter" })
	use({ "HiPhish/nvim-ts-rainbow2", after = "nvim-treesitter" })
	use("nvim-treesitter/playground")

	use("theprimeagen/harpoon")
	use("mbbill/undotree")
	use("tpope/vim-fugitive")
	use("nvim-tree/nvim-web-devicons")

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

	use({ "bluz71/vim-moonfly-colors", as = "moonfly" })
	use({ "mg979/vim-visual-multi" })

	use({
		"Exafunction/codeium.vim",
		config = function()
			-- Change '<C-g>' here to any keycode you like.
			vim.keymap.set("i", "<C-g>", function()
				return vim.fn["codeium#Accept"]()
			end, { expr = true })
			vim.keymap.set("i", "<c-;>", function()
				return vim.fn["codeium#CycleCompletions"](1)
			end, { expr = true })
			vim.keymap.set("i", "<c-,>", function()
				return vim.fn["codeium#CycleCompletions"](-1)
			end, { expr = true })
			vim.keymap.set("i", "<c-x>", function()
				return vim.fn["codeium#Clear"]()
			end, { expr = true })
		end,
	})

	use({
		"akinsho/flutter-tools.nvim",
		requires = {
			"nvim-lua/plenary.nvim",
			"stevearc/dressing.nvim", -- optional for vim.ui.select
		},
	})

	use({
		"akinsho/toggleterm.nvim",
		tag = "*",
		config = function()
			require("toggleterm").setup()
		end,
	})

	use({ "https://gitlab.com/schrieveslaach/sonarlint.nvim" })
	use({
		"kylechui/nvim-surround",
		tag = "*", -- Use for stability; omit to use `main` branch for the latest features
		config = function()
			require("nvim-surround").setup({
				-- Configuration here, or leave empty to use defaults
			})
		end,
	})

	use({
		"folke/trouble.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
		},
	})

	-- [[ Language Server Protocol and Snippet Engine ]]

	-- native lsp
	use({
		"neovim/nvim-lspconfig",
		config = function()
			require("martuico.lsp.lspconfig")
		end,
	})

	-- lsp installer
	use({ "williamboman/mason.nvim" })
	use({
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("martuico.lsp.mason")
		end,
	})

	-- [[ Additional lsp plugins ]]
	use({
		"lvimuser/lsp-inlayhints.nvim",
		event = "LspAttach",
		config = function()
			require("martuico.lsp.lsp_inlayhints")
		end,
	})

	use({ "jose-elias-alvarez/typescript.nvim" })

	use({
		"hrsh7th/nvim-cmp",
		-- event = "InsertEnter", -- this make disable icon color
		wants = { "LuaSnip" },
		requires = { --- Autocompletion
			{ "hrsh7th/cmp-buffer", after = "nvim-cmp" },
			{ "hrsh7th/cmp-nvim-lua", after = "nvim-cmp" },
			{ "hrsh7th/cmp-nvim-lsp", after = "nvim-cmp" },
			{ "saadparwaiz1/cmp_luasnip", after = "nvim-cmp" },
			{ "hrsh7th/cmp-path", after = "nvim-cmp" },
			{ "hrsh7th/cmp-cmdline", after = "nvim-cmp" },
			{ "L3MON4D3/LuaSnip", event = "InsertEnter" },
			{
				"jcha0713/cmp-tw2css",
				event = "InsertEnter",
				ft = { "html", "css" },
			},
		},
		config = function()
			require("martuico.lsp.cmp")
		end,
	})
	use({ "hrsh7th/cmp-nvim-lsp" }) -- builtin lsp complete
	-- better sorting
	use({
		"lukas-reineke/cmp-under-comparator",
	})

	-- vscode like auto complete
	use({
		"rafamadriz/friendly-snippets",
		module = { "cmp", "cmp_nvim_lsp" },
		event = "InsertCharPre",
	})
	use({ "onsails/lspkind.nvim" }) -- icon inside autocomplete window
	-- use {
	--     "nvimdev/lspsaga.nvim",
	--     branch = "main",
	--     event = "BufRead",
	--     config = function()
	--         require "martuico.lsp.saga"
	--     end,
	-- } -- better goto navigation

	-- [[ Linter and Formatter ]]
	use({
		"jayp0521/mason-null-ls.nvim",
		config = function()
			require("martuico.formatters.mason_null_ls")
		end,
	}) -- linter and formatter installer

	use({
		"jose-elias-alvarez/null-ls.nvim",
		config = function()
			require("martuico.formatters.null_ls")
		end,
	}) -- formatter

	use({
		"j-hui/fidget.nvim",
		tag = "legacy",
	})

	use({
		"VonHeikemen/lsp-zero.nvim",
		branch = "v2.x",
		dependencies = {
			-- LSP Support
			{ "neovim/nvim-lspconfig" },
			{ "williamboman/mason.nvim" },
			{ "williamboman/mason-lspconfig.nvim" },

			-- Autocompletion
			{ "hrsh7th/nvim-cmp" },
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "L3MON4D3/LuaSnip" },
		},
	})

	use("simrat39/symbols-outline.nvim")
end)
