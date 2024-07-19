-- plugins that affect neovim visuals
return {
  -- only display colorcolumn(s) when column count exceeded, otherwise hide
  {
    "m4xshen/smartcolumn.nvim",
    opts = {
      colorcolumn = { "80", "88", "120" },
      disabled_filetypes = { "alpha", "help", "dashboard", "neo-tree", "Trouble", "lazy", "mason" },
      custom_colorcolumn = { -- column overrides for specific languages
        text = "80",
        markdown = "120",
        python = { "88", "120" },
      },
      scope = "file", -- file, window, line
    },
  },
  -- add hints for unique chars on line for f/F/t/T
  {
    "jinh0/eyeliner.nvim",
    event = "VeryLazy",
    opts = {
      highlight_on_key = true,
      dim = true,
    },
  },
  -- show explanation for regex under cursor
  {
    "bennypowers/nvim-regexplainer",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "MunifTanjim/nui.nvim",
    },
    -- stylua: ignore
    keys = {
      { "gR", function() require("regexplainer").toggle() end, desc = "Toggle Regexplainer", },
    },
    opts = {
      filetypes = { "js", "python", "text" },
    },
  },
  -- conditionally enable bufferline catppuccin integration
  {
    "akinsho/bufferline.nvim",
    optional = true,
    opts = function(_, opts)
      if vim.g.lazyvim_colorscheme == "catppuccin" then
        opts = vim.tbl_deep_extend(
          "force",
          opts,
          { highlights = require("catppuccin.groups.integrations.bufferline").get() }
        )
      end
    end,
  },
  -- change bottom highlight character for headlines.nvim
  {
    "lukas-reineke/headlines.nvim",
    opts = {
      markdown = {
        -- fat_headline_lower_string = "▔",
        fat_headline_lower_string = "▀",
      },
    },
  },
  --- shows a symbol outline sidebar on <leader>cs (installed via extra)
  {
    "hedyhli/outline.nvim",
    optional = true, -- only apply if already installed via extra
    opts = {
      outline_items = {
        show_symbol_lineno = true,
      },
      -- symbol_folding = {
      --   autofold_depth = 2, -- default 1
      -- },
    },
  },
  -- reworked diagnostic virtual text display, only show for current line
  {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "VeryLazy",
    config = function()
      require("tiny-inline-diagnostic").setup()
    end,
    opts = {
      options = {
        -- Throttle the update of the diagnostic when moving cursor, in milliseconds.
        -- You can increase it if you have performance issues.
        -- Or set it to 0 to have better visuals.
        -- throttle = 20, -- default 20
        -- show all diags under cursor, instead of most important
        multiple_diag_under_cursor = true,
      },
    },
  },
}
