local status_ok, telescope = pcall(require, "telescope")
if not status_ok then return end

-- Telescope
require("configs.telescope.mappings")
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

-- my telescope custamization
local M = {}

function M.search_config()
  builtin.find_files({
    prompt_title = " Search Config Files ",
    prompt_prefix = "   ",
    cwd = "~/.config/nvim",
  })
end

function M.search_file()
  builtin.find_files({
    prompt_title = " Search Files ",
    prompt_prefix = "  ",
    find_command = { "rg", "--no-ignore", "--files" },
    cwd = "~",
  })
end

-- function M.search_repos()
--   require("telescope").extensions.file_browser.file_browser({
--     prompt_title = "Search Repos",
--     prompt_prefix = "  ",
--     cwd = "~/repos/",
--   })
-- end

-- function M.browse_files()
--   require("telescope").extensions.file_browser.file_browser({
--     prompt_title = "Search Workspace",
--     cwd_to_path = true,
--   })
-- end

return M
