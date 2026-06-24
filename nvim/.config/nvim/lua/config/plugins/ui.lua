-- ui.lua has the setups and configs for the plugins that change the how the nvim UI looks.
require("notify").setup({
	background_colour = "#000000",
})

require("noice").setup({
	presets = {
		bottom_search = true,
		command_palette = true,
		long_message_to_split = true,
		inc_renme = false,
		lsp_doc_border = false,
	},
})

require("lualine").setup({})

require("barbar").setup({
	animation = true,
	tabpages = true,
	focus_on_close = "left",
})

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

require("colorizer").setup({
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

require("ibl").setup()
require("koda").setup()
