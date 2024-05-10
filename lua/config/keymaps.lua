-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set

-- copy (yank) to system clipboard
map("n", "<leader>y", '"+y', { desc = "Copy to clipboard" })
map("n", "<leader>yy", '"+yy')
map("v", "<leader>y", '"+y', { desc = "Copy to clipboard", silent = true })

-- paste from system clipboard
map("n", "<leader>p", '"+p')
map("n", "<leader>P", '"+P')
map("v", "<leader>p", '"+p', { silent = true })
map("v", "<leader>P", '"+P', { silent = true })

-- underline current line with `-`/`=`
-- can also use `i<number>-<ESC>`
-- map("n", "<leader>cu", "yyp<c-v>$r-", { desc = "Underline line with -" })
-- map("n", "<leader>cU", "yyp<c-v>$r=", { desc = "Underline line with -" })
