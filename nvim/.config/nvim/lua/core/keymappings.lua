local map = vim.keymap.set
local opt = { silent = true }

-- Alternate way to save and exit
map("n", "<C-s>", "<CMD>w<CR>", { desc = "Save File" }, opt)
map("n", "<C-x>", "<CMD>wq!<CR>", { desc = "Save and Quit" }, opt)

map("n", "<ESC>", "<CMD>noh<CR>", opt) -- Remove highlights from search result

map("n", "<M-x>", "<CMD>bd!<CR>", { desc = "Delete Buffer" }, opt)

-- map("n", "<BS>", "<C-^>zz", { desc = "Jump to last Buffer" }, opt) -- Jump to last buffer

-- Remove annoying exmode
map("n", "Q", "<Nop>", opt)
map("n", "q:", "<Nop>", opt)

-- Remap for dealing with word wrap
map("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
map("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

map("n", "H", "^", { desc = "Goto Beginning of line" }, opt)
map("n", "L", "$", { desc = "Goto End of line" }, opt)

-- resizing splits
--map("n", "<C-Up>", function() require("smart-splits").resize_up() end, { desc = "Resize split Up" })

--map("n", "<C-Down>", function() require("smart-splits").resize_down() end, { desc = "Resize split Down" })

--map("n", "<C-Left>", function() require("smart-splits").resize_left() end, { desc = "Resize split Left" })

--map("n", "<C-Right>", function() require("smart-splits").resize_right() end, { desc = "Resize split Right" })

-- Better Window Navigation
map("n", "<C-j>", "<C-w>j", opt)
map("n", "<C-k>", "<C-w>k", opt)
map("n", "<C-l>", "<C-w>l", opt)
map("n", "<C-h>", "<C-w>h", opt)

--map("n", "<leader>pl", ":PackerLoad ", { desc = "Load Plugin" }, { silent = false }) -- For Packer

-- better indenting
map("v", "<", "<gv", { desc = "Indent Left" }, opt)
map("v", ">", ">gv", { desc = "Indent Right" }, opt)

-- Replace selected text without yanking it
map("v", "p", '"_dP', { desc = "Paste without yanking" }, opt)

-- Move line(s) up and down
map("n", "<M-j>", ":m .+1<CR>==", { desc = "Move current line down" }, opt)
map("n", "<M-k>", ":m .-2<CR>==", { desc = "Move current line below" }, opt)

-- Move selected line / block of text in visual mode
map("x", "K", ":move '<-2<CR>gv-gv", opt)
map("x", "J", ":move '>+1<CR>gv-gv", opt)

-- Prevent typo when pressing `wq` or `q`
vim.cmd([[
cnoreabbrev <expr> W ((getcmdtype() is# ':' && getcmdline() is# 'W')?('w'):('W'))
cnoreabbrev <expr> Q ((getcmdtype() is# ':' && getcmdline() is# 'Q')?('q'):('Q'))
cnoreabbrev <expr> WQ ((getcmdtype() is# ':' && getcmdline() is# 'WQ')?('wq'):('WQ'))
cnoreabbrev <expr> Wq ((getcmdtype() is# ':' && getcmdline() is# 'Wq')?('wq'):('Wq'))
]])

-- Tabline
-- map("n", "<Leader>tn", "<CMD>tabnew<CR>", { desc = "New Tab" })
-- map("n", "<Leader>tc", "<CMD>tabclose<CR>", { desc = "Change Tab Name" })

-- Source Lua file
vim.api.nvim_create_user_command("SourceFile", function()
	vim.cmd([[luafile %]])
	require("notify")("File Reloaded 勒勒")
end, { desc = "Source Current Buffer" })

map("n", "<Leader>rl", "<CMD>SourceFile<CR>", { desc = "Source current file" }, opt)

-- Change directory
vim.api.nvim_create_user_command("ChangeDirectory", function()
	vim.cmd([[lcd%:p:h]])
	require("notify")("Directory changed  ﱮ ")
end, { desc = "Command to change directory" })

map("n", "<Leader>cd", "<CMD>ChangeDirectory<CR>", { desc = "Change directory" }, opt)

-- For Nvim-tree
map("n", "<Leader>t", "<CMD>NvimTreeFindFileToggle<CR>", { desc = "Focus on current file" }, opt)

-- Attach colorizer
map("n", "<Leader>ct", "<CMD>ColorizerToggle<CR>", { desc = "Attach colorizer to buffer" })
