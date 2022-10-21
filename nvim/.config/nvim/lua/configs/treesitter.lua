local status_ok, ts_config = pcall(require, "nvim-treesitter.configs")
if status_ok then
  ts_config.setup({
    ensure_installed = {
      "bash", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
      "c",
      "comment",
      "cmake",
      "cpp",
      "css",
      "go",
      "html",
      "javascript",
      "java",
      "jsdoc",
      "json",
      "latex",
      "bibtex",
      "lua",
      "php",
      "python",
      "ruby",
      "rust",
      "typescript",
      "yaml",
    },
    highlight = {
      enable = true, -- false will disable the whole extension
    },
  })
end
