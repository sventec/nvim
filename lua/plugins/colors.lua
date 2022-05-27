-- setting the colorscheme, and any settings related to colorscheme plugins
local M = {}

local cmd = vim.cmd
local g = vim.g

M.base = function()
  -- a colorscheme that doesn't require configuration can be set here
  -- this is sourced after plugin load

  -- cmd([[colorscheme kanagawa]])
  -- cmd[[colorscheme nightfox]]
  -- cmd[[colorscheme ayu-mirage]]
  -- cmd[[colorscheme catppuccin]]
  -- cmd("colorscheme everforest")

  -- everforest colorscheme setup
  -- g.everforest_enable_italic = 1
  -- g.everforest_disable_italic_comment = 0
end

M.base16 = function()
  local status_ok, base16_colorscheme = pcall(require, "base16-colorscheme")
  if not status_ok then
    return
  end

  base16_colorscheme.with_config({
    telescope = true, -- This can be made false to use the standard Telescope style
  })

  -- base16 colors from NvChad's version of everforest
  -- See here for built-in colorschemes: https://github.com/RRethy/nvim-base16
  base16_colorscheme.setup({
    base00 = "#2b3339",
    base01 = "#323c41",
    base02 = "#3a4248",
    base03 = "#868d80",
    base04 = "#d3c6aa",
    base05 = "#d3c6aa",
    base06 = "#e9e8d2",
    base07 = "#fff9e8",
    base08 = "#7fbbb3",
    base09 = "#d699b6",
    base0A = "#83c092",
    base0B = "#dbbc7f",
    base0C = "#e69875",
    base0D = "#a7c080",
    base0E = "#e67e80",
    base0F = "#d699b6",
  })
end

M.nightfox = function()
  local status_ok, nightfox = pcall(require, "nightfox")
  if not status_ok then
    return
  end

  nightfox.setup({
    options = {
      terminal_colors = true, -- Set terminal colors (vim.g.terminal_color_*) used in `:terminal`
      dim_inactive = false, -- Non focused panes set to alternative background
      styles = {
        comments = "italic", -- Value is any valid attr-list value `:help attr-list`
        conditionals = "bold",
        constants = "bold",
        functions = "NONE",
        keywords = "bold",
        numbers = "NONE",
        operators = "NONE",
        strings = "NONE",
        types = "NONE",
        variables = "NONE",
      },
      inverse = { -- Inverse highlight for different types
        match_paren = false,
        visual = false,
        search = false,
      },
      modules = {
        cmp = true,
        diagnostic = true,
        gitsigns = true,
        lsp_trouble = true,
        nvimtree = true,
        telescope = true,
        treesitter = true,
        tsrainbow = true,
        whichkey = true,
      },
    },
  })
end

M.material = function()
  g.material_style = "oceanic"

  local status_ok, material = pcall(require, "material")
  if not status_ok then
    return
  end

  material.setup({
    contrast = {
      sidebars = true,
      floating_windows = true,
    },
    italics = {
      keywords = true,
      functions = true,
      comments = true,
      strings = false,
      variables = false,
    },
    contrast_filetypes = {
      "terminal",
      "packer",
      "qf",
    },
    disable = {
      borders = false,
      eob_lines = true,
    },
  })
end

M.catppuccin = function()
  local status_ok, catppuccin = pcall(require, "catppuccin")
  if not status_ok then
    return
  end

  catppuccin.setup({
    integrations = {
      bufferline = true,
      cmp = true,
      dashboard = true,
      gitgutter = true,
      gitsigns = true,
      indent_blankline = { enabled = true },
      lsp_trouble = true,
      markdown = true,
      symbols_outline = true,
      telescope = true,
      treesitter = true,
      ts_rainbow = true,
      vimtree = { enabled = true },
      which_key = true,
    },
  })
end

return M
