return {
	"andweeb/presence.nvim",
	config = function()
		local config = require("presence")
		config.setup({
			client_id = "1434934634185101432",
			auto_update = true,
			neovim_image_text = "Fortune Tiger",
			main_image = "fortuneTiger",
			show_time = true,

			editing_text = "Editing %s (wow so much text)",
			file_explorer_text = "Browsing %s (wow so much files)",
			reading_text = "Reading %s (wow that's kinda boring)",
		})
	end,
}
