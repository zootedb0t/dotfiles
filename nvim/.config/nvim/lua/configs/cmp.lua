local M = {}

function M.config()
  local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
  end

  --   פּ ﯟ   some other good icons
  local cmp_status_ok, cmp = pcall(require, "cmp")
  local snip_status_ok, snippy = pcall(require, "snippy")
  local autopair_ok, autopair = pcall(require, "nvim-autopairs.completion.cmp")
  if cmp_status_ok and snip_status_ok then
    -- local kind_icons = {
    --   Text = "",
    --   Method = "",
    --   Function = "",
    --   Constructor = "",
    --   Field = "ﰠ",
    --   Variable = "",
    --   Interface = "",
    --   Class = "ﴯ",
    --   Module = "",
    --   Property = "ﰠ",
    --   Unit = "塞",
    --   Enum = "",
    --   Value = "",
    --   Keyword = "",
    --   Snippet = "",
    --   Color = "",
    --   File = "",
    --   Reference = "",
    --   Folder = "",
    --   EnumMember = "",
    --   Constant = "",
    --   Struct = "פּ",
    --   Event = "",
    --   Operator = "",
    --   TypeParameter = "",

    -- These icons work in patched font
    -- Text = "",
    -- Method = "",
    -- Function = "",
    -- Constructor = "",
    -- Field = "",
    -- Variable = "",
    -- Class = "",
    -- Interface = "",
    -- Module = "",
    -- Property = "",
    -- Unit = "",
    -- Value = "",
    -- Enum = "",
    -- Keyword = "",
    -- Snippet = "",
    -- Color = "",
    -- File = "",
    -- Reference = "",
    -- Folder = "",
    -- EnumMember = "",
    -- Constant = "",
    -- Struct = "",
    -- Event = "",
    -- Operator = "",
    -- TypeParameter = "",
    -- }

    cmp.setup({
      -- preselect = cmp.PreselectMode.None,
      formatting = {
        fields = { "menu", "abbr", "kind" },
        format = function(entry, item)
          local menu_icon = {
            nvim_lsp = "λ",
            snippy = "⋗",
            buffer = "Ω",
            path = "🖫",
          }

          item.menu = menu_icon[entry.source.name]
          return item
        end,
      },

      snippet = {
        expand = function(args) snippy.expand_snippet(args.body) end,
      },

      -- duplicates = {
      --   nvim_lsp = 1,
      --   snippy = 1,
      --   buffer = 1,
      --   path = 1,
      -- },

      cmp = {
        source_priortiy = {
          nvim_lsp = 1000,
          snippy = 500,
          buffer = 250,
          path = 200,
        },
      },

      mapping = {
        ["<Up>"] = cmp.mapping.select_prev_item(),
        ["<Down>"] = cmp.mapping.select_next_item(),
        ["<C-k>"] = cmp.mapping.select_prev_item(),
        ["<C-j>"] = cmp.mapping.select_next_item(),
        ["<C-d>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        -- ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.abort(),

        ["<CR>"] = cmp.mapping.confirm({ select = false }),
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif snippy.can_expand_or_advance() then
            snippy.expand_or_advance()
          elseif has_words_before() then
            cmp.complete()
          else
            fallback()
          end
        end, {
          "i",
          "s",
        }),

        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif snippy.can_jump(-1) then
            snippy.previous()
          else
            fallback()
          end
        end, {
          "i",
          "s",
        }),
      },

      sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "snippy" },
        { name = "path" },
        { name = "nvim_lsp_signature_help" },
        { name = "buffer", keyword_length = 2 },
      }),

      -- view = {
      --   entries = "native",
      -- },

      window = {
        completion = cmp.config.window.bordered({
          -- col_offset = 2,
          side_padding = 1,
          border = {
            "┌",
            "─",
            "┐",
            "│",
            "┘",
            "─",
            "└",
            "│",
          },
        }),
        documentation = cmp.config.window.bordered({
          border = {
            "┌",
            "─",
            "┐",
            "│",
            "┘",
            "─",
            "└",
            "│",
          },
        }),
      },
    })
  end
  if autopair_ok then cmp.event:on("confirm_done", autopair.on_confirm_done({ map_char = { tex = "" } })) end
end

return M
