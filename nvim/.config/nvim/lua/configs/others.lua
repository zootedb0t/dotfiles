local M = {}

-- For autopairs
M.pair = function()
	local status_ok, pairs = pcall(require, "nvim-autopairs")
	if status_ok then
		pairs.setup({
			check_ts = true,
			disable_filetype = { "TelescopePrompt" },
			enable_check_bracket_line = false,
			ignored_next_char = "[%w%.]", -- will ignore alphanumeric and `.` symbol
		})
	end
end

M.hop = function()
	local status_ok, hop = pcall(require, "hop")
	if status_ok then
		hop.setup({
			keys = "etovxqpdygfblzhckisuran",
		})
	end
end

return M
