-- super ultra mega nvim 0.12+ config
-- alvesafk

-- vim variables
vim.o.number = true
vim.o.relativenumber = true
vim.o.wrap = false
vim.o.swapfile = false
vim.g.mapleader = " "
vim.o.cursorcolumn = false
vim.o.ignorecase = true
vim.o.smartindent = true
vim.o.autoindent = true
vim.o.termguicolors = true
vim.o.undofile = true
vim.o.incsearch = true
vim.o.cursorline = true
vim.o.updatetime = 100
vim.o.scrolloff = 10
vim.o.sidescrolloff = 10
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.hlsearch = true
vim.o.incsearch = true
vim.o.signcolumn = "yes"
vim.o.showmatch = true
vim.o.cmdheight = 1
vim.o.pumheight = 10
vim.o.pumblend = 10
vim.o.winblend = 0
vim.o.conceallevel = 0
vim.o.concealcursor = ""
vim.o.synmaxcol = 300

local undodir = vim.fn.expand("~/.vim/undodir")
if vim.fn.isdirectory(undodir) == 0 then
	vim.fn.mkdir(undodir, "p")
end

vim.o.backup = false
vim.o.writebackup = false
vim.o.undofile = true
vim.o.undodir = undodir
vim.o.updatetime = 300
vim.o.timeoutlen = 500
vim.o.ttimeoutlen = 0
vim.o.autoread = true
vim.o.autowrite = false

vim.o.hidden = true
vim.o.errorbells = false
vim.o.backspace = "indent,eol,start"
vim.o.autochdir = false
vim.o.mouse = "a"
vim.o.modifiable = true
vim.o.encoding = "UTF-8"

vim.o.laststatus = 3
vim.o.ruler = false
vim.o.ttyfast = true
vim.o.smoothscroll = true
vim.o.title = true
vim.o.numberwidth = 4
vim.o.foldmethod = "expr"
vim.o.foldlevel = 99
vim.o.foldexpr = "nvim_treesitter#foldexpr()"

vim.o.conceallevel = 2
vim.o.concealcursor = "nc"

vim.o.splitkeep = 'screen'

-- colorscheme that nvim initiates with
local initColorScheme = "gruvbox"

