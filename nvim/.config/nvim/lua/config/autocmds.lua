-- autocmd.lua has custom autocmds for nvim itself or for a plugin.
local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- Calls theme.lua and sets the saved_hl to nil and transparent background to false.
autocmd("ColorScheme", {
	group = augroup("config.theme", { clear = true }),
	callback = function()
		local theme = require("config.theme")
		theme.saved_hl = nil
		theme.transparent = false
	end,
})

-- Ignored filetypes are skipped by the TreeSitter autocmd below, this serves to ignore
-- plugin buffers or windows that don't have parsers.
local ignored_langs = {
	["neo-tree"] = true,
	["neo-tree-popup"] = true,
	["toggleterm"] = true,
	["alpha"] = true,
	["blink-cmp-menu"] = true,
	["blink-cmp-signature"] = true,
	["notify"] = true,
	["noice"] = true,
	["checkhealth"] = true,
	["TelescopePrompt"] = true,
	["TelescopeResults"] = true,
	["NeogitStatus"] = true,
	["NeogitPopup"] = true,
	["NeogitConsole"] = true,
	["NeogitDiffView"] = true,
	["themery"] = true,
}

-- Starts TreeSitter (highlight + indent) for the buffer, returns false if there is no parser.
local function ts_start(buf, lang)
	if not pcall(vim.treesitter.start, buf, lang) then
		return false
	end
	vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
	return true
end

-- Starts TreeSitter based on the file type, and auto installs the parser when it is missing.
-- The filetype is mapped to the parser name (e.g. sh -> bash, javascriptreact -> tsx).
autocmd("FileType", {
	group = augroup("config.treesitter", { clear = true }),
	callback = function(args)
		local ft = args.match
		if ft == "" or ignored_langs[ft] then
			return
		end
		local lang = vim.treesitter.language.get_lang(ft) or ft

		if ts_start(args.buf, lang) then
			return
		end

		local ts_config = require("nvim-treesitter.config")
		if vim.tbl_contains(ts_config.get_installed(), lang)
			or not vim.tbl_contains(ts_config.get_available(), lang) then
			return
		end

		-- install() is async, so start TreeSitter only after the parser has been installed.
		require("nvim-treesitter").install({ lang }):await(function(err)
			if err then
				return
			end
			vim.schedule(function()
				if vim.api.nvim_buf_is_valid(args.buf) then
					ts_start(args.buf, lang)
				end
			end)
		end)
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

-- Deletes useless trailing whitespace when saving a file, keeping the cursor position.
autocmd("BufWritePre", {
	group = augroup("config.trim_whitespace", { clear = true }),
	callback = function()
		local view = vim.fn.winsaveview()
		vim.cmd([[keeppatterns silent! %s/\s\+$//e]])
		vim.fn.winrestview(view)
	end,
})

-- Augroup of the next two autocmds.
local insert_rnu = augroup("InsertRelativeNumber", { clear = true })

-- When entering insert mode disable relative numbers (only on normal buffers with numbers).
autocmd("InsertEnter", {
	group = insert_rnu,
	callback = function()
		if vim.bo.buftype == "" and vim.wo.number then vim.wo.relativenumber = false end
	end,
})

-- When leaving insert mode enable relative numbers.
autocmd("InsertLeave", {
	group = insert_rnu,
	callback = function()
		if vim.bo.buftype == "" and vim.wo.number then vim.wo.relativenumber = true end
	end,
})

-- Alpha plugins autocmd
autocmd("FileType", {
	group = augroup("config.alpha", { clear = true }),
	pattern = "alpha",
	callback = function() vim.wo.foldenable = false end,
})
