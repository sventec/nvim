-- setting the colorscheme, and any settings related to colorscheme plugins

local cmd = vim.cmd
local g = vim.g

-- cmd([[colorscheme kanagawa]])
-- cmd[[colorscheme nightfox]]
-- cmd[[colorscheme ayu-mirage]]
-- cmd[[colorscheme catppuccin]]
-- cmd("colorscheme everforest")

local status_ok_base16, base16_colorscheme = pcall(require, "base16-colorscheme")
if not status_ok_base16 then
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
  base08 = "#e67e80",
  base09 = "#d699b6",
  base0A = "#83c092",
  base0B = "#a7c080",
  base0C = "#e69875",
  base0D = "#dbbc7f",
  base0E = "#7fbbb3",
  base0F = "#d699b6",
})

-- base16_colorscheme.setup({
--   base00 = "#2b3339",
--   base01 = "#323c41",
--   base02 = "#3a4248",
--   base03 = "#868d80",
--   base04 = "#d3c6aa",
--   base05 = "#d3c6aa",
--   base06 = "#e9e8d2",
--   base07 = "#fff9e8",
--   base08 = "#7fbbb3",
--   base09 = "#d699b6",
--   base0A = "#83c092",
--   base0B = "#dbbc7f",
--   base0C = "#e69875",
--   base0D = "#a7c080",
--   base0E = "#e67e80",
--   base0F = "#d699b6",
-- })

-- everforest colorscheme setup
-- g.everforest_enable_italic = 1
-- g.everforest_disable_italic_comment = 0

-- material colorscheme setup
-- g.material_style = "oceanic"

-- safely require material colorscheme
-- local status_ok_material, material = pcall(require, "material")
-- if not status_ok_material then
--   return
-- end
--
-- material.setup({
--   contrast = {
--     sidebars = true,
--     floating_windows = true,
--   },
--   italics = {
--     keywords = true,
--     functions = true,
--     comments = true,
--     strings = false,
--     variables = false,
--   },
--   contrast_filetypes = {
--     "terminal",
--     "packer",
--     "qf",
--   },
--   disable = {
--     borders = false,
--     eob_lines = true,
--   },
-- })
