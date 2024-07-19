-- colorscheme installation, confguration
return {
  -- set colorscheme
  {
    "LazyVim/LazyVim",
    opts = {
      -- colorscheme = "everforest",
      -- colorscheme = "zenwritten",
      -- colorscheme = "catppuccin",
      colorscheme = vim.g.lazyvim_colorscheme, -- set this in options.lua
    },
  },
  -- colorscheme: everforest
  -- { "sainnhe/everforest" },
  -- everforest lua port
  {
    "neanias/everforest-nvim",
    lazy = true,
    main = "everforest",
    opts = {
      -- background = "hard", -- default is "medium"
      italics = true,
      -- disable_italic_comments = true,
      -- ui_contrast = "low", -- "high"
      -- diagnostic_virtual_text = "grey", -- default is "coloured"
    },
    -- stylua: ignore
    keys = { { "<leader>uC", LazyVim.pick("colorscheme", { enable_preview = true }), desc = "Colorscheme with Preview" } },
  },
  {
    "mcchrish/zenbones.nvim",
    lazy = true,
    dependencies = {
      "rktjmp/lush.nvim",
    },
    -- stylua: ignore
    keys = { { "<leader>uC", LazyVim.pick("colorscheme", { enable_preview = true }), desc = "Colorscheme with Preview" } },
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = true,
    priority = 1000,
    opts = {
      flavour = "macchiato", -- latte, frappe, macchiato, mocha
      show_end_of_buffer = false, -- ~ chars at EOB
      integrations = {
        -- bufferline.nvim components set conditionally in visual.lua
        aerial = true, -- installed from aerial extra
        alpha = false, -- using dashboard-nvim
        cmp = true,
        dap = true,
        dap_ui = true,
        dashboard = true,
        flash = true,
        gitsigns = true,
        headlines = true,
        indent_blankline = { enabled = true, colored_indent_levels = false },
        lsp_trouble = true,
        markdown = true,
        mason = true,
        native_lsp = { enabled = true },
        neotree = true,
        noice = true,
        notify = true,
        nvimtree = false, -- using neo-tree.nvim
        semantic_tokens = true,
        octo = true,
        telescope = { enabled = true, style = "nvchad" },
        treesitter = true,
        treesitter_context = true,
        which_key = true,
      },
    },
    -- stylua: ignore
    keys = { { "<leader>uC", LazyVim.pick("colorscheme", { enable_preview = true }), desc = "Colorscheme with Preview" } },
  },
  {
    "rebelot/kanagawa.nvim",
    lazy = true,
    -- stylua: ignore
    keys = { { "<leader>uC", LazyVim.pick("colorscheme", { enable_preview = true }), desc = "Colorscheme with Preview" } },
  },
  {
    "Shatur/neovim-ayu",
    lazy = true,
    -- stylua: ignore
    keys = { { "<leader>uC", LazyVim.pick("colorscheme", { enable_preview = true }), desc = "Colorscheme with Preview" } },
    config = function()
      require("ayu").setup({
        mirage = true,
      })
    end,
  },
}
