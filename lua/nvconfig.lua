-- nvconfig, required by 'NvChad/base46'
-- adapted from https://github.com/NvChad/NvChad/blob/v2.5/lua/nvconfig.lua

local M = {}

M.ui = {
  ------------------------------- base46 -------------------------------------
  -- hl = highlights
  hl_add = {},
  hl_override = {},
  changed_themes = {},
  theme_toggle = { "everforest", "one_light" },
  theme = "everforest", -- default theme
  transparency = false,

  cmp = {
    icons = true,
    lspkind_text = true,
    style = "default", -- default/flat_light/flat_dark/atom/atom_colored
  },

  telescope = { style = "borderless" }, -- borderless / bordered

  ------------------------------- nvchad_ui modules -----------------------------
  statusline = {
    theme = "default", -- default/vscode/vscode_colored/minimal
    -- default/round/block/arrow separators work only for default statusline theme
    -- round and block will work for minimal theme only
    separator_style = "default",
    order = nil,
    modules = nil,
  },

  lsp = {
    signature = true,
    semantic_tokens = false,
  },
}

M.base46 = {
  integrations = {
    "blankline",
    "bufferline",
    "cmp",
    "codeactionmenu",
    "defaults",
    "devicons",
    "git",
    "lsp",
    "mason",
    "statusline",
    "notify",
    "nvimtree",
    "semantic_tokens",
    "syntax",
    "telescope",
    "todo",
    "treesitter",
    "trouble",
    "vim-illuminate",
    "whichkey",
  },
}

-- return vim.tbl_deep_extend("force", M, require "chadrc")
return M
