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
require("core.autocmd")
require("core.statusline")

vim.cmd({ cmd = "colorscheme", args = {"dracula"}})

-- Statusline
vim.api.nvim_exec([[
  augroup Statusline
  au!
  au WinEnter,BufEnter * setlocal statusline=%!v:lua.Statusline.active()
  au WinLeave,BufLeave * setlocal statusline=%!v:lua.Statusline.inactive()
  au WinEnter,BufEnter,FileType NvimTree setlocal statusline=%!v:lua.Statusline.short()
  augroup END
]], false)

vim.defer_fn(function()
	require("core.pluginList")
end, 0)
