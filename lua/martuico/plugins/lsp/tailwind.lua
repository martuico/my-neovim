local nvim_lsp = require("lspconfig")
local on_attach = require("martuico.plugins.lsp.attached")

return {
	on_attach = on_attach,
	filetypes = vim.tbl_deep_extend(
		"force",
		nvim_lsp.tailwindcss.document_config.default_config.filetypes,
		{ "html.twig" }
	),
	init_options = {
		userLanguages = {
			["html.twig"] = "twig",
		},
	},
	settings = {
		tailwindCss = {
			includeLanguages = {
				["html.twig"] = "twig",
			},
		},
	},
}
