local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
	return
end

-- Telescope
local actions = require("telescope.actions")
local builtin = require("telescope.builtin")

telescope.setup({
	defaults = {
		prompt_prefix = "  ",
		selection_caret = "> ",
		color_devicons = true,
		sorting_strategy = "ascending",
		vimgrep_arguments = {
			"rg",
			"--color=never",
			"--no-heading",
			"--with-filename",
			"--line-number",
			"--column",
			"--smart-case",
		},
		layout_config = {
			width = 0.75,
			height = 0.65,
			prompt_position = "top",
			horizontal = {
				preview_width = function(_, cols, _)
					if cols > 200 then
						return math.floor(cols * 0.4)
					else
						return math.floor(cols * 0.6)
					end
				end,
			},
			vertical = { width = 0.9, height = 0.95, preview_height = 0.5 },
			flex = { horizontal = { preview_width = 0.9 } },
		},
		mappings = {
			i = {
				["<C-j>"] = actions.move_selection_next,
				["<C-k>"] = actions.move_selection_previous,
				["<C-d>"] = actions.delete_buffer,
				["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
				["<CR>"] = actions.select_default,
			},
			n = {
				["<C-j>"] = actions.move_selection_next,
				["<C-k>"] = actions.move_selection_previous,
				["<C-d>"] = actions.delete_buffer,
				["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
			},
		},
	},
	pickers = {
		find_files = {
			theme = "dropdown",
		},
	},
	extensions = {
		fzf = {
			fuzzy = true, -- false will only do exact matching
			override_generic_sorter = false, -- override the generic sorter
			override_file_sorter = true, -- override the file sorter
			case_mode = "smart_case", -- or "ignore_case" or "respect_case"
		},
		file_browser = {
			theme = "ivy",
			hijack_netrw = true,
		},
	},
})

-- Extensions for telescope
require("telescope").load_extension("fzf")
require("telescope").load_extension("file_browser")

--  Telescope Keybindings
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

map("n", "<Leader>sc", "", {
	callback = function()
		require("configs.telescope.custom").search_config()
	end,
	desc = "Nvim config files",
	noremap = true,
	silent = true,
})

-- map("n", "<Leader>fb", "", {
--   callback = function() require("configs.telescope").browse_files() end,
--   desc = "Browse Files",
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
