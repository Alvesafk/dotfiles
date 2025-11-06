return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"pyright",
					"rust_analyzer",
					"biome",
					"clangd",
					"intelephense",
					"stylua",
				},
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
	},
}
