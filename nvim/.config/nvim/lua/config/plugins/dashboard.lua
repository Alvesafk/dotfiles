-- Dashboard config, when opening nvim it will show a screen with this title.
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
