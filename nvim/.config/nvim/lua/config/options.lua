-- options.lua has all the vim options configurations.
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
vim.o.smartcase = true
vim.o.hlsearch = true
vim.o.signcolumn = "yes"
vim.o.showmatch = true
vim.o.cmdheight = 1
vim.o.pumheight = 10
vim.o.pumblend = 10
vim.o.winblend = 0

-- Conceal Markdown tags
vim.o.conceallevel = 2
vim.o.concealcursor = "nc"

vim.o.synmaxcol = 300
vim.o.backup = false
vim.o.writebackup = false
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
vim.o.splitkeep = "screen"

-- Creates the undodir incase it does not exist yet
local undodir = vim.fn.expand("~/.vim/undodir")
if vim.fn.isdirectory(undodir) == 0 then
	vim.fn.mkdir(undodir, "p")
end
vim.o.undodir = undodir
