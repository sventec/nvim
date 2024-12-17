-- Python specific settings

-- Indent comments with < / >
vim.bo.cindent = true
vim.opt_local.cinkeys:remove("0#")

-- add buffer keymap for Ruff diagnostics docs picker (only in Python files)
-- FIXME: port picker to fzf-lua
-- vim.keymap.set(
--   "n",
--   "<leader>ce",
--   require("custom.ruff-picker").ruff_diagnostics_picker,
--   { desc = "Ruff Diagnostic Docs", buffer = true }
-- )
