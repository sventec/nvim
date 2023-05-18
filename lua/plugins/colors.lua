-- colorscheme installation, confguration
return {
  -- set colorscheme
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "everforest",
      -- colorscheme = "zenwritten",
      -- colorscheme = "catppuccin-macchiato",
      -- colorscheme = "catppuccin-frappe",
    },
  },
  -- colorscheme: everforest
  { "sainnhe/everforest" },
  {
    "mcchrish/zenbones.nvim",
    dependencies = {
      "rktjmp/lush.nvim",
    },
    lazy = true,
  },
  { "catppuccin/nvim", name = "catppuccin", lazy = true },
}
