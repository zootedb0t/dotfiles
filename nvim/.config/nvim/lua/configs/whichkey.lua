local M = {}

local status_ok1, key = pcall(require, "which-key")
local status_ok2, presets = pcall(require, "which-key.plugins.presets")
function M.config()
	if status_ok1 and status_ok2 then
		presets.operators["v"] = nil -- Disable which-key for visual mode
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
				height = { min = 4, max = 25 },
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
				b = { "<cmd>Telescope buffers<cr>", "Buffers" },
				c = { "<cmd>ColorizerToggle<cr>", "Attach colorizer" },
				d = { "<cmd>bd<cr>", "Delete buffer" },
				f = { vim.lsp.buf.format, "Format current buffer", silent = true },
				n = { "<cmd>enew<cr>", "Create new buffer" },
				r = { "<cmd>SourceFile<cr>", "Source current buffer" },
			},
			f = {
				name = "file",
				d = { "<cmd>ChangeDirectory<cr>", "Change working directory" },
				f = { "<cmd>Telescope find_files<cr>", "Find File" }, -- create a binding with label
				h = { "<cmd>Telescope oldfiles<cr>", "Open Recent File", noremap = false }, -- additional options for creating the keymap
			},
			l = {
			  name = "lsp",
        i = {"<cmd>LspInfo<cr>", "LSP status"},
        s = {"<cmd>LspStop<cr>", "Stop lsp"},
			},
			t = {
				name = "telescope finder",
				c = {
					function()
						require("configs.telescope.custom").search_config()
					end,
					"Neovim configs",
				},
				g = { "<cmd>Telescope live_grep<cr>", "Livegrep buffer" },
				h = { "<cmd>Telescope help_tags<cr>", "Help tags" },
			},
			p = {
				name = "packer",
				i = { "<cmd>PackerInstall<cr>", "Install plugins" },
				c = { "<cmd>PackerCompile<cr>", "Compile packer" },
				u = { "<cmd>PackerUpdate<cr>", "Update plugins" },
			},
		}, { prefix = "<leader>" })
	end
end

return M
