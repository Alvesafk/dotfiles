-- editor.lua has the configuration of all the plugins that add or modify something on the
-- editor, in the sense of improving the writing experience.
require("telescope").setup()
pcall(require("telescope").load_extension, "fzf")

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

-- Makes LSP aware of files renamed/moved from neo-tree (updates imports).
require("lsp-file-operations").setup()

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
	completion = {
		menu = {
			draw = {
				columns = {
					{ "kind_icon" },
					{ "label",    "label_description", gap = 1 },
					{ "kind" }
				}
			}
		},

		documentation = {
			auto_show = false,
		},

	},

	signature = {
		enabled = true,
		window = {
			show_documentation = false,
			border = "single"
		},
	},
	sources = { default = { "lsp", "path", "snippets", "buffer" } },
	fuzzy = { implementation = "rust" },
})

require("tiny-inline-diagnostic").setup({
	preset = "ghost",
	transparent_bg = true,
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
require("command").setup()

require("todo-comments").setup()

-- Auto closes pairs ((), [], {}, quotes) and adds/deletes/replaces surroundings (sa, sd, sr...).
require("mini.pairs").setup()
require("mini.surround").setup()

require("neogit").setup()
require("gitsigns").setup()

-- Formatting. oxfmt is resolved from the project's node_modules first and then from $PATH.
-- Filetypes without a formatter here (go, rust, c, lua, svelte, astro...) fall back to the LSP.
local oxfmt = { "oxfmt" }
require("conform").setup({
	formatters_by_ft = {
		javascript = oxfmt,
		javascriptreact = oxfmt,
		typescript = oxfmt,
		typescriptreact = oxfmt,
		json = oxfmt,
		jsonc = oxfmt,
		css = oxfmt,
		scss = oxfmt,
		less = oxfmt,
		html = oxfmt,
		vue = oxfmt,
		yaml = oxfmt,
		markdown = oxfmt,
		graphql = oxfmt,
		odin = { "odinfmt" },
	},
	default_format_opts = { lsp_format = "fallback" },
	format_on_save = { timeout_ms = 1000 },
})
