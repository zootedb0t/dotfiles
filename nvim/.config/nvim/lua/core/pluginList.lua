vim.cmd({ cmd = "packadd", args = { "packer.nvim" } })

local packer_ok, packer = pcall(require, "packer")
if packer_ok then
  packer.init({
    display = {
      open_fn = function()
        return require("packer.util").float({ border = "single" })
      end,
    },
    git = {
      clone_timeout = 60, -- Timeout, in seconds, for git clones
    },
  })

  return packer.startup(function(use)
    -- Packer can manage itself
    use({ "wbthomason/packer.nvim" })

    -- Speeding up neovim (remove it when startup profiling #15436 is merged)
    use({ "lewis6991/impatient.nvim" })

    --LSP and stuff
    use({ "williamboman/mason.nvim" })

    use({ "williamboman/mason-lspconfig.nvim" })

    use({ "neovim/nvim-lspconfig" })

    use({
      "jose-elias-alvarez/null-ls.nvim",
      after = "nvim-lspconfig",
      config = function()
        require("configs.null-ls").config()
      end,
    })

    --LSP loading indicator
    use({
      "j-hui/fidget.nvim",
      config = function()
        require("fidget").setup()
      end,
    })

    --		use({
    --			"SmiteshP/nvim-navic",
    --			requires = "neovim/nvim-lspconfig",
    --		})

    -- Snippet collection
    use({
      "L3MON4D3/LuaSnip",
      requires = "rafamadriz/friendly-snippets",
      config = function()
        require("configs.luasnip").config()
      end,
    })

    -- Completion Engine
    use({
      "hrsh7th/nvim-cmp",
      -- event = "InsertEnter",
      config = function()
        require("configs.cmp").config()
      end,
    })

    -- Sources for Auto-completion
    use({ "hrsh7th/cmp-path", requires = "hrsh7th/nvim-cmp" })
    use({ "hrsh7th/cmp-buffer", requires = "hrsh7th/nvim-cmp" })
    use({ "hrsh7th/cmp-nvim-lsp", requires = "hrsh7th/nvim-cmp" })
    -- use({ "dcampos/cmp-snippy", require = "hrsh7th/nvim-cmp" })
    use({ "saadparwaiz1/cmp_luasnip" })

    use({
      "lewis6991/gitsigns.nvim",
      config = function()
        require("gitsigns").setup()
      end,
    })

    -- Handy auto-pairs
    use({
      "windwp/nvim-autopairs",
      config = function()
        require("configs.others").pair()
      end,
    })

    -- Treesitter for better syntax highlight
    use({
      "nvim-treesitter/nvim-treesitter",
      run = ":TSUpdate",
      event = { "BufRead", "BufNewFile" },
      opt = true,
      config = function()
        require("configs.treesitter")
      end,
    })

    -- Treesitter add-ons
    use({
      "p00f/nvim-ts-rainbow",
    })

    use({

      "windwp/nvim-ts-autotag",
    })

    -- Telescope for funzzy finding
    use({
      "nvim-telescope/telescope.nvim",
      -- event = "VimEnter",
      config = function()
        require("configs.telescope")
      end,
      requires = {
        { "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
        { "nvim-telescope/telescope-file-browser.nvim" },
      },
    })

    --COLORSCHEME

    -- [[Most Favorite]]
    -- use({
    --   "RRethy/nvim-base16",
    -- event = "UIEnter",
    -- config = function()
    --   vim.cmd({ cmd = "colorscheme", args = { "base16-dracula" } })
    -- vim.highlight.create("Normal", { ctermbg = "NONE", guibg = "NONE" }, false)
    -- vim.api.nvim_set_hl("SignColumn", { guibg = "NONE" }, false)
    -- vim.api.nvim_set_hl("LineNr", { guibg = "NONE" }, false)
    -- vim.api.nvim_set_hl("WinBar", { guibg = "NONE" }, false)
    --   end,
    -- })

    -- use({
    -- 	"dracula/vim",
    -- })

    -- use({
    -- 	"rebelot/kanagawa.nvim",
    -- })

    use({
      "catppuccin/nvim",
      as = "catppuccin",
    })

    use({
      "NvChad/nvim-colorizer.lua",
      cmd = "ColorizerToggle",
      config = function()
        require("colorizer").setup({
          user_default_options = {
            names = false,
          },
        })
      end,
    })

    -- For Comments
    use({
      "numToStr/Comment.nvim",
      keys = { "gc", "gb" },
      config = function()
        require("Comment").setup({
          ignore = "^$",
        })
      end,
    })

    -- File browser
    use({
      "nvim-tree/nvim-tree.lua",
      tag = "nightly", -- optional, updated every week. (see issue #1193)
      cmd = "NvimTreeFindFileToggle",
      config = function()
        require("configs.nvim-tree").config()
      end,
    })

    -- Fancy notification
    use({
      "rcarriga/nvim-notify",
      module = "notify",
      config = function()
        require("notify").setup()
      end,
    })

    -- For faster navigation
    use({
      "phaazon/hop.nvim",
      branch = "v2", -- optional but strongly recommended
      setup = function()
        vim.keymap.set("n", ",w", "<CMD>HopWord<CR>")
      end,
      cmd = "HopWord",
      config = function()
        require("configs.others").hop()
      end,
    })

    -- For better keymapping
    use({
      "folke/which-key.nvim",
      config = function()
        require("configs.whichkey").config()
      end,
    })

    -- Live Server
    use({
      "ray-x/web-tools.nvim",
      opt = true,
      config = function()
        require("configs.others").web_tools()
      end,
    })

    -- For markdown
    use({
      "toppair/peek.nvim",
      run = "deno task --quiet build:fast",
      ft = "markdown",
      config = function()
        require("configs.others").peek()
      end,
    })

    -- Better tabs
    use({
      "nanozuki/tabby.nvim",
      config = function()
        require("configs.tabby").config()
      end,
    })

    -- Modules
    use({ "nvim-lua/plenary.nvim", module = "plenary" })
    use({ "nvim-lua/popup.nvim", module = "popup" })
    use({ "kyazdani42/nvim-web-devicons", module = "nvim-web-devicons" })
  end)
end
