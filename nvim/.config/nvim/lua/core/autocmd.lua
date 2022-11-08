local cmd = vim.api.nvim_create_autocmd

-- Highlight on yank
cmd("TextYankPost", {
  callback = function() vim.highlight.on_yank({ higroup = "IncSearch", timeout = 200, on_visual = true }) end,
  pattern = "*",
})

cmd("ColorScheme",{
pattern = "*",
callback = function ()
  vim.api.nvim_set_hl(0,"LineNr",{ cterm = bold, bold = true})
end,
}
)

-- vim.cmd
-- [[
--     augroup change_cursor
--         au!
--         au ExitPre * :set guicursor=a:ver90
--     augroup END
-- ]]
