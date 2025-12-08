local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("vim-options")
require("settings")
require("lazy").setup("plugins")

-- lsp configuration, terrible one btw, but it's what i could do, someday i will fix this
vim.lsp.enable({
	"lua_ls",
	"clangd",
	"rust_analyzer",
	"pyright",
	"bash-language-server",
	"csharp-language-server",
	"intelephense",
	"html-lsp",
	"css-lsp",
	"typescript-language-server",
})

-- php things if it works it works
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*.php",
	callback = function()
		vim.lsp.buf.format()
	end,
})
