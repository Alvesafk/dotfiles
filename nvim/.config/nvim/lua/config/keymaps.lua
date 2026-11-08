-- Variables to facilitate the keymaps config.
local map = vim.keymap.set
local builtin = require("telescope.builtin")
local theme = require("config.theme")

-- Nvim based keymaps.
map("n", "j", function()
	return vim.v.count == 0 and "gj" or "j"
end, { expr = true, silent = true, desc = "Down (display line)" })

map("n", "k", function()
	return vim.v.count == 0 and "gk" or "k"
end, { expr = true, silent = true, desc = "Up (display line)" })

map("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
map("n", "<C-j>", "<C-w>j", { desc = "Go to lower window" })
map("n", "<C-k>", "<C-w>k", { desc = "Go to upper window" })
map("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })

map("n", "<leader>o", "<cmd>source<CR>", { desc = "Source current file" })
map("n", "<leader>w", "<cmd>write<CR>", { desc = "Write file" })
map("n", "<leader>q", "<cmd>exit<CR>", { desc = "Write (if changed) and close window" })
map("n", "<leader>r", "<cmd>restart<CR>", { desc = "Restart Neovim" })
map("n", "<leader>no", "<cmd>noh<CR>", { desc = "Clear search highlight" })

map("n", "<leader>tw", function()
	vim.wo.wrap = not vim.wo.wrap
end, { desc = "Toggle wrap" })

map({ "n", "v" }, "<leader>y", '"+y', { desc = "Yank to system clipboard" })
map({ "n", "v" }, "<leader>d", '"+d', { desc = "Delete to system clipboard" })

map("n", "<leader>lf", vim.lsp.buf.format, { desc = "LSP format" })
map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "LSP code action" })

map("n", "<leader>tc", function()
	vim.o.colorcolumn = vim.o.colorcolumn == "90" and "" or "90"
end, { desc = "Toggle color column" })

-- Plugin based keymaps.
map("n", "<leader>ff", builtin.find_files, { desc = "Telescope find files" })
map("n", "<leader>fg", builtin.live_grep, { desc = "Telescope live grep" })
map("n", "<leader>e", "<cmd>Neotree float<CR>", { desc = "File explorer" })
map("n", "<leader>ti", "<cmd>IBLToggle<CR>", { desc = "Toggle indent lines" })
map("n", "<leader>tm", "<cmd>ToggleTerm direction=float name=@io<CR>", { desc = "Toggle floating terminal" })
map("n", "<leader>te", "<cmd>CommandExecute<CR>", { desc = "Execute command" })
map("n", "<leader>tl", "<cmd>CommandExecuteLast<CR>", { desc = "Execute last command" })

map("n", "<leader>tt", "<cmd>Themery<CR>", { desc = "Theme picker" })

map("n", "<leader>ft", "<cmd>TodoTelescope<CR>", { desc = "Find TODOs" })
map("n", "<leader>fl", "<cmd>TodoLocList<CR>", { desc = "TODOs in location list" })

-- Git stuff
map("n", "<leader>gg", "<cmd>Neogit<CR>", { desc = "Neogit" })
map("n", "<leader>gb", "<cmd>Gitsigns blame_line<CR>", { desc = "Git blame line" })

-- Own functions based keymaps.
map("n", "<leader>tp", theme.toggle_transparency, { desc = "Toggle transparency" })
