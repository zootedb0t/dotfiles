local lsp = require("lspconfig")
-- local navic = require("nvim-navic")

-- Overide handlers

local signs = { Error = "✘", Warn = "▲", Info = "", Hint = "" }
for sign, icon in pairs(signs) do
	vim.fn.sign_define("DiagnosticSign" .. sign, {
		text = icon,
		texthl = "Diagnostic" .. sign,
		-- linehl = false,
		-- numhl = "Diagnostic" .. sign,
	})
end

vim.diagnostic.config({
	-- underline = true,
	signs = true,
	severity_sort = true,
	update_in_insert = false,
	virtual_text = false,
	-- virtual_text = {
	--   spacing = 10,
	--   severity_sort = "Error",
	-- },
	float = {
		focusable = false,
		style = "minimal",
		border = "rounded",
		-- source = "always",
		header = "Diagnostic",
	},
})

local opts = { noremap = true, silent = true }
vim.keymap.set("n", "<space>d", vim.diagnostic.open_float, opts)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, opts)
vim.keymap.set("n", "<M-f>", vim.lsp.buf.format, opts)

local function lsp_keymap(bufnr)
	-- Mappings.
	-- See `:help vim.lsp.*` for documentation on any of the below functions
	local bufopts = { noremap = true, silent = true, buffer = bufnr }
	vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
	vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
	vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
	vim.keymap.set("n", "<space>k", vim.lsp.buf.signature_help, bufopts)
	vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, bufopts)
	vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, bufopts)
	vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, bufopts)
	vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

-- capabilities.textDocument.completion.completionItem.snippetSupport = true
-- capabilities.textDocument.completion.completionItem.preselectSupport = true
-- capabilities.textDocument.completion.completionItem.insertReplaceSupport = true
-- capabilities.textDocument.completion.completionItem.labelDetailsSupport = true
-- capabilities.textDocument.completion.completionItem.deprecatedSupport = true
-- capabilities.textDocument.completion.completionItem.commitCharactersSupport = true
-- capabilities.textDocument.completion.completionItem.tagSupport = {
-- 	valueSet = { 1 },
-- }
-- capabilities.textDocument.completion.completionItem.resolveSupport = {
-- 	properties = {
-- 		"documentation",
-- 		"detail",
-- 		"additionalTextEdits",
-- 	},
-- }

local servers = {
	clangd = {},
	pyright = {},
	sumneko_lua = {
		settings = {
			Lua = {
				completion = {
					enable = true,
					callSnippet = "Replace",
				},
				diagnostics = {
					enable = true,
					globals = {
						"vim",
					},
				},
			},
		},
	},
}

local on_attach = function(client, bufnr)
	if client.server_capabilities.documentHighlightProvider then
		vim.api.nvim_create_augroup("lsp_document_highlight", { clear = false })
		vim.api.nvim_create_autocmd("CursorHold", {
			group = "lsp_document_highlight",
			pattern = "<buffer>",
			callback = vim.lsp.buf.document_highlight,
		})
		vim.api.nvim_create_autocmd({ "CursorMoved", "InsertEnter" }, {
			group = "lsp_document_highlight",
			pattern = "<buffer>",
			callback = vim.lsp.buf.clear_references,
		})
	end

	-- Use null-ls for formatting
	client.server_capabilities.documentFormattingProvider = false
	lsp_keymap(bufnr)
	-- navic.attach(client, bufnr)
end

for name, opts in pairs(servers) do
	if type(opts) == "function" then
		opts()
	else
		local client = lsp[name]
		client.setup(vim.tbl_extend("force", {
			flags = { debounce_text_changes = 150 },
			on_attach = on_attach,
			capabilities = capabilities,
		}, opts))
	end
end
-- end
