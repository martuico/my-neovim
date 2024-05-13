local ok, lsp_inlayhints = pcall(require, "lsp-inlayhints")
print("lsp_inlayhints")
if not ok then
	return
end

lsp_inlayhints.setup({})
