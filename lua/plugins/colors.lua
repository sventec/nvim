-- colorscheme installation, confguration
return {
  -- set colorscheme
  {
    "LazyVim/LazyVim",
    opts = {
      -- colorscheme = "catppuccin",
      colorscheme = vim.g.lazyvim_colorscheme, -- set this in options.lua
    },
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
        alpha = false, -- using dashboard-nvim
        blink_cmp = true,
        dap = true,
        dap_ui = true,
        dashboard = true,
        flash = true,
        fzf = true,
        gitsigns = true,
        headlines = true,
        lsp_trouble = true,
        mason = true,
        lsp_styles = {
          underlines = {
            errors = { "undercurl" },
            hints = { "undercurl" },
            warnings = { "undercurl" },
            information = { "undercurl" },
          },
        },
        neotree = true,
        noice = true,
        notify = true,
        nvimtree = false, -- using neo-tree.nvim
        snacks = true,
        symbols_outline = true, -- also the outline.nvim integration
        octo = true,
        -- telescope = { enabled = true, style = "nvchad" },
        treesitter_context = true,
        which_key = true,
      },
    },
    -- stylua: ignore
    keys = { { "<leader>uC", LazyVim.pick("colorscheme", { enable_preview = true }), desc = "Colorscheme with Preview" } },
  },
}
