-- lsp.lua is the lsp configuration and enable file.
require("mason").setup()

vim.lsp.config("lua_ls", {
	settings = {
		Lua = {
			workspace = {
				library = vim.api.nvim_get_runtime_file("", true),
			},
		},
	},
})

vim.lsp.config("tailwindcss", {
	cmd = { "tailwindcss-language-server", "--stdio" },
	filetypes = { "html", "css", "javascript", "javascriptreact", "typescript", "typescriptreact" },
	root_markers = { "tailwind.config.js", "tailwind.config.ts", "postcss.config.js", "package.json" },
})

vim.lsp.config('ols', {
	cmd = { 'ols' },
	capabilities = require("blink.cmp").get_lsp_capabilities(),
})

vim.lsp.config("sqls", {
	cmd = { "sqls" },
	filetypes = { "sql", "mysql" },
	root_markers = { ".sqls", ".git" }
})

vim.lsp.enable({ "lua_ls", "clangd", "rust_analyzer", "pyright", "bashls", "html", "cssls", "ts_ls", "gopls",
	"tailwindcss", "ols", "sqls" })
