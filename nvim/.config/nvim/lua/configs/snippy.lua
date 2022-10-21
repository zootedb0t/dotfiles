local M = {}

function M.config()
  local present, snippy = pcall(require, "snippy")
  if present then
    snippy.setup({
      -- mappings = {
      --   is = {
      --     ["<Tab>"] = "expand_or_advance",
      --     ["<S-Tab>"] = "previous",
      --   },
      --   nx = {
      --     ["<leader>x"] = "cut_text",
      --   },
      -- },
    })
  end
end

return M
