return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  opts = {
    ensure_installed = {
      "c", "lua", "vim", "vimdoc", "elixir", "javascript", "html", "markdown", "python", "typescript"
    },
    sync_install = false,
    highlight = { enable = true },
    indent = { enable = true },
  },
  config = function(_, opts)
    require("nvim-treesitter").setup(opts)
  end
}
