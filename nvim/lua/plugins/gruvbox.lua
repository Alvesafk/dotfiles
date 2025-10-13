return {
  "ellisonleao/gruvbox.nvim",
  priority = 100,
  config = true,
  opts = ...,
  config = function()
    vim.o.background = "dark"
    vim.cmd([[colorscheme gruvbox]])
  end
}
