local M = {}

local status_ok, key = pcall(require, "which-key")
function M.config()
	if status_ok then
		key.setup({
			window = {
				border = "shadow",
				margin = { 1, 0, 1, 0 },
				padding = { 2, 2, 2, 2 },
				winblend = 0,
			},
			presets = {
				operators = false,
				motions = false,
				text_objects = false,
				windows = false,
				nav = false,
				z = false,
				g = false,
			},
			layout = {
				-- height = { min = 4, max = 25 },
				width = { min = 20, max = 50 },
				spacing = 3,
				align = "left",
			},
			ignore_missing = true,
			show_help = false,
		})
		key.register({
			e = { "<cmd>NvimTreeFindFileToggle<cr>", "Toggle file explore" },
			b = {
				name = "buffer",
				b = {"<cmd>Telescope buffers", "Buffers"},
				c = { "<cmd>ColorizerToggle<cr>", "Attach colorizer" },
				f = { vim.lsp.buf.format, "Format current buffer", silent = true },
				n = { "<cmd>enew<cr>", "Create new buffer" },
				r = { "<cmd>SourceFile<cr>", "Source current buffer" },
			},
			f = {
				name = "file",
				f = { "<cmd>Telescope find_files<cr>", "Find File" }, -- create a binding with label
				h = { "<cmd>Telescope oldfiles<cr>", "Open Recent File", noremap = false }, -- additional options for creating the keymap
				t = { "<cmd>NvimTreeFindFileToggle<cr>", "Open file explore" },
			},
			-- l = {
			--   name = "lsp",
			-- },
			t = {
			  name = "telescope finder",
			  c = {function ()
			    require("configs.telescope.custom").search_config()
			  end, "Neovim configs"},
			  g = {"<cmd>Telescope live_grep<cr>", "Livegrep buffer"},
			  h = {"<cmd>Telescope help_tags<cr>", "Help tags"},
			},
		}, { prefix = "<leader>" })
	end
end

return M
