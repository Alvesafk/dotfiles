-- lsp.lua is the lsp configuration and enable file.
vim.lsp.enable({ "lua_ls", "clangd", "rust_analyzer", "pyright", "bashls", "html", "cssls", "ts_ls", "gopls" })

vim.lsp.config("lua_ls", {
	settings = {
		Lua = {
			workspace = {
				library = vim.api.nvim_get_runtime_file("", true),
			},
		},
	},
})