-- vim built in package manager!!! so cooolll
-- { src = "https://github.com//" },
vim.pack.add({
	{ src = "https://github.com/wnkz/monoglow.nvim" },
	{ src = "https://github.com/ellisonleao/gruvbox.nvim" },
	{ src = "https://github.com/oskarnurm/koda.nvim" },
	{ src = "https://github.com/folke/tokyonight.nvim" },
	{ src = "https://github.com/marko-cerovac/material.nvim" },
	{ src = "https://github.com/slugbyte/lackluster.nvim" },
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/Saghen/blink.cmp" },
	{ src = "https://github.com/Saghen/blink.lib" },
	{ src = "https://github.com/L3MON4D3/LuaSnip" },
	{ src = "https://github.com/rafamadriz/friendly-snippets" },
	{ src = "https://github.com/mattn/emmet-vim" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter" },
	{ src = "https://github.com/catgoose/nvim-colorizer.lua" },
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
	{ src = "https://github.com/akinsho/toggleterm.nvim" },
	{ src = "https://github.com/brianhuster/live-preview.nvim" },
	{ src = "https://github.com/sphamba/smear-cursor.nvim" },
	{ src = "https://github.com/f-person/git-blame.nvim" },
	{ src = "https://github.com/rachartier/tiny-inline-diagnostic.nvim" },
	{ src = "https://github.com/goolord/alpha-nvim" },
	{ src = "https://github.com/folke/noice.nvim" },
	{ src = "https://github.com/rcarriga/nvim-notify" },
	{ src = "https://github.com/romgrk/barbar.nvim" },
})

-- requiring you love
-- utils
require("notify").setup({
	background_colour = "#000000",
})

require "telescope".setup()

require("neo-tree").setup({
	close_if_last_window = false,
	enable_git_status = true,
	enable_diagnostics = true,

	filesystem = {
		filtered_items = {
			visible = true,
			hide_dotfiles = false,
			hide_gitignored = false,
		},
	},
})

require("noice").setup({
	presets = {
		bottom_search = true,
		command_palette = true,
		long_message_to_split = true,
		inc_renme = false,
		lsp_doc_border = false,
	}
})

require("luasnip.loaders.from_vscode").lazy_load()

local cmp = require('blink.cmp')
cmp.build():wait(60000)
cmp.setup({
	keymap = {
		preset = 'default',
		['<C-space>'] = { 'show', 'hide' },
		['<C-e>'] = { 'hide' },
		['<CR>'] = { 'accept', 'fallback' },
		['<Tab>'] = { 'select_next', 'snippet_forward', 'fallback' },
		['<S-Tab>'] = { 'select_prev', 'snippet_backward', 'fallback' },
		['<C-k>'] = { 'select_prev', 'fallback' },
		['<C-j>'] = { 'select_next', 'fallback' },
	},

	appearance = {
		nerd_font_variant = 'mono'
	},

	completion = {
		documentation = { auto_show = false }
	},

	sources = {
		default = { 'lsp', 'path', 'snippets', 'buffer' },
	},

	fuzzy = {
		implementation = "rust"
	}
})

require("tiny-inline-diagnostic").setup({
	preset = "ghost",
	transpare_bg = true,
	options = {
		multilines = {
			enabled = true,
			always_show = true,
			trim_whitespaces = true,
		}
	}
})

require('nvim-treesitter').setup()

require("toggleterm").setup()

require("gitblame").setup({
	enabled = true,
	message_template = "  <author> :: <date>",
})

-- themes
require('lualine').setup({})

require('colorizer').setup({
	filetypes = { "css", "javascript", "html" },
	options = {
		names = true,
		RGB = true,
		RRGGBB = true,
		RRGGBBAA = true,
		rgb_fn = true,
		hsl_fn = true,
		mode = "foreground",
	},
})
require("koda").setup()

require("smear_cursor").setup({
	cursor_color = "#ffffff",

	never_draw_over_target = true,

	smear_insert_mode = false,
	min_vertical_distance_smear = 2,
	min_horizontal_distance_smear = 2,

	time_interval = 17,
	stiffness = 0.9,
	trailing_sitffness = 0.4,
	damping = 0.99,
})

require("barbar").setup({
	animation = true,
	tabpages = true,
	focus_on_close = 'left',
})

local alpha = require("alpha")
local dashboard = require("alpha.themes.dashboard")

dashboard.section.header.val = {
	[[                                                                     ]],
	[[       ███████████           █████      ██                     ]],
	[[      ███████████             █████                             ]],
	[[      ████████████████ ███████████ ███   ███████     ]],
	[[     ████████████████ ████████████ █████ ██████████████   ]],
	[[    █████████████████████████████ █████ █████ ████ █████   ]],
	[[  ██████████████████████████████████ █████ █████ ████ █████  ]],
	[[ ██████  ███ █████████████████ ████ █████ █████ ████ ██████ ]],
	[[ ██████   ██  ███████████████   ██ █████████████████ ]],
	[[ ██████   ██  ███████████████   ██ █████████████████ ]],
}

dashboard.section.buttons.val = {
	dashboard.button("e", "  > New File", "<cmd>ene<CR>"),
	dashboard.button("f", "  > Find file", "<cmd>Telescope find_files<CR>"),
	dashboard.button("SPC e", "  > Toggle file explorer", "<cmd>Neotree float<CR>"),
	dashboard.button("SPC ff", "󰱼  > Find File", "<cmd>Telescope find_files<CR>"),
	dashboard.button("SPC fg", "  > Find Word", "<cmd>Telescope live_grep<CR>"),
	dashboard.button("SPC q", "  > Quit NVIM", "<cmd>qa<CR>"),
}

alpha.setup(dashboard.opts)

require("ibl").setup()

-- end of requires!

-- custom functions
-- visual stuff
local saved_hl = nil
local transparent = false

-- main theme function, it can change to the default colorscheme and activate
-- transparency, or be used as a function on command line with a colorscheme
-- that you want
local function coloring(data)
	local color

	if type(data) == 'table' then
		color = (data.args ~= '') and data.args or initColorScheme
	else
		color = data or initColorScheme
	end

	vim.cmd("colorscheme " .. color)
	vim.cmd(":hi statusline guibg=NONE")

	saved_hl = vim.api.nvim_get_hl(0, { name = "Normal", link = false })
	transparent = true

	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

-- a toggle transparency function
local function toggleTransparency()
	if not transparent then
		saved_hl = vim.api.nvim_get_hl(0, { name = "Normal", link = false })

		local without_bg = vim.tbl_extend("force", saved_hl, { bg = "none" })
		vim.api.nvim_set_hl(0, "Normal", without_bg)
		vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
		transparent = true
	else
		if saved_hl then
			vim.api.nvim_set_hl(0, "Normal", saved_hl)
		end
		transparent = false
	end
end

vim.cmd("colorscheme " .. initColorScheme)

vim.api.nvim_create_user_command('Coloring', coloring, { nargs = "?", complete = 'color' })

-- custom autocmds because they killed ma boy, RIP treesitter.configs...
-- autocmd to disable transparency when changing colorscheme
vim.api.nvim_create_autocmd("ColorScheme", {
	callback = function()
		saved_hl = nil
		transparent = false
	end,
})

-- autocmd to activate indentation of treesitter
vim.api.nvim_create_autocmd("FileType", {
	callback = function()
		pcall(vim.treesitter.start)
		vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
	end,
})

-- autocmd to auto install treesitter language thingies
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

vim.api.nvim_create_autocmd("FileType", {
	callback = function()
		local lang = vim.bo.filetype
		local installed = require("nvim-treesitter.config").get_installed()
		if not vim.tbl_contains(installed, lang) and not ignored_langs[lang] then
			require("nvim-treesitter").install({ lang })
		end
		pcall(vim.treesitter.start)
	end
})

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("config.lsp", { clear = true }),
	callback = function(args)
		local map = function(lhs, rhs)
			vim.keymap.set("n", lhs, rhs, { buffer = args.buf })
		end

		map("<leader>gd", vim.lsp.buf.definition)
		map("<leader>gD", vim.lsp.buf.declaration)
		map("<leader>gi", vim.lsp.buf.implementation)
	end
})

vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*",
	command = [[%s/\s\*$//e]],
})

-- Autocmd to change relative number to false when in insert mode, and
-- to true when out of insert mode.
vim.api.nvim_create_augroup("InsertRelativeNumber", { clear = true })

vim.api.nvim_create_autocmd("InsertEnter", {
	group = "InsertRelativeNumber",
	callback = function()
		vim.o.relativenumber = false
	end,
})

vim.api.nvim_create_autocmd("InsertLeave", {
	group = "InsertRelativeNumber",
	callback = function()
		vim.o.relativenumber = true
	end,
})

vim.cmd([[autocmd FileType alpha setlocal nofoldenable]])

-- lsp enableingi
vim.lsp.enable({ "lua_ls", "clangd", "rust_analyzer", "pyright", "bashls", "html", "cssls", "ts_ls", "gopls", })
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

-- vim keymap functions
map('n', '<leader>o', ':source<CR>')
map('n', '<leader>w', ':write<CR>')
map('n', '<leader>q', ':exit<CR>')
map('n', '<leader>r', ':restart<CR>')
map('n', '<leader>tm', ':ToggleTerm direction=float name=@io<CR>')
map('n', '<leader>no', ':noh<CR>')

vim.keymap.set("n", "<leader>tw", function()
	vim.wo.wrap = not vim.wo.wrap
end, { desc = "Toggle wrap" })

map({ 'n', 'v', 'x' }, '<leader>y', '"+y')
map({ 'n', 'v', 'x' }, '<leader>d', '"+d')

-- plugins keymap functions
map('n', '<leader>lf', vim.lsp.buf.format)
map('n', '<leader>ca', vim.lsp.buf.code_action)
map('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
map('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
map('n', '<leader>e', ':Neotree float<CR>')
map('n', '<leader>ti', ':IBLToggle<CR>')
map('n', '<leader>gb', ':GitBlameToggle<CR>')

-- own functions maps
map('n', '<leader>tt', ':Coloring<CR>')
map('n', '<leader>tp', toggleTransparency)

map("n", "j", function()
	return vim.v.count == 0 and "gj" or "j"
end, { expr = true, silent = true })

map("n", "k", function()
	return vim.v.count == 0 and "gk" or "k"
end, { expr = true, silent = true })

-- init custom functions calls
coloring()
