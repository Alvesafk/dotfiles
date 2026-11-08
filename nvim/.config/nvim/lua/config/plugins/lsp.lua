-- lsp.lua is the lsp configuration and enable file.
-- cmd, filetypes and root_dir of every server come from nvim-lspconfig (lsp/<name>.lua), the
-- configs here only override what is different. blink.cmp capabilities are applied
-- automatically to all servers through vim.lsp.config("*").
require("mason").setup()

-- Only the Neovim runtime is indexed, indexing every plugin makes lua_ls really slow.
vim.lsp.config("lua_ls", {
	settings = {
		Lua = {
			runtime = { version = "LuaJIT" },
			workspace = {
				checkThirdParty = false,
				library = { vim.env.VIMRUNTIME, "${3rd}/luv/library" },
			},
		},
	},
})

-- On Linux Neovim doesn't advertise file watching to servers by default, so gopls never sees
-- go.mod/go.sum changes made outside the editor (e.g. `go get`). Enabled only for gopls, it uses
-- inotifywait as the backend when it is installed.
vim.lsp.config("gopls", {
	capabilities = {
		workspace = {
			didChangeWatchedFiles = { dynamicRegistration = true },
		},
	},
})

vim.lsp.config("sqls", {
	root_markers = { ".sqls", ".git" },
})

vim.lsp.config("astro", {
	root_markers = { "astro.config.mjs", "astro.config.ts", "package.json", "tsconfig.json", ".git" },
	-- astro-ls requires typescript.tsdk, uses the project's TypeScript and falls back to the one
	-- bundled with the Mason package. TypeScript 7+ (native Go port) has no tsserverlibrary.js,
	-- so it is skipped.
	before_init = function(params, config)
		local function is_tsdk(lib)
			return vim.uv.fs_stat(vim.fs.joinpath(lib, "typescript.js")) ~= nil
				or vim.uv.fs_stat(vim.fs.joinpath(lib, "tsserverlibrary.js")) ~= nil
		end

		local candidates = {}
		if config.root_dir then
			table.insert(candidates, vim.fs.joinpath(config.root_dir, "node_modules/typescript/lib"))
			for dir in vim.fs.parents(config.root_dir) do
				table.insert(candidates, vim.fs.joinpath(dir, "node_modules/typescript/lib"))
			end
		end
		table.insert(candidates, vim.fs.joinpath(vim.fn.stdpath("data"),
			"mason/packages/astro-language-server/node_modules/typescript/lib"))

		for _, lib in ipairs(candidates) do
			if is_tsdk(lib) then
				params.initializationOptions = params.initializationOptions or {}
				params.initializationOptions.typescript = { tsdk = lib }
				return
			end
		end
		vim.notify("astro-ls: no TypeScript with tsserverlibrary.js found (TypeScript 7+ is not supported)",
			vim.log.levels.WARN)
	end,
})

vim.lsp.enable({ "lua_ls", "clangd", "rust_analyzer", "pyright", "bashls", "html", "cssls", "ts_ls", "gopls",
	"tailwindcss", "ols", "sqls", "svelte", "astro" })
