-- modifications to LazyVim default specs here
-- local python_line_length = "120" -- used by ruff_lsp & null-ls python sources

return {
  -- == Override LazyVim defaults== --
  {
    "LazyVim/LazyVim",
    opts = {
      icons = {
        dap = {
          Breakpoint = { "● ", "DapBreakpoint" },
          BreakpointCondition = { " ", "DapBreakpointCondition" },
          -- LogPoint = { "◆", "DapLogPoint" },
          LogPoint = { ".>", "DapLogPoint" },
        },
      },
      -- colorscheme set in colors.lua
      kind_filter = {
        -- filter for symbol types to show in e.g. aerial.nvim or outline.nvim
        -- see :help SymbolKind
        -- python = false, -- false to show all
        python = {
          "Class",
          "Constant",
          "Constructor",
          "Enum",
          "Field",
          "Function",
          "Interface",
          "Method",
          "Module",
          "Namespace",
          "Package",
          "Property",
          "Struct",
          "Trait",
        },
      },
    },
  },
  -- ==VISUAL== --
  -- remove lualine pointed arrow separators in favor of vertical lines
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      opts.options.component_separators = { left = " ", right = " " }
      opts.options.section_separators = { left = "", right = "" }

      local function current_venv()
        -- show currently activated python venv in lualine
        -- venv name provided by venv-selector.nvim
        local ok, venv_selector = pcall(require, "venv-selector")
        if not ok then
          return ""
        end

        local venv_name = venv_selector.venv()
        if venv_name then
          -- just return the venv name, e.g. '/home/fx/project/my_project/.venv' returns 'my_project'
          -- assumes venv folder in root of project, won't work for e.g. centralized poetry venvs
          -- this logic will be added in the event that I switch to another method of managing venvs
          local venv_parts = vim.fn.split(venv_name, "/")
          return " " .. venv_parts[#venv_parts - 1]
        else
          return ""
        end
      end

      -- stylua: ignore
      table.insert(opts.sections.lualine_x, {
        current_venv,
        -- ref: https://github.com/LazyVim/LazyVim/blob/9b8a393edc8b9a12a39f712163f6476c084a7f71/lua/lazyvim/plugins/ui.lua#L165
        cond = function() return package.loaded["venv-selector"] and require("venv-selector").venv() ~= nil end,
        color = function() return { ft = Snacks.util.color("String") } end,
      })

      opts.sections.lualine_y = {
        "encoding",
        "filesize",
        "filetype",
      }
      opts.sections.lualine_z = {
        { "progress", separator = " ", padding = { left = 1, right = 0 } },
        { "location", padding = { left = 0, right = 1 } },
      }
    end,
  },
  -- auto install additional treesitter parsers
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "bash",
        "lua",
        "markdown",
        "markdown_inline",
        "python",
        "regex",
        "toml",
      },
      indent = {
        disable = {
          "yaml", -- yaml list formatting kinda sucks
        },
      },
    },
  },
  -- move neo-tree to open on right
  -- {
  --   "nvim-neo-tree/neo-tree.nvim",
  --   opts = {
  --     window = {
  --       position = "right",
  --     },
  --   },
  -- },
  -- use classic cmdline instead of popup window
  {
    "folke/noice.nvim",
    opts = {
      cmdline = {
        view = "cmdline", -- or cmdline_popup
      },
      presets = {
        command_palette = false, -- floating tab completion w/ cmdline_popup
      },
      -- disable/hide "No information available" notification, from LSP hover
      -- allows for using both ruff (for noqa descriptions) and pyright hover providers without annoying popup
      routes = {
        {
          filter = {
            event = "notify",
            any = { { find = "No information available" } },
          },
        },
      },
    },
  },
  {
    "ibhagwan/fzf-lua",
    keys = {
      -- like existing <leader>ss keybind, without symbol kind filter
      {
        "<leader>sL",
        function()
          require("fzf-lua").lsp_document_symbols()
        end,
        desc = "Search All Symbols",
      },
      -- list all filetypes (select to switch buffer ft)
      { "<leader>sf", "<cmd>FzfLua filetypes<cr>", desc = "List All Filetypes" },
    },
  },
  -- change snacks.nvim config
  {
    "folke/snacks.nvim",
    ---@type snacks.Config
    opts = {
      -- animations disabled globally in options.lua with vim.g.snacks_animate
      scroll = {
        -- disable scrolling animations
        enabled = false,
      },
      -- indent = { chunk = { enabled = true } },
      -- dashboard = { example = "github" },
    },
  },
  -- ==LSP/CODE== --
  -- modify LSP config
  {
    "neovim/nvim-lspconfig",
    init = function()
      local keys = require("lazyvim.plugins.lsp.keymaps").get()
      -- change a keymap
      keys[#keys + 1] = { "gl", vim.diagnostic.open_float, desc = "Line Diagnostics" }
    end,
    opts = {
      -- NOTE: codelens and inlay_hints are Neovim >= 0.10.0 features
      codelens = {
        enabled = true,
      },
      inlay_hints = {
        enabled = true,
      },
      servers = {
        basedpyright = {
          settings = {
            basedpyright = {
              analysis = {
                inlayHints = {
                  variableTypes = true,
                  -- genericTypes = false, -- likely redundant with variableTypes
                },
                autoImportCompletions = true, -- offer auto-import completions
                autoSearchPaths = true,
                diagnosticMode = "openFilesOnly", -- "workspace"
                useLibraryCodeForTypes = true,
                -- https://detachhead.github.io/basedpyright/#/configuration?id=diagnostic-settings-defaults
                -- TLDR: change this for less strict checking (less errors)
                typeCheckingMode = "recommended", -- basedpyright default is "recommended", also "standard", "all", etc.
                diagnosticSeverityOverrides = {
                  -- https://detachhead.github.io/basedpyright/#/configuration?id=type-check-diagnostics-settings
                  -- one of: error, warning, information, true, false, none
                  reportMissingTypeStubs = "information", -- import has no type stub file
                  reportAny = false, -- bans all usage of 'Any' type
                  reportUnusedCallResult = false, -- call statements with return value that is not used (e.g. not _ = call())
                  reportMissingParameterType = false, -- function or method input parameters without type definition
                  -- reportOptionalMemberAccess = "warning",  -- access to member of object that has Optional[] type (e.g. obj.append() on Optional[list])
                  reportUnknownArgumentType = false, -- unknown (not statically typed/not inferrable) types
                  reportUnknownLambdaType = false,
                  reportUnknownMemberType = false,
                  reportUnknownParameterType = false,
                  reportUnknownVariableType = false,
                  -- include basedpyright-only options, even if "standard" is selected (defaults to only in "all")
                  -- https://detachhead.github.io/basedpyright/#/configuration?id=based-options
                  reportIgnoreCommentWithoutRule = "warning",
                  reportUnreachable = "error",
                  reportPrivateLocalImportUsage = "error",
                  reportImplicitRelativeImport = "error",
                  reportInvalidCast = "error",
                  reportMissingSuperCall = false,
                },
              },
            },
          },
        },
        -- NOTE: to enable pyright instead of basedpyright, change vim.g.lazyvim_python_lsp in options.lua
        pyright = { -- auto install pyright with Mason
          settings = {
            pyright = {
              autoImportCompletion = true,
            },
            python = {
              analysis = {
                autoSearchPaths = true,
                diagnosticMode = "openFilesOnly", -- "workspace"
                useLibraryCodeForTypes = true,
                -- typeCheckingMode = "basic", -- default is "standard"
              },
            },
          },
        },
        -- INFO: ruff vs. ruff_lsp is configured in config/options.lua as lazyvim_python_ruff
        -- set global config defaults in ~/.config/ruff/pyproject.toml
      },
      diagnostics = {
        underline = true,
        -- disable virtual_text for tiny-inline-diagnostic.nvim (handles inline display)
        virtual_text = false,
      },
      setup = {
        [vim.g.lazyvim_python_ruff or "ruff_lsp"] = function()
          LazyVim.lsp.on_attach(function(client, _)
            if client.name == (vim.g.lazyvim_python_ruff or "ruff_lsp") then
              -- LazyVim originally disables hover, to avoid "No information avaiable" notifications on pyright signature hovers:
              -- https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/plugins/extras/lang/python.lua#L62
              -- re-enabling it here to get hover for diagnostics (NOQA) codes, e.g. hover of "ANN001" provides docs
              -- "No information available" messages are suppressed in noice.nvim config opts
              client.server_capabilities.hoverProvider = true
            end
          end)
        end,
      },
    },
  },
  -- autocomplete menu
  {
    "Saghen/blink.cmp",
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    ---@diagnostic disable:missing-fields
    opts = {
      signature = { enabled = true },
      completion = {
        -- changes: enter auto-accept first entry to require manual selection
        -- list = {
        --   selection = "manual", -- "preselect" auto-selects first entry
        -- },
        menu = {
          draw = {
            columns = { { "label", "label_description", gap = 1 }, { "kind_icon", "kind" } },
          },
        },
        -- override LazyVim ghost text default
        -- ghost_text = {
        --   enabled = false,
        -- },
      },
      sources = {
        min_keyword_length = 2,
      },
    },
    ---@diagnostic enable:missing-fields
  },
  -- disable mini.pairs in favor of nvim-autopairs
  { "nvim-mini/mini.pairs", enabled = false },
  -- disable f/F/t/T motions for flash.nvim in favor of default motions
  {
    "folke/flash.nvim",
    opts = {
      modes = {
        char = {
          enabled = false,
          jump_labels = false,
        },
      },
      jump = {
        autojump = true, -- jump without label when only one match
      },
    },
    keys = {
      -- stylua: ignore
      -- override Treesitter search settings to show rainbow highlights
      -- makes it easier to visualize the Treesitter ranges
      { "S", mode = { "n", "o", "x" }, function() require("flash").treesitter({label = {rainbow = {enabled = true}}}) end, desc = "Flash Treesitter" },
    },
  },

  -- configure which-key display for keymaps set in config/keymaps.lua
  {
    "folke/which-key.nvim",
    opts = {
      spec = {
        mode = { "n", "v" },
        { "<leader>p", '"+p', desc = "Paste from clipboard", icon = { icon = "", color = "blue" } },
        { "<leader>P", '"+P', desc = "Paste from clipboard (behind)", hidden = true },
        { "<leader>y", '"+y', desc = "Copy to clipboard", icon = { icon = "", color = "blue" }, mode = "n" },
        -- stylua: ignore
        { "<leader>y", '"+y', desc = "Copy to clipboard", icon = { icon = "", color = "blue" }, mode = "v", silent = true },
        { "<leader>yy", '"+yy', desc = "Copy line to clipboard", mode = "v", hidden = true, silent = true },
      },
    },
  },
}
