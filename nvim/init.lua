local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",     
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("vim-options")
require("settings")
require("lazy").setup("plugins") 

-- lsp configuration, terrible one btw, but it's what i could do, someday i will fix this
vim.lsp.enable("lua_ls")
vim.lsp.enable("rust_analyzer")
vim.lsp.enable("pyright")
vim.lsp.enable("bash-language-server")
vim.lsp.enable("biome")
vim.lsp.enable("csharp-language-server")
vim.lsp.enable("intelephense")
vim.lsp.enable("html-lsp")
vim.lsp.enable("css-lsp")

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.php",
  callback = function ()
    vim.lsp.buf.format()
  end,
})
