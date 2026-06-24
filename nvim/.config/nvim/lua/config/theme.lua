local M = {}

-- Initial state of the theme.
M.init_colorscheme = "gruvbox"
M.saved_hl = nil
M.transparent = false

-- This function set the colorscheme and then makes the background transparent. It uses the
-- init_colorscheme variable as default, but it can be called as well from the command line
-- with other colorscheme.
function M.coloring(data)
	local color

	if type(data) == "table" then
		color = (data.args ~= "") and data.args or M.init_colorscheme
	else
		color = data or M.init_colorscheme
	end

	vim.cmd("colorscheme " .. color)
	vim.cmd(":hi statusline guibg=NONE")

	M.saved_hl = vim.api.nvim_get_hl(0, { name = "Normal", link = false })
	M.transparent = true

	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

-- This function is for toggling the transparency of the background.
function M.toggle_transparency()
	if not M.transparent then
		M.saved_hl = vim.api.nvim_get_hl(0, { name = "Normal", link = false })
		local without_bg = vim.tbl_extend("force", M.saved_hl, { bg = "none" })
		vim.api.nvim_set_hl(0, "Normal", without_bg)
		vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
		M.transparent = true
	else
		if M.saved_hl then
			vim.api.nvim_set_hl(0, "Normal", M.saved_hl)
		end
		M.transparent = false
	end
end

-- Creates the Coloring user command.
vim.api.nvim_create_user_command("Coloring", M.coloring, { nargs = "?", complete = "color" })

-- Calls Coloring on init.
M.coloring()

return M
