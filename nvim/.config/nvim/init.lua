--[[
 __  ____     __  _   ___      _______ __ __ _____    _____
|  \/  \ \   / / | \ | \ \    / /_   _|  \/  |  __ \ / ____|
| \  / |\ \_/ /  |  \| |\ \  / /  | | | \  / | |__) | |
| |\/| | \   /   | . ` | \ \/ /   | | | |\/| |  _  /| |
| |  | |  | |    | |\  |  \  /   _| |_| |  | | | \ \| |____
|_|  |_|  |_|    |_| \_|   \/   |_____|_|  |_|_|  \_\\_____|

https://github.com/zootedb0t/dotfiles   ¯\_(ツ)_/¯
--]]

require("impatient")
require("core.options")
require("core.keymappings")
require("core.statusline")
require("core.autocmd")

-- vim.cmd({ cmd = "colorscheme", args = { "catppuccin-mocha" } })
vim.cmd({ cmd = "colorscheme", args = { "dracula" } })

vim.defer_fn(function()
	require("core.pluginList")
end, 0)
