-- hop.nvim config

vim.api.nvim_set_keymap("n", "f", "<cmd>lua require'hop'.hint_char1()<cr>", { noremap = true })
vim.api.nvim_set_keymap("v", "f", "<cmd>lua require'hop'.hint_char1()<cr>", { noremap = true })
-- vim.api.nvim_set_keymap(
-- 	"n",
-- 	"F",
-- 	"<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR })<cr>",
-- 	{ noremap = true }
-- )

vim.api.nvim_set_keymap("n", "<C-f>", "<cmd>lua require'hop'.hint_char2()<cr>", { noremap = true })
vim.api.nvim_set_keymap("v", "<C-f>", "<cmd>lua require'hop'.hint_char2()<cr>", { noremap = true })
-- vim.api.nvim_set_keymap(
-- 	"n",
-- 	"<C-F>",
-- 	"<cmd>lua require'hop'.hint_char2({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR })<cr>",
-- 	{ noremap = true }
-- )
