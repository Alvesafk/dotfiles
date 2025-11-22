return {
  {
    "wnkz/monoglow.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
		config = function()
			require("monoglow").setup({
        on_colors = function(colors)
          colors.glow = "#cc5500"
        end
			})
		end,
  },
  {
    "dasupradyumna/midnight.nvim",
    lazy = false,
    priority = 1000
  },
	{
		"ellisonleao/gruvbox.nvim",
		priority = 100,
		config = true,
		opts = ...,
		config = function()
			vim.o.background = "dark"
			vim.cmd([[colorscheme gruvbox]])
		end,
	},
	{
		"navarasu/onedark.nvim",
		priority = 1000,
		config = function()
			require("onedark").setup({
				style = "deep",
			})
			require("onedark").load()
		end,
	},
	{
		"zaldih/themery.nvim",
		lazy = false,
		config = function()
			require("themery").setup({
				themes = {
					{ name = "Gruvbox Dark", colorscheme = "gruvbox" },
					{ name = "Onedark", colorscheme = "onedark" },
          { name = "Midnight", colorscheme = "midnight" },
          { name = "Monoglow", colorscheme = "monoglow" },
				},
				livePreview = true,
			})
		end,
	},

	{
		"xiyaowong/transparent.nvim",
		config = function()
			require("transparent").setup({
				groups = {
					"Normal",
					"NormalNC",
					"Comment",
					"Constant",
					"Special",
					"Identifier",
					"Statement",
					"PreProc",
					"Type",
					"Underlined",
					"Todo",
					"String",
					"Function",
					"Conditional",
					"Repeat",
					"Operator",
					"Structure",
					"LineNr",
					"NonText",
					"SignColumn",
					"CursorLine",
					"CursorLineNr",
					"StatusLine",
					"StatusLineNC",
					"EndOfBuffer",
				},
				extra_groups = {},
				exclude_groups = {},
				on_clear = function() end,
			})
		end,
	},
}
