local M = {}

function M.on_attach(client, bufnr)
	local map = function(mode, lhs, rhs, desc)
		vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
	end

	map("n", "gd", vim.lsp.buf.definition, "Go to definition")
	map("n", "gr", vim.lsp.buf.references, "References")
	map("n", "gi", vim.lsp.buf.implementation, "Implementation")
	map("n", "K", vim.lsp.buf.hover, "Hover")
	map("n", "<leader>rn", vim.lsp.buf.rename, "Rename")
	map("n", "<leader>ca", vim.lsp.buf.code_action, "Code Action")
	map("n", "<leader>ds", require("telescope.builtin").lsp_document_symbols, "Document Symbols")
	map("n", "<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "Workspace Symbols")
	map("n", "[d", vim.diagnostic.goto_prev, "Prev Diagnostic")
	map("n", "]d", vim.diagnostic.goto_next, "Next Diagnostic")
	map("n", "<leader>e", vim.diagnostic.open_float, "Line Diagnostics")

	if client.server_capabilities.inlayHintProvider then
		vim.lsp.inlay_hint(bufnr, true)
	end
end

return M
