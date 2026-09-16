-- Variables to facilitate the keymaps config.
local map = vim.keymap.set
local builtin = require("telescope.builtin")
local theme = require("config.theme")

-- Nvim based keymaps.
map("n", "j", function()
	return vim.v.count == 0 and "gj" or "j"
end, { expr = true, silent = true })

map("n", "k", function()
	return vim.v.count == 0 and "gk" or "k"
end, { expr = true, silent = true })

map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")

map("n", "<leader>o", ":source<CR>")
map("n", "<leader>w", ":write<CR>")
map("n", "<leader>q", ":exit<CR>")
map("n", "<leader>r", ":restart<CR>")
map("n", "<leader>no", ":noh<CR>")

map("n", "<leader>tw", function()
	vim.wo.wrap = not vim.wo.wrap
end, { desc = "Toggle wrap" })

map({ "n", "v", "x" }, "<leader>y", '"+y')
map({ "n", "v", "x" }, "<leader>d", '"+d')

map("n", "<leader>lf", vim.lsp.buf.format)
map("n", "<leader>ca", vim.lsp.buf.code_action)

map("n", "<leader>tc", function()
	local cc = "0"
	if vim.o.colorcolumn ~= "90" then
		cc = "90"
	end
	vim.o.colorcolumn = cc
end)

-- Plugin based keymaps.
map("n", "<leader>ff", builtin.find_files, { desc = "Telescope find files" })
map("n", "<leader>fg", builtin.live_grep, { desc = "Telescope live grep" })
map("n", "<leader>e", ":Neotree float<CR>")
map("n", "<leader>ti", ":IBLToggle<CR>")
map("n", "<leader>tm", ":ToggleTerm direction=float name=@io<CR>")
map("n", "<leader>te", ":CommandExecute<CR>")
map("n", "<leader>tl", ":CommandExecuteLast<CR>")

map("n", "<leader>tt", ":Themery<CR>")

map("n", "<leader>ft", ":TodoTelescope<CR>")
map("n", "<leader>fl", ":TodoLocList<CR>")

-- Git stuff
map("n", "<leader>gg", ":Neogit<CR>")
map("n", "G", ":Gitsigns blame_line<CR>")

-- Own functions based keymaps.
map("n", "<leader>tp", theme.toggle_transparency)
