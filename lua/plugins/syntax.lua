-- formatting (code format, etc.)
return {
  -- automatically install tools using Mason
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        -- python
        -- "mypy", -- lint
        "basedpyright", -- lsp - https://detachhead.github.io/basedpyright/
        -- "pyright", -- lsp
        -- "reorder-python-imports", -- format
        "ruff", -- format, lint (includes LSP server)

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

        -- toml
        "taplo", -- lsp

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
        -- 'ruff_format' formatter is provided by 'ruff server' LSP instead
        -- 'ruff_fix' is available through "Fix All" LSP code action
        -- python = { "ruff_fix", "ruff_format" },
        sh = { "shfmt" },
        -- markdown formatting provided by 'marksman' LSP from lazyvim.plugins.extras.lang.markdown
        -- markdown = { "markdownlint" },
        hcl = { "packer_fmt" },
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
        markdown = { "markdownlint" }, -- "write_good"
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
      snippet_engine = "nvim",
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
  -- text objects for indent levels (select, move next)
  {
    "kiyoon/treesitter-indent-object.nvim",
    enabled = false, -- disable for now, full compatibility requires legacy indent-blankline v2
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
  -- syntax highlighting for .tridactylrc
  {
    "tridactyl/vim-tridactyl",
    ft = "tridactyl",
  },
  -- automatic new list bullet on <C-Enter> in markdown and plaintext
  {
    "gaoDean/autolist.nvim",
    ft = {
      "markdown",
      "text",
    },
    config = function()
      require("autolist").setup()

      -- NOTE: keymaps are not defined in LazyVim `keys` table so the plugin isn't loaded outside markdown and text files
      vim.keymap.set("i", "<tab>", "<cmd>AutolistTab<cr>")
      vim.keymap.set("i", "<s-tab>", "<cmd>AutolistShiftTab<cr>")
      -- Ctrl-Enter in insert mode to bullet new line (doesn't mess with cmp completion)
      vim.keymap.set("i", "<NL>", "<cr><cmd>AutolistNewBullet<cr>")
      vim.keymap.set("n", "o", "o<cmd>AutolistNewBullet<cr>")
      vim.keymap.set("n", "O", "O<cmd>AutolistNewBulletBefore<cr>")
      vim.keymap.set("n", "<cr>", "<cmd>AutolistToggleCheckbox<cr><cr>")
      vim.keymap.set("n", "<C-r>", "<cmd>AutolistRecalculate<cr>")

      -- cycle list types with dot-repeat
      vim.keymap.set("n", "<leader>cn", require("autolist").cycle_next_dr, { expr = true })
      vim.keymap.set("n", "<leader>cp", require("autolist").cycle_prev_dr, { expr = true })

      -- functions to recalculate list on edit
      vim.keymap.set("n", ">>", ">><cmd>AutolistRecalculate<cr>")
      vim.keymap.set("n", "<<", "<<<cmd>AutolistRecalculate<cr>")
      vim.keymap.set("n", "dd", "dd<cmd>AutolistRecalculate<cr>")
      vim.keymap.set("v", "d", "d<cmd>AutolistRecalculate<cr>")
    end,
  },
}
