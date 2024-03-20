-- formatting (code format, etc.)
return {
  -- automatically install tools using Mason
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        -- python
        "mypy", -- lint
        "pyright", -- lsp
        -- "reorder-python-imports", -- format
        "ruff", -- format (lint provided by ruff-lsp)
        "ruff-lsp", -- lsp

        -- lua
        "lua-language-server", -- lsp
        "stylua", -- format

        -- sh
        -- "bash-language-server", -- lsp
        "shellcheck", -- lint
        "shfmt", -- format

        -- ansible
        -- "ansible-language-server", -- lsp
        -- "ansible-lint", -- lint, required for ansible-language-server

        -- yaml
        "yamllint",
        -- "yaml-language-server",

        -- markdown
        -- "marksman", -- lsp
        "markdownlint", -- format, lint

        -- misc
        -- prettier provided by lazyvim.plugins.extras.formatting.prettier
        -- "prettierd", -- json/html/css/etc. formatting
        "gh", -- github cli tool, for octo.nvim
      })
    end,
  },
  -- replacement for null-ls, code formatters
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        -- 'ruff_format' formatter is provided by 'ruff_lsp' LSP instead
        -- 'ruff_fix' is available through "Fix All" LSP code action
        -- python = { "ruff_fix", "ruff_format" },
        sh = { "shfmt" },
        -- -- markdown formatting provided by 'marksman' LSP from lazyvim.plugins.extras.lang.markdown
        -- markdown = { "markdownlint" },
        -- ["*"] is used on all filetypes
        ["*"] = { "trim_whitespace" },
        -- ["_"] is used as fallback formatter for langs not listed above
        -- ["_"] = { "trim_whitespace" },
        -- ["_"] = { { "prettierd", "prettier" } }, -- nested list uses only first available from list
        fish = {}, -- remove default LazyVim linter
      },
      -- formatter options, custom formatters
      -- formatters = {},
    },
  },
  -- replacement for null-ls, linters
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters_by_ft = {
        -- python = { "mypy" }, -- ruff-lsp and pyright handle lint messages via LSP
        sh = { "shellcheck" },
        yaml = { "yamllint" },
        markdown = { "markdownlint" },
      },
      -- customize linter args (lazyvim feature)
      linters = {
        markdownlint = {
          args = {
            "-r ~MD013,~MD024,~MD025,~MD041",
          },
        },
        --   mypy = {
        --     args = {
        --       -- defaults: https://github.com/mfussenegger/nvim-lint/blob/master/lua/lint/linters/mypy.lua
        --       "--show-column-numbers",
        --       "--show-error-end",
        --       "--hide-error-codes",
        --       "--hide-error-context",
        --       "--no-color-output",
        --       "--no-error-summary",
        --       "--no-pretty",
        --       -- custom
        --       "--ignore-missing-imports",
        --     },
        --   },
      },
    },
  },
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
  {
    "kiyoon/treesitter-indent-object.nvim",
    -- stylua: ignore
    keys = {
      {
        "ai",
        function() require("treesitter_indent_object.textobj").select_indent_outer() end,
        mode = { "x", "o" },
        desc = "Select context-aware indent (outer)",
      },
      {
        "aI",
        function() require("treesitter_indent_object.textobj").select_indent_outer(true) end,
        mode = { "x", "o" },
        desc = "Select context-aware indent (outer, line-wise)",
      },
      {
        "ii",
        function() require("treesitter_indent_object.textobj").select_indent_inner() end,
        mode = { "x", "o" },
        desc = "Select context-aware indent (inner, partial range)",
      },
      {
        "iI",
        function() require("treesitter_indent_object.textobj").select_indent_inner(true, "V") end,
        mode = { "x", "o" },
        desc = "Select context-aware indent (inner, entire range) in line-wise visual mode",
      },
    },
  },
}
