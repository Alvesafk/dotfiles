-- editor.lua has the configuration of all the plugins that add or modify something on the
-- editor, in the sense of improving the writing experience.
require("telescope").setup()

require("neo-tree").setup({
	close_if_last_window = false,
	enable_git_status = true,
	enable_diagnostics = true,
	filesystem = {
		filtered_items = {
			visible = true,
			hide_dotfiles = false,
			hide_gitignored = false,
		},
	},
})

require("luasnip.loaders.from_vscode").lazy_load()

local cmp = require("blink.cmp")
cmp.build():wait(60000)
cmp.setup({
	keymap = {
		preset = "default",
		["<C-space>"] = { "show", "hide" },
		["<C-e>"] = { "hide" },
		["<CR>"] = { "accept", "fallback" },
		["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
		["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
		["<C-k>"] = { "select_prev", "fallback" },
		["<C-j>"] = { "select_next", "fallback" },
	},
	appearance = { nerd_font_variant = "mono" },
	completion = { documentation = { auto_show = false } },
	sources = { default = { "lsp", "path", "snippets", "buffer" } },
	fuzzy = { implementation = "rust" },
})

require("tiny-inline-diagnostic").setup({
	preset = "ghost",
	transpare_bg = true,
	options = {
		multilines = {
			enabled = true,
			always_show = true,
			trim_whitespaces = true,
		},
	},
})

require("nvim-treesitter").setup()
require("toggleterm").setup()

require("gitblame").setup({
	enabled = true,
	message_template = "  <author> :: <date>",
})
