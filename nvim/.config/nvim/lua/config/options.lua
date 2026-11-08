-- options.lua has all the vim options configurations.
-- Options that are already Neovim defaults are not set here (see :h vim-differences).
vim.g.mapleader = " "

-- Auto detection is async (after the terminal answers), colorizer needs it set at startup.
vim.o.termguicolors = true
vim.o.number = true
vim.o.relativenumber = true
vim.o.numberwidth = 4
vim.o.wrap = false
vim.o.swapfile = false
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.smartindent = true
vim.o.undofile = true
vim.o.cursorline = true
vim.o.scrolloff = 10
vim.o.sidescrolloff = 10
vim.o.signcolumn = "yes"
vim.o.showmatch = true
vim.o.pumheight = 10
vim.o.pumblend = 10

vim.o.synmaxcol = 300
vim.o.writebackup = false
vim.o.updatetime = 300
vim.o.timeoutlen = 500
vim.o.ttimeoutlen = 0
vim.o.mouse = "a"
vim.o.laststatus = 3
vim.o.ruler = false
vim.o.smoothscroll = true
vim.o.title = true
vim.o.foldmethod = "expr"
vim.o.foldlevel = 99
vim.o.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.o.splitkeep = "screen"

-- Creates the undodir incase it does not exist yet
local undodir = vim.fn.expand("~/.vim/undodir")
if vim.fn.isdirectory(undodir) == 0 then
	vim.fn.mkdir(undodir, "p")
end
vim.o.undodir = undodir
