-- Statusline highlight
local macchiato = require("catppuccin.palettes").get_palette("macchiato")

vim.cmd("hi StatusLineAccent guifg=" .. macchiato.surface0 .. " guibg=" .. macchiato.mauve)
vim.cmd("hi StatuslineInsertAccent guifg=" .. macchiato.surface0 .. " guibg=" .. macchiato.green)
vim.cmd("hi StatuslineVisualAccent guifg=" .. macchiato.surface0 .. " guibg=" .. macchiato.red)
vim.cmd("hi StatuslineReplaceAccent guifg=" .. macchiato.surface0 .. " guibg=" .. macchiato.blue)
vim.cmd("hi StatuslineTerminalAccent guifg=" .. macchiato.surface0 .. " guibg=" .. macchiato.yellow)
vim.cmd("hi StatuslineCmdLineAccent guifg=" .. macchiato.surface0 .. " guibg=" .. macchiato.peach)

local function update_mode_colors()
  local current_mode = vim.api.nvim_get_mode().mode
  local mode_color = "%#StatusLineAccent#"
  if current_mode == "n" then
    mode_color = "%#StatuslineAccent#"
  elseif current_mode == "i" or current_mode == "ic" then
    mode_color = "%#StatuslineInsertAccent#"
  elseif current_mode == "v" or current_mode == "V" or current_mode == "" then
    mode_color = "%#StatuslineVisualAccent#"
  elseif current_mode == "R" then
    mode_color = "%#StatuslineReplaceAccent#"
  elseif current_mode == "c" then
    mode_color = "%#StatuslineCmdLineAccent#"
  elseif current_mode == "t" then
    mode_color = "%#StatuslineTerminalAccent#"
  end
  return mode_color
end

local modes = {
  ["n"] = "NORMAL",
  ["no"] = "NORMAL",
  ["v"] = "VISUAL",
  ["V"] = "VISUAL LINE",
  [""] = "VISUAL BLOCK",
  ["s"] = "SELECT",
  ["S"] = "SELECT LINE",
  [""] = "SELECT BLOCK",
  ["i"] = "INSERT",
  ["ic"] = "INSERT",
  ["R"] = "REPLACE",
  ["Rv"] = "VISUAL REPLACE",
  ["c"] = "COMMAND",
  ["cv"] = "VIM EX",
  ["ce"] = "EX",
  ["r"] = "PROMPT",
  ["rm"] = "MOAR",
  ["r?"] = "CONFIRM",
  ["!"] = "SHELL",
  ["t"] = "TERMINAL",
}

local function mode()
  local current_mode = vim.api.nvim_get_mode().mode
  return string.format(" %s ", modes[current_mode]):upper()
end

local function filename()
  local fname = vim.fn.expand("%:t")
  if fname == "" then
    return ""
  end
  return fname .. " "
end

local vcs = function()
  local git_info = vim.b.gitsigns_status_dict
  if not git_info or git_info.head == "" then
    return ""
  end
  local added = git_info.added and (" " .. git_info.added .. " ") or ""
  local changed = git_info.changed and (" " .. git_info.changed .. " ") or ""
  local removed = git_info.removed and (" " .. git_info.removed .. " ") or ""
  if git_info.added == 0 then
    added = ""
  end
  if git_info.changed == 0 then
    changed = ""
  end
  if git_info.removed == 0 then
    removed = ""
  end
  return table.concat({
    " " .. git_info.head,
    " ",
    added,
    changed,
    removed,
    " ",
  })
end

local function LSPActive()
  local names = {}
  for _, server in pairs(vim.lsp.buf_get_clients(0)) do
    table.insert(names, server.name)
  end
  if #names == 0 then
    return ""
  end
  if #names > 0 then
    return " [" .. table.concat(names, " ") .. "]"
  end
end

local function lsp()
  local count = {}
  local levels = {
    errors = "Error",
    warnings = "Warn",
    info = "Info",
    hints = "Hint",
  }

  for k, level in pairs(levels) do
    count[k] = vim.tbl_count(vim.diagnostic.get(0, { severity = level }))
  end

  local errors = ""
  local warnings = ""
  local hints = ""
  local info = ""

  if count["errors"] ~= 0 then
    errors = "  " .. count["errors"]
  end
  if count["warnings"] ~= 0 then
    warnings = "  " .. count["warnings"]
  end
  if count["hints"] ~= 0 then
    hints = "  " .. count["hints"]
  end
  if count["info"] ~= 0 then
    info = "  " .. count["info"]
  end

  return errors .. warnings .. hints .. info
end

local function filetype()
  return string.format(" %s ", vim.bo.filetype):upper()
end

local function lineinfo()
  if vim.bo.filetype == "alpha" then
    return ""
  end
  return " %P %l:%c "
end

Statusline = {}

function Statusline.active()
  local winwidth
  if vim.o.laststatus == 3 then
    winwidth = vim.o.columns
  else
    winwidth = vim.api.nvim_win_get_width(0)
  end
  if winwidth >= 85 then
    return table.concat({
      update_mode_colors(),
      mode(),
      "%#Normal# ",
      filename(),
      "%#Normal#",
      lsp(),
      "%#Normal#",
      "%=",
      LSPActive(),
      "%=",
      vcs(),
      filetype(),
      lineinfo(),
    })
  else
    return table.concat({
      update_mode_colors(),
      mode(),
      "%#Normal#",
      lsp(),
      "%=",
      -- vcs(),
      lineinfo(),
    })
  end
end

function Statusline.inactive()
  return " %F"
end

function Statusline.short()
  return "%#Normal#"
end

return Statusline
