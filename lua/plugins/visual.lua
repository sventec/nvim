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
  -- intelligent code folding, based on LSP
  -- has capability defined in nvim-lspconfig settings
  {
    "kevinhwang91/nvim-ufo",
    dependencies = "kevinhwang91/promise-async",
    event = "BufReadPost",
    opts = {},
    init = function()
      -- Using ufo provider need remap `zR` and `zM`.
      vim.keymap.set("n", "zR", function()
        require("ufo").openAllFolds()
      end)
      vim.keymap.set("n", "zM", function()
        require("ufo").closeAllFolds()
      end)
    end,
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
}
