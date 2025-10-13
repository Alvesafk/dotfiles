return {
  'andweeb/presence.nvim',
  config = function ()
    local config = require("presence")
    config.setup({
      auto_update = true,
      neovim_image_text = "NeoVim",
      main_image = "neovim",
      show_time = true,

      editing_text = "Editing %s (wow so much text)",
      file_explorer_text = "Browsing %s (wow so much files)",
      reading_text = "Reading %s (wow that's kinda boring)",
    })
  end ,
}
