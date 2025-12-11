-- vim config
vim.o.number = true
vim.o.relativenumber = true
vim.o.wrap = true
vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.shiftwidth = 2
vim.o.swapfile = false
vim.g.mapleader = " "
vim.o.winborder = "rounded"
vim.o.cursorcolumn = false
vim.o.ignorecase = true
vim.o.smartindent = true
vim.o.termguicolors = true
vim.o.undofile = true
vim.o.incsearch = true

-- vim built in package manager!!! so cooolll
vim.pack.add({
	{ src = "https://github.com/wnkz/monoglow.nvim" },
	{ src = "https://github.com/echasnovski/mini.pick" },
	{ src = "https://github.com/echasnovski/mini.files" },
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/Saghen/blink.cmp" },
	{ src = "https://github.com/L3MON4D3/LuaSnip" },
	{ src = "https://github.com/rafamadriz/friendly-snippets" },
	{ src = "https://github.com/mattn/emmet-vim" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter" },
	{ src = "https://github.com/norcalli/nvim-colorizer.lua" },
})

-- requiring you love
require "mini.pick".setup()
require "mini.files".setup()

require("luasnip.loaders.from_vscode").lazy_load()
require('blink.cmp').setup({
	keymap = {
		preset = 'default', -- 'default' | 'super-tab' | 'enter'
		['<C-space>'] = { 'show', 'hide' },
		['<C-e>'] = { 'hide' },
		['<CR>'] = { 'accept', 'fallback' },
		['<Tab>'] = { 'select_next', 'snippet_forward', 'fallback' },
		['<S-Tab>'] = { 'select_prev', 'snippet_backward', 'fallback' },
		['<C-k>'] = { 'select_prev', 'fallback' },
		['<C-j>'] = { 'select_next', 'fallback' },
	},
	appearance = {
		use_nvim_cmp_as_default = false,
		nerd_font_variant = 'mono'
	},
	sources = {
		default = { 'lsp', 'path', 'snippets', 'buffer', },
	},
	snippets = {
		preset = 'luasnip',
	},
})

require('nvim-treesitter.configs').setup({
	ensure_installed = { "c", "lua", "vim", "vimdoc", "python", "rust", "javascript", "html", "css" },
	sync_install = false,
	auto_install = true,
	highlight = { enable = true },
})

require('colorizer').setup({
	filetypes = { "css", "javascript", "html" },
	user_default_options = {
		names = true,
		RGB = true,
		RRGGBB = true,
		RRGGBBAA = true,
		rgb_fn = true,
		hsl_fn = true,
		mode = "background",
	},
})

-- function!!!!
local function pick_centered(picker)
	local height = math.floor(0.6 * vim.o.lines)
	local width = math.floor(0.6 * vim.o.columns)

	require('mini.pick').builtin[picker]({}, {
		window = {
			config = {
				anchor = 'NW',
				height = height,
				width = width,
				row = math.floor(0.5 * (vim.o.lines - height)),
				col = math.floor(0.5 * (vim.o.columns - width)),
				border = 'rounded',
			}
		}
	})
end

-- visual stuff
function coloring(color)
	color = color or "monoglow"
	vim.cmd("colorscheme monoglow")
	vim.cmd(":hi statusline guibg=NONE")

	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

coloring()

vim.api.nvim_create_user_command('Coloring', coloring, {})

-- lsp enableingi
vim.lsp.enable({ "lua_ls", "clangd", "rust_analyzer", "pyright", "bashls", "html", "cssls", "ts_ls" })
vim.lsp.config("lua_ls", {
	settings = {
		Lua = {
			workspace = {
				library = vim.api.nvim_get_runtime_file("", true),
			}
		}
	}
})

-- keymapsons
local map = vim.keymap.set

map('n', '<leader>o', ':source<CR>')
map('n', '<leader>w', ':write<CR>')
map('n', '<leader>q', ':exit<CR>')
map('n', '<leader>lf', vim.lsp.buf.format)
map('n', '<leader>ca', vim.lsp.buf.code_action)
map('n', '<leader>ff', function() pick_centered('files') end)
map('n', '<leader>fg', function() pick_centered('grep') end)
map('n', '<leader>e', ':lua MiniFiles.open()<CR>')

map('n', '<leader>t', ':Coloring<CR>')

map({ 'n', 'v', 'x' }, '<leader>y', '"+y')
map({ 'n', 'v', 'x' }, '<leader>d', '"+d')

vim.g.user_emmet_leader_key = ','
map('i', '<C-y>,', '<plug>(emmet-expand-abbr)')
