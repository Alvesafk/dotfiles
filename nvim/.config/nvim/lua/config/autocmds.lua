-- autocmd.lua has custom autocmds for nvim itself or for a plugin.
local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- Calls theme.lua and sets the saved_hl to nil and transparent background to false.
autocmd("ColorScheme", {
	callback = function()
		local theme = require("config.theme")
		theme.saved_hl = nil
		theme.transparent = false
	end,
})

-- Starts treesitter based on the file type.
autocmd("FileType", {
	callback = function()
		pcall(vim.treesitter.start)
		vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
	end,
})

-- Igonred langs is used on a autocmd that makes TreeSitter auto install parsers for files
-- that aren't installed yet, this serves to ignore files or buffers that don't have parsers.
local ignored_langs = {
	["neo-tree"] = true,
	["neo-tree-popup"] = true,
	["toggleterm"] = true,
	["sh"] = true,
	["alpha"] = true,
	["blink-cmp-menu"] = true,
	["notify"] = true,
	["noice"] = true,
	["checkhealth"] = true,
	["TelescopePrompt"] = true,
	["TelescopeResults"] = true,
}

-- Auto install parser from TreeSitter based on the file that has been opened
autocmd("FileType", {
	callback = function()
		local lang = vim.bo.filetype
		local installed = require("nvim-treesitter.config").get_installed()
		if not vim.tbl_contains(installed, lang) and not ignored_langs[lang] then
			require("nvim-treesitter").install({ lang })
		end
		pcall(vim.treesitter.start)
	end,
})

-- Lsp keybinds
autocmd("LspAttach", {
	group = augroup("config.lsp", { clear = true }),
	callback = function(args)
		local map = function(lhs, rhs)
			vim.keymap.set("n", lhs, rhs, { buffer = args.buf })
		end
		map("<leader>gd", vim.lsp.buf.definition)
		map("<leader>gD", vim.lsp.buf.declaration)
		map("<leader>gi", vim.lsp.buf.implementation)
	end,
})

-- Regex to delete Useless trailing whitespace when saving a file.
autocmd("BufWritePre", {
	pattern = "*",
	command = [[%s/\s\*$//e]],
})

-- Augroup of the next two autocmds.
local insert_rnu = augroup("InsertRelativeNumber", { clear = true })

-- When entering insert mode disable relative numbers.
autocmd("InsertEnter", {
	group = insert_rnu,
	callback = function() vim.o.relativenumber = false end,
})

-- When leaving insert mode enable relative numbers.
autocmd("InsertLeave", {
	group = insert_rnu,
	callback = function() vim.o.relativenumber = true end,
})

-- Alpha plugins autocmd
vim.cmd([[autocmd FileType alpha setlocal nofoldenable]])
