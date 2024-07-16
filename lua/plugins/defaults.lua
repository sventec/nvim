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
        -- filter for symbol types to show in e.g. aerial.nvim
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

      local function codestats_xp()
        -- show codestats.net current xp in lualine
        local ok, codestats = pcall(require, "codestats")
        if not ok then
          return ""
        end

        local xp = codestats.current_xp()
        if xp == 0 then
          -- don't show segment if xp is 0
          return ""
        else
          return "CS::" .. tostring(xp)
        end
      end

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
        color = function() return LazyVim.ui.fg("String") end,
      })

      opts.sections.lualine_y = {
        codestats_xp,
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
      -- indent = {
      --   disable = {
      --     "python", -- use vim-python-pep8-indent for indents instead
      --   },
      -- },
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
  -- add additional Telescope keybinds
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      -- stylua: ignore
      {
        -- Telescope lsp document symbols keybind
        -- example: can be used with marksman LSP to search & jump to .md file heading
        "<leader>sL",
        function()
          require("telescope.builtin").lsp_document_symbols()
        end,
        desc = "Search All Symbols",
      },
      {
        -- Telescope lsp references under cursor keybind
        -- See all references to lsp symbol under cursor
        "<leader>sl",
        function()
          require("telescope.builtin").lsp_references()
        end,
        desc = "Symbol Under Cursor References",
      },
      {
        -- Telescope filetypes keybind
        -- List all filetypes (select to switch buffer ft)
        "<leader>sf",
        function()
          require("telescope.builtin").filetypes()
        end,
        desc = "List All Filetypes",
      },
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
      -- codelens = {
      --   enabled = true,
      -- },
      inlay_hints = {
        enabled = true,
      },
      servers = {
        basedpyright = { -- pyright but based. manually install off PyPI
          settings = {
            basedpyright = {
              analysis = {
                autoImportCompletions = true, -- offer auto-import completions
                autoSearchPaths = true,
                diagnosticMode = "openFilesOnly", -- "workspace"
                useLibraryCodeForTypes = true,
                -- https://detachhead.github.io/basedpyright/#/configuration?id=diagnostic-settings-defaults
                -- TLDR: change this for less strict checking (less errors)
                -- typeCheckingMode = "standard", -- basedpyright default is "all"
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
        -- virtual_text = false,
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
  {
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
      -- only show completions after typing 2 characters
      -- show completion sooner with <C-Space>
      opts.completion.keyword_length = 2

      -- filetypes for which brackets should be added to function completion
      -- https://github.com/LazyVim/LazyVim/blob/main/CHANGELOG.md#10200-2024-03-28
      opts.auto_brackets = opts.auto_brackets or {}
      vim.list_extend(opts.auto_brackets, { "python" })

      -- sort entries beginning with '_' lower than (after) others, for Python
      -- credit: https://github.com/lukas-reineke/cmp-under-comparator
      local compare_under = function(entry1, entry2)
        local _, entry1_under = entry1.completion_item.label:find("^_+")
        local _, entry2_under = entry2.completion_item.label:find("^_+")
        entry1_under = entry1_under or 0
        entry2_under = entry2_under or 0
        if entry1_under > entry2_under then
          return false
        elseif entry1_under < entry2_under then
          return true
        end
      end
      -- extend existing comparators, ref:
      -- https://github.com/LazyVim/LazyVim/blob/1432f318b6b061d3da510ebd795a3292b10e636b/lua/lazyvim/plugins/extras/lang/clangd.lua#L99
      table.insert(opts.sorting.comparators, 1, compare_under)
    end,
  },
  -- disable mini.pairs in favor of nvim-autopairs
  { "echasnovski/mini.pairs", enabled = false },
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
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      on_attach = function(buffer)
        -- Reference from https://github.com/LazyVim/LazyVim/blob/f9dadc11b39fb0b027473caaab2200b35c9f0c8b/lua/lazyvim/plugins/editor.lua#L332C7-L353C1
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, desc)
          vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
        end

        -- stylua: ignore start
        map("n", "]h", gs.next_hunk, "Next Hunk")
        map("n", "[h", gs.prev_hunk, "Prev Hunk")
        map({ "n", "v" }, "<leader>ghs", ":Gitsigns stage_hunk<CR>", "Stage Hunk")
        map({ "n", "v" }, "<leader>ghr", ":Gitsigns reset_hunk<CR>", "Reset Hunk")
        map("n", "<leader>ghS", gs.stage_buffer, "Stage Buffer")
        map("n", "<leader>ghu", gs.undo_stage_hunk, "Undo Stage Hunk")
        map("n", "<leader>ghR", gs.reset_buffer, "Reset Buffer")
        map("n", "<leader>ghp", gs.preview_hunk, "Preview Hunk")
        map("n", "<leader>ghb", function() gs.blame_line() end, "Blame Line")  -- Changed keybind
        map("n", "<leader>ghB", function() gs.blame_line({ full = true }) end, "Blame Line With Preview")  -- Added keybind
        map("n", "<leader>ghd", gs.diffthis, "Diff This")
        map("n", "<leader>ghD", function() gs.diffthis("~") end, "Diff This ~")
        map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
      end,
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
        { "<leader>y", '"+y', desc = "Copy to clipboard", icon = { icon = "", color = "blue" } },
        { "<leader>yy", '"+yy', desc = "Copy line to clipboard", mode = "v", hidden = true },
      },
    },
  },
}
