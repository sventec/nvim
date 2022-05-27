-- config for symbols-outline, LSP symbols in sidebar

vim.g.symbols_outline = {
  highlight_hovered_item = true,
  show_guides = true,
  auto_preview = false,
  position = "right",
  width = 12,
  show_numbers = false,
  show_relative_numbers = false,
  show_symbol_details = false,
  keymaps = {
    close = { "q" },
    goto_location = "<Cr>",
    focus_location = "o",
    hover_symbol = "<C-space>",
    toggle_preview = "K",
    rename_symbol = "r",
    code_actions = "a",
  },
  lsp_blacklist = {},
  symbol_blacklist = {},
}
