return {
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
  opts = {},
  config = function()
    require("tokyonight").setup({
      style = "moon", -- storm | moon | night | day
      transparent = true, -- Background color
      terminal_colors = true, -- Configure when opening a `:terminal`
      styles = {
        comments = { italic = true },
        keywords = { italic = true },
        -- Bacground stles can be "dark", "transparent" or "normal"
        sidebars = "dark",
        floats = "dark",
      }
    })
    vim.cmd[[colorscheme tokyonight]]
  end
}
