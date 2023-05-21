-- colorscheme installation, confguration
return {
  -- set colorscheme
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "everforest",
      -- colorscheme = "zenwritten",
      -- colorscheme = "catppuccin",
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
  {
    "catppuccin/nvim",
    name = "catppuccin",
    -- lazy = true,
    opts = {
      flavour = "macchiato", -- latte, frappe, macchiato, mocha
      show_end_of_buffer = false, -- ~ chars at EOB
      integrations = {
        alpha = true,
        cmp = true,
        gitsigns = true,
        illuminate = true,
        indent_blankline = {
          enabled = true,
          colored_indent_levels = false,
        },
        leap = true,
        lsp_trouble = true,
        markdown = true,
        mason = true,
        native_lsp = {
          enabled = true,
        },
        navic = {
          enabled = true,
        },
        neotree = true,
        noice = true,
        notify = true,
        telescope = true,
        treesitter = true,
        which_key = true,
      },
    },
  },
  { "rebelot/kanagawa.nvim", lazy = true },
  {
    "Shatur/neovim-ayu",
    lazy = true,
    config = function()
      require("ayu").setup({
        mirage = true,
      })
    end,
  },
}
