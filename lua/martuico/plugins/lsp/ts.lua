on_attach = require("martuico.plugins.lsp.attached")

return {
	filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact" },
	on_attach = function(client)
		client.server_capabilities.document_formatting = true
		on_attach(client)
	end,
}
