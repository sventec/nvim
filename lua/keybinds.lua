-- Custom keybinds

-- Helper functions for defining keybinds
local map = vim.api.nvim_set_keymap
local default_opts = { noremap = true, silent = true }

function nmap(key, command)
  map("n", key, command, default_opts)
end

-- set leader to space
map("", "<Space>", "<Nop>", default_opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- native keybinds

-- better window navigation
nmap("<C-h>", "<C-w>h")
nmap("<C-j>", "<C-w>j")
nmap("<C-k>", "<C-w>k")
nmap("<C-l>", "<C-w>l")

-- resize with arrows
nmap("<C-Up>", ":resize -2<CR>")
nmap("<C-Down>", ":resize +2<CR>")
nmap("<C-Left>", ":vertical resize -2<CR>")
nmap("<C-Right>", ":vertical resize +2<CR>")

-- navigate buffers
nmap("<S-l>", ":bnext<CR>")
nmap("<S-h>", ":bprevious<CR>")

-- move text up and down
nmap("<A-j>", "<Esc>:m .+1<CR>==gi")
nmap("<A-k>", "<Esc>:m .-2<CR>==gi")

-- stay in indent mode
map("v", "<", "<gv", default_opts)
map("v", ">", ">gv", default_opts)

-- move text up and down
map("v", "<A-j>", ":m .+1<CR>==", default_opts)
map("v", "<A-k>", ":m .-2<CR>==", default_opts)
map("v", "p", '"_dP', default_opts)

-- clear last search highlight
nmap("<C-_>", ":nohl<CR>")

-- navigate by visual line
nmap("j", "gj")
nmap("k", "gk")

-- exit input mode with jk or kj
map("i", "jk", "<ESC>", default_opts)
map("i", "kj", "<ESC>", default_opts)

-- convenient quitting
nmap("Q", ":wq<CR>")

-- copy (yank) whole file to system clipboard
-- bind included in whichkey.lua
-- nmap("<leader>G", 'gg"+yG')

-- copy (yank) to system clipboard
nmap("<leader>y", '"+y')
nmap("<leader>Y", '"+yg_')
nmap("<leader>yy", '"+yy')
map("v", "<leader>y", '"+y', default_opts)

-- paste from system clipboard
nmap("<leader>p", '"+p')
nmap("<leader>P", '"+P')
map("v", "<leader>p", '"+p', default_opts)
map("v", "<leader>P", '"+P', default_opts)

-- insert empty line without entering insert mode
nmap("<leader>o", "o<ESC>")
nmap("<leader>O", "O<ESC>")

-- sort block of text (paragraph)
-- conflicts currently
-- nmap("<leader>s", "Vip:sort<CR>")

-- surround current line with comment box (#)
-- conflicts currently
-- nmap("<leader>b", "I# <ESC>A #<ESC>yyp<c-v>$r#yykP")

-- easier split navigation
nmap("C-J", "<C-w><C-j>")
nmap("C-K", "<C-w><C-k>")
nmap("C-L", "<C-w><C-l>")
nmap("C-h", "<C-w><C-h>")

-- easier buffer navigation
nmap("<leader>3", ":b#<CR>")
nmap("<leader>n", ":bn<CR>")
nmap("<leader>,", ":Buffers<CR>")

-- Align markdown tables?
-- nmap("<leader>gb", "gaip*<Bar>")

-- toggle comment on line
-- nmap("<leader>/", "<cmd>lua require('Comment.api').toggle_current_linewise()<CR>")

-- call formatting on file
-- nmap("<leader>F", "<cmd>lua vim.lsp.buf.formatting()<cr>")

-- call formatting on selection (visual mode)
-- map("v", "<leader>F", "<cmd>lua vim.lsp.buf.range_formatting()<cr>", default_opts)

-- lspconfig diagnostics keybinds
map("n", "<leader>ep", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", default_opts)
map("n", "<leader>en", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", default_opts)
