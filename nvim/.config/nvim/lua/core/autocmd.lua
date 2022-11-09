local cmd = vim.api.nvim_create_autocmd

-- Highlight on yank
cmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank({ higroup = "IncSearch", timeout = 200, on_visual = true })
	end,
	pattern = "*",
})

cmd("ColorScheme", {
	pattern = "*",
	callback = function()
		-- vim.api.nvim_set_hl(0,"LineNr",{ cterm = bold, bold = true})
		vim.api.nvim_set_hl(0, "LineNr", { fg = "#f8f8f2" })
	end,
})

-- Fixing cursor
cmd("VimLeave",{
  pattern = "*",
  callback = function ()
    vim.opt.guicursor = vim.opt.guicursor + {"a:ver25-blink100"}
  end
})

-- Reload sxhkd after edit
cmd("BufWritePost", {
pattern = "sxhkdrc",
callback = function ()
  vim.cmd([[!killall sxhkd; setsid sxhkd &]])
end
})
