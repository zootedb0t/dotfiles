--  Telescope Keybindings
local builtin = require("telescope.builtin")
local map = vim.api.nvim_set_keymap

map("n", "<C-p>", "", {
  callback = builtin.find_files,
  desc = "Find files using telescope",
  noremap = true,
  silent = true,
})

map("n", "<C-f>", "", {
  callback = builtin.live_grep,
  desc = "Livegrep using telescope",
  noremap = true,
  silent = true,
})

map("n", "<C-b>", "", {
  callback = builtin.buffers,
  desc = "Search for buffer",
  noremap = true,
  silent = true,
})

map("n", "<Leader>ht", "", {
  callback = builtin.help_tags,
  desc = "Help tags using Telescope",
  noremap = true,
  silent = true,
})

map("n", "<Leader>of", "", {
  callback = builtin.oldfiles,
  desc = "Search for old files",
  noremap = true,
  silent = true,
})

-- map("n", "<Leader>fb", "", {
--   callback = function() require("configs.telescope").browse_files() end,
--   desc = "Browse Files",
--   noremap = true,
--   silent = true,
-- })

-- map("n", "<Leader>sc", "", {
--   callback = function() require("configs.telescope").search_config() end,
--   desc = "Nvim config files search",
--   noremap = true,
--   silent = true,
-- })

-- map("n", "<Leader>sf", "", {
--   callback = function() require("configs.telescope").search_file() end,
--   desc = "Search file in current directory",
--   noremap = true,
--   silent = true,
-- })

-- map("n", "<Leader>rp", "", {
--   callback = function() require("configs.telescope").search_repos() end,
--   desc = "Search my repos directory",
--   noremap = true,
--   silent = true,
-- })
