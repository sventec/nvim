-- modifications to LazyVim default specs here
local python_line_length = "120" -- used by ruff_lsp & null-ls python sources
return {
  -- ==VISUAL== --
  -- disable animated indent scope context highlights
  { "echasnovski/mini.indentscope", enabled = false },
  -- add scope context highlighting to indent-blankline
  {
    "lukas-reineke/indent-blankline.nvim",
    opts = {
      show_current_context = true,
      -- show_current_context_start = true,
    },
  },
  -- remove lualine pointed arrow separators in favor of vertical lines
  {
    "nvim-lualine/lualine.nvim",
    opts = {
      options = {
        component_separators = { left = " ", right = " " },
        section_separators = { left = "", right = "" },
      },
      sections = {
        -- replacing right-most section (current time) with file info
        lualine_y = {
          "encoding",
          "filesize",
          "filetype",
        },
        lualine_z = {
          { "progress", separator = " ", padding = { left = 1, right = 0 } },
          { "location", padding = { left = 0, right = 1 } },
        },
      },
    },
  },
  {
    "akinsho/bufferline.nvim",
    opts = {
      options = {
        numbers = "ordinal",
      },
    },
  },
  -- auto install additional treesitter parsers
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "bash",
        "markdown",
        "markdown_inline",
        "python",
        "regex",
        "toml",
      },
      indent = {
        disable = {
          "python", -- use vim-python-pep8-indent for indents instead
        },
      },
    },
  },
  -- ==LSP/CODE== --
  -- modify LSP config
  {
    "neovim/nvim-lspconfig",
    opts = {
      autoformat = false, -- disable autoformat on save
      servers = {
        pyright = { -- auto install pyright with Mason
          settings = {
            python = {
              analysis = {
                -- typeCheckingMode = "basic",
                -- diagnosticMode = "workspace",
                inlayHints = {
                  variableTypes = true,
                  functionReturnTypes = true,
                },
              },
            },
          },
        },
        -- ruff_lsp = {
        --   init_options = {
        --     settings = {
        --       args = { "--line-length", python_line_length },
        --     },
        --   },
        -- },
      },
    },
  },
  -- add additional tools for Mason auto install
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "black",
        -- "ruff-lsp",
        "ruff",
        "reorder-python-imports",
        "yamllint",
      })
    end,
  },
  -- add additional null-ls sources
  {
    "jose-elias-alvarez/null-ls.nvim",
    opts = function(_, opts)
      local nls = require("null-ls")
      opts.sources = vim.list_extend(opts.sources, {
        -- python
        nls.builtins.diagnostics.ruff.with({ extra_args = { "--line-length", python_line_length } }),
        nls.builtins.formatting.reorder_python_imports,
        nls.builtins.formatting.black.with({ extra_args = { "--fast", "-l", python_line_length } }),
        nls.builtins.formatting.ruff.with({ extra_args = { "--line-length", python_line_length } }),
        -- ansible
        nls.builtins.diagnostics.ansiblelint,
        -- bash (shfmt already present in default source list)
        nls.builtins.diagnostics.shellcheck,
        -- markdown
        nls.builtins.diagnostics.markdownlint,
        -- yaml
        nls.builtins.diagnostics.yamllint,
      })
    end,
  },
}
