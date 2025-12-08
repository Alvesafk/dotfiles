return {
	"m4xshen/autoclose.nvim",
	config = function()
		require("autoclose").setup({
			options = {
				disabled_filetypes = { "text", "markdown" },
				disable_when_touch = true,
			},
		})
	end,
}
