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

-- vim.cmd({ cmd = "colorscheme", args = { "catppuccin-mocha" } })
require('kanagawa').setup({
    undercurl = true,           -- enable undercurls
    globalStatus = true,       -- adjust window separators highlight for laststatus=3
})
vim.cmd({ cmd = "colorscheme", args = { "kanagawa" } })
-- vim.cmd({ cmd = "colorscheme", args = { "dracula" } })

vim.defer_fn(function()
	require("core.pluginList")
end, 0)
