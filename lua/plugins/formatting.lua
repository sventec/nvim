-- formatting (code format, etc.)
return {
  -- replacement for null-ls, code formatters
  -- {
  --   "stevearc/conform.nvim",
  --   opts = {
  --     -- formatter options, custom formatters
  --     -- formatters = {},
  --     formatters_by_ft = {
  --       python = {""}
  --     },
  --   },
  -- },
  { "vimjas/vim-python-pep8-indent", enabled = false },
  -- bracket pairs, replacing built-in mini.pairs
  {
    "windwp/nvim-autopairs",
    event = "VeryLazy",
    opts = {
      disable_filetype = { "TelescopePrompt", "spectre_panel", "vim" },
      fast_wrap = {
        map = "<M-e>",
        chars = { "{", "[", "(", '"', "'" },
        pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
        offset = 0, -- Offset from pattern match
        end_key = "$",
        keys = "qwertyuiopzxcvbnmasdfghjkl",
        check_comma = true,
        highlight = "PmenuSel",
        highlight_grey = "LineNr",
      },
    },
  },
  -- autogenerate docstrings from code
  {
    "danymat/neogen",
    dependencies = "nvim-treesitter/nvim-treesitter",
    -- stylua: ignore
    keys = { { "<leader>cD", function() require("neogen").generate({}) end, desc = "Generate Docstring", } },
    opts = {
      enabled = true,
      snippet_engine = "luasnip",
      languages = {
        python = {
          template = {
            -- google_docstrings, numpydoc, or reST
            annotation_convention = "google_docstrings",
          },
        },
      },
    },
  },
}
