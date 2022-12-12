--[[

███╗   ██╗██╗   ██╗██╗███╗   ███╗██████╗  ██████╗
████╗  ██║██║   ██║██║████╗ ████║██╔══██╗██╔════╝
██╔██╗ ██║██║   ██║██║██╔████╔██║██████╔╝██║     
██║╚██╗██║╚██╗ ██╔╝██║██║╚██╔╝██║██╔══██╗██║     
██║ ╚████║ ╚████╔╝ ██║██║ ╚═╝ ██║██║  ██║╚██████╗
╚═╝  ╚═══╝  ╚═══╝  ╚═╝╚═╝     ╚═╝╚═╝  ╚═╝ ╚═════╝

https://github.com/zootedb0t/dotfiles   ¯\_(ツ)_/¯
--]]

require("impatient")
require("core.options")
require("core.keymappings")
require("core.statusline")
require("core.autocmd")
require("core.util")

vim.cmd({ cmd = "colorscheme", args = { "catppuccin" } })

vim.defer_fn(function()
  require("core.pluginList")
end, 0)
