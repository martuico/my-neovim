on_attach = require("martuico.plugins.lsp.attached")

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
return {
	capabilities = capabilities,
	on_attach = on_attach,
}
