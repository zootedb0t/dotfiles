local cmd = vim.api.nvim_create_autocmd

-- Highlight on yank
cmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank({ higroup = "IncSearch", timeout = 200, on_visual = true })
	end,
	pattern = "*",
})

-- cmd("ColorScheme", {
-- 	pattern = "*",
-- 	callback = function()
-- 		-- vim.api.nvim_set_hl(0,"LineNr",{ cterm = bold, bold = true})
-- 		vim.api.nvim_set_hl(0, "LineNr", { fg = "#f8f8f2" })
-- 	end,
-- })

-- Fixing cursor
cmd("VimLeave", {
	pattern = "*",
	callback = function()
		vim.opt.guicursor = vim.opt.guicursor + { "a:ver25-blink100" }
	end,
})

-- Statusline
cmd({ "WinEnter", "BufEnter" }, {
	pattern = "*",
	callback = function()
		vim.o.statusline = "%!luaeval('Statusline.active()')"
	end,
})

cmd({ "WinLeave", "BufLeave" }, {
	pattern = "*",
	callback = function()
		vim.o.statusline = "%!luaeval('Statusline.inactive()')"
	end,
})

cmd({ "WinEnter", "BufEnter", "FileType" }, {
	pattern = "NvimTree_1",
	callback = function()
		vim.o.statusline = "%!luaeval('Statusline.short()')"
	end,
})
