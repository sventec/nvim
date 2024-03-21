-- colorscheme installation, confguration
local Util = require("lazyvim.util")
return {
  -- nvchad base46 extracted
  {
    "NvChad/base46",
    branch = "v2.5",
    build = function()
      require("base46").load_all_highlights()
    end,
    -- opts = function(_, opts)
    --   -- vim.g.base46_cache = vim.fn.stdpath("data") .. "/nvchad/base46/"
    --   dofile(vim.g.base46_cache .. "defaults")
    --   -- dofile(vim.g.base46_cache .. "telescope")
    --   dofile(vim.g.base46_cache .. "telescope")
    -- end,
  },
  -- set colorscheme
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = function()
        -- just load them all immediately for now..
        -- can be added to individual plugin configs later
        dofile(vim.g.base46_cache .. "defaults")
        dofile(vim.g.base46_cache .. "blankline")
        dofile(vim.g.base46_cache .. "bufferline")
        dofile(vim.g.base46_cache .. "cmp")
        dofile(vim.g.base46_cache .. "codeactionmenu")
        dofile(vim.g.base46_cache .. "devicons")
        dofile(vim.g.base46_cache .. "git")
        dofile(vim.g.base46_cache .. "lsp")
        dofile(vim.g.base46_cache .. "mason")
        dofile(vim.g.base46_cache .. "notify")
        dofile(vim.g.base46_cache .. "nvimtree")
        dofile(vim.g.base46_cache .. "semantic_tokens")
        dofile(vim.g.base46_cache .. "statusline")
        dofile(vim.g.base46_cache .. "syntax")
        dofile(vim.g.base46_cache .. "telescope")
        dofile(vim.g.base46_cache .. "todo")
        dofile(vim.g.base46_cache .. "treesitter")
        dofile(vim.g.base46_cache .. "trouble")
        -- dofile(vim.g.base46_cache .. "vim-illuminate")
        dofile(vim.g.base46_cache .. "whichkey")
      end,
      -- colorscheme = "everforest",
      -- colorscheme = "zenwritten",
      -- colorscheme = "catppuccin",
    },
  },
  -- colorscheme: everforest
  { "sainnhe/everforest" },
  {
    "mcchrish/zenbones.nvim",
    lazy = true,
    dependencies = {
      "rktjmp/lush.nvim",
    },
    -- stylua: ignore
    keys = { { "<leader>uC", Util.telescope("colorscheme", { enable_preview = true }), desc = "Colorscheme with preview" } },
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = true,
    opts = {
      flavour = "macchiato", -- latte, frappe, macchiato, mocha
      show_end_of_buffer = false, -- ~ chars at EOB
      integrations = {
        cmp = true,
        flash = true,
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
        neotree = true,
        noice = true,
        notify = true,
        telescope = true,
        treesitter = true,
        which_key = true,
      },
    },
    -- stylua: ignore
    keys = { { "<leader>uC", Util.telescope("colorscheme", { enable_preview = true }), desc = "Colorscheme with preview" } },
  },
  {
    "rebelot/kanagawa.nvim",
    lazy = true,
    -- stylua: ignore
    keys = { { "<leader>uC", Util.telescope("colorscheme", { enable_preview = true }), desc = "Colorscheme with preview" } },
  },
  {
    "Shatur/neovim-ayu",
    lazy = true,
    -- stylua: ignore
    keys = { { "<leader>uC", Util.telescope("colorscheme", { enable_preview = true }), desc = "Colorscheme with preview" } },
    config = function()
      require("ayu").setup({
        mirage = true,
      })
    end,
  },
}
