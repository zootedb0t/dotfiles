-- Source Lua file
vim.api.nvim_create_user_command("SourceFile", function()
	vim.cmd([[luafile %]])
	require("notify")("File Reloaded 勒勒")
end, { desc = "Source Current Buffer" })

-- Change directory
vim.api.nvim_create_user_command("ChangeDirectory", function()
	vim.cmd([[lcd%:p:h]])
	require("notify")("Directory changed  ﱮ ")
end, { desc = "Command to change directory" })

vim.api.nvim_create_user_command('PeekOpen', require('peek').open, {})
vim.api.nvim_create_user_command('PeekClose', require('peek').close, {})
