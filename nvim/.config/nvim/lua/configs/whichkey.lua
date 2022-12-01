local M = {}

local status_ok1, key = pcall(require, "which-key")
local status_ok2, presets = pcall(require, "which-key.plugins.presets")
function M.config()
	if status_ok1 and status_ok2 then
		presets.operators["v"] = nil -- Disable which-key for visual mode
		presets.operators["d"] = nil -- Disable which-key for delete mode
		presets.operators["y"] = nil -- Disable which-key for yank mode
		key.setup({
			window = {
				border = "none",
				margin = { 1, 1, 1, 1 },
				padding = { 1, 1, 1, 1 },
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
				width = { min = 20, max = 30 },
				spacing = 3,
				align = "center",
			},
			ignore_missing = true,
			show_help = false,
		})
		key.register({
			e = { "<cmd>NvimTreeFindFileToggle<cr>", "Toggle file explore" },
			d = { "<cmd>ChangeDirectory<cr>", "Change working directory" },
			b = {
				name = "buffer",
				b = { "<cmd>Telescope buffers<cr>", "Buffers" },
				c = { "<cmd>ColorizerToggle<cr>", "Attach colorizer" },
				d = { "<cmd>bd<cr>", "Delete buffer" },
				f = { vim.lsp.buf.format, "Format current buffer", silent = true },
				n = { "<cmd>enew<cr>", "Create new buffer" },
				r = { "<cmd>SourceFile<cr>", "Source current buffer" },
			},
			l = {
				name = "+LSP",
				i = { "<cmd>LspInfo<cr>", "LSP status" },
				d = { vim.lsp.buf.definition, "Jump to definition" },
				D = { vim.lsp.buf.declaration, "Jump to declaration" },
				t = { vim.lsp.buf.type_definition, "Jump to type definition" },
				l = {
					name = "+Lists",
					d = { "<cmd>Telescope diagnostics<cr>", "Show diagnostic" },
					r = { "<Cmd>Telescope lsp_references<CR>", "References" },
					s = { "<cmd>Telescope lsp_document_symbols<cr>", "Show document symbol" },
				},
			},
			s = {
				name = "+Search",
				c = {
					function()
						require("configs.telescope.custom").search_config()
					end,
					"Neovim configs",
				},
				b = { "<cmd>Telescope file_browser<cr>", "Browse files" },
				h = { "<cmd>Telescope help_tags<cr>", "Help tags" },
				f = { "<Cmd>Telescope find_files<CR>", "Files in cwd" },
				F = { "<Cmd>Telescope find_files_workspace<CR>", "Files in workspace" },
				g = { "<Cmd>Telescope live_grep_workspace<CR>", "Grep in workspace" },
				G = { "<Cmd>Telescope live_grep<CR>", "Grep in cwd" },
				l = { "<Cmd>Telescope current_buffer_fuzzy_find<CR>", "Buffer lines" },
				o = { "<Cmd>Telescope oldfiles<CR>", "Old files" },
				t = { "<Cmd>Telescope builtin<CR>", "Telescope lists" },
				w = { "<Cmd>Telescope grep_string_workspace<CR>", "Grep word in workspace" },
				W = { "<Cmd>Telescope grep_string<CR>", "Grep word in cwd" },
			},
			p = {
				name = "packer",
				c = { "<cmd>PackerCompile<cr>", "Compile packer" },
				i = { "<cmd>PackerInstall<cr>", "Install plugins" },
				s = { "<cmd>PackerSync<cr>", "Sync Packer" },
				u = { "<cmd>PackerUpdate<cr>", "Update plugins" },
			},
			w = {
				name = "+Windows",
				-- Split creation
				s = { "<Cmd>split<CR>", "Split below" },
				v = { "<Cmd>vsplit<CR>", "Split right" },
				q = { "<Cmd>q<CR>", "Close" },
				o = { "<Cmd>only<CR>", "Close all other" },
			},
		}, { prefix = "<leader>" })
	end
end

return M
