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
require('kanagawa').setup({
    undercurl = true,           -- enable undercurls
    commentStyle = { italic = false },
    functionStyle = {},
    keywordStyle = { italic = true},
    statementStyle = { bold = true },
    typeStyle = {},
    variablebuiltinStyle = { italic = true},
    specialReturn = true,       -- special highlight for the return keyword
    specialException = true,    -- special highlight for exception handling keywords
    transparent = false,        -- do not set background color
    dimInactive = false,        -- dim inactive window `:h hl-NormalNC`
    globalStatus = false,       -- adjust window separators highlight for laststatus=3
    terminalColors = true,      -- define vim.g.terminal_color_{0,17}
    colors = {},
    overrides = {},
    theme = "default"           -- Load "default" theme or the experimental "light" theme
})
vim.cmd({ cmd = "colorscheme", args = { "kanagawa" } })
-- vim.cmd({ cmd = "colorscheme", args = { "dracula" } })

vim.defer_fn(function()
	require("core.pluginList")
end, 0)
