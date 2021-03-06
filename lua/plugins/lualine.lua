-- lualine config

local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
  return
end

-- nvim-gps shows current symbol context in statusline
-- local status_ok_gps, gps = pcall(require, "nvim-gps")
-- if not status_ok_gps then
--   return
-- end
-- gps.setup()

local diagnostics = {
  "diagnostics",
  sources = { "nvim_diagnostic" },
  sections = { "error", "warn" },
  symbols = { error = " ", warn = " " },
  colored = false,
  update_in_insert = false,
  always_visible = true,
}

-- cool function for progress
local progress = function()
  local current_line = vim.fn.line(".")
  local total_lines = vim.fn.line("$")
  local chars = { "__", "▁▁", "▂▂", "▃▃", "▄▄", "▅▅", "▆▆", "▇▇", "██" }
  local line_ratio = current_line / total_lines
  local index = math.ceil(line_ratio * #chars)
  return chars[index]
end

lualine.setup({
  options = {
    icons_enabled = true,
    -- theme = "everforest",
    theme = "auto",
    -- section_separators = { left = "", right = "" },
    -- component_separators = { left = "", right = "" },
    -- component_separators = { left = "\\", right = "/" },
    component_separators = { left = " ", right = " " },
    section_separators = { left = "", right = "" },
    disabled_filetypes = { "alpha", "dashboard", "NvimTree", "Outline" },
    always_divide_middle = true,
    globalstatus = true,
  },
  sections = {
    lualine_a = {},
    lualine_b = { diagnostics, "mode" },
    lualine_c = {
      "branch",
      "diff",
      "filename",
      -- { gps.get_location, cond = gps.is_available },
    },
    lualine_x = {
      "encoding",
      "filesize",
      "filetype",
    },
    lualine_y = { "location", progress },
    lualine_z = {},
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { "filename" },
    lualine_x = { "location" },
    lualine_y = {},
    lualine_z = {},
  },
})
