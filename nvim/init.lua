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
-- { src = "https://github.com//" },
vim.pack.add({
	{ src = "https://github.com/wnkz/monoglow.nvim" },
	{ src = "https://github.com/ellisonleao/gruvbox.nvim" },
	{ src = "https://github.com/folke/tokyonight.nvim" },
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/Saghen/blink.cmp" },
	{ src = "https://github.com/L3MON4D3/LuaSnip" },
	{ src = "https://github.com/rafamadriz/friendly-snippets" },
	{ src = "https://github.com/mattn/emmet-vim" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter" },
	{ src = "https://github.com/norcalli/nvim-colorizer.lua" },
	{ src = "https://github.com/lukas-reineke/indent-blankline.nvim" },
	{ src = "https://github.com/nvim-telescope/telescope.nvim" },
	{ src = "https://github.com/nvim-telescope/telescope-fzf-native.nvim" },
	{ src = "https://github.com/nvim-lua/plenary.nvim" },
	{ src = "https://github.com/nvim-tree/nvim-web-devicons" },
  { src = "https://github.com/nvim-neo-tree/neo-tree.nvim" },
  { src = "https://github.com/MunifTanjim/nui.nvim" },
  { src = "https://github.com/antosha417/nvim-lsp-file-operations" },
  { src = "https://github.com/folke/snacks.nvim" },
  { src = "https://github.com/nvim-lualine/lualine.nvim" },
})

-- requiring you love
require "telescope".setup()
require("neo-tree").setup({
  close_if_last_window = false,  
})

require('lualine').setup()

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

require("ibl").setup()

-- visual stuff
function coloring(data)
	local color

	if type(data) == 'table' then
		color = (data.args ~= '') and data.args or "gruvbox"
	else
		color = data or "gruvbox"
	end

	vim.cmd("colorscheme " .. color)
	vim.cmd(":hi statusline guibg=NONE")

	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

coloring()

vim.api.nvim_create_user_command('Coloring', coloring, { nargs = "?", complete = 'color' })

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
local builtin = require('telescope.builtin')

map('n', '<leader>o', ':source<CR>')
map('n', '<leader>w', ':write<CR>')
map('n', '<leader>q', ':exit<CR>')
map('n', '<leader>tm', ':terminal<CR>')

map('n', '<leader>lf', vim.lsp.buf.format)
map('n', '<leader>ca', vim.lsp.buf.code_action)
map('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
map('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
map('n', '<leader>e', ':Neotree<CR>')
map('n', '<leader>ti', ':IBLToggle<CR>')

map('n', '<leader>tt', ':Coloring<CR>')

map({ 'n', 'v', 'x' }, '<leader>y', '"+y')
map({ 'n', 'v', 'x' }, '<leader>d', '"+d')

-- vim.g.user_emmet_leader_key = ','
-- map('i', '<C-y>,', '<plug>(emmet-expand-abbr)')
