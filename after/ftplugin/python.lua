-- Python specific settings

-- Indent comments with < / >
vim.bo.cindent = true
vim.opt_local.cinkeys:remove("0#")

-- conditional custom ruff picker by global picker setting
local picker
if vim.g.lazyvim_picker == "fzf" then
  picker = require("custom.ruff-picker-fzf").ruff_diagnostics_picker
else
  picker = require("custom.ruff-picker").ruff_diagnostics_picker
end

-- add buffer keymap for Ruff diagnostics docs picker (only in Python files)
-- FIXME: port picker to fzf-lua
vim.keymap.set(
  "n",
  "<leader>ce",
  picker,
  { desc = "Ruff Diagnostic Docs", buffer = true }
)
