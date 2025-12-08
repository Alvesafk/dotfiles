return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			local config = require("nvim-treesitter.configs")
			config.setup({
				ensure_installed = { "lua", "python", "rust", "javascript", "html", "css" },
				highlight = { enable = true },
				indent = { enable = true, disable = { "php", "html", "php.html", "html.php" } },
			})
		end,
	},
	{
		"NvChad/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup({
				filetypes = { "css", "javascript", "html" },
				user_default_options = {
					names = true,
					RGB = true,
					RRGGBB = true,
					RRGGBBAA = true,
					rgb_fn = true,
					hsl_fn = true,
					mode = "background",
				},
			})
		end,
	},
}
