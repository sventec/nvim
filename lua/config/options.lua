-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
local opt = vim.opt
local cmd = vim.cmd

-- ==behavior== --
opt.clipboard = "" -- do NOT use system clipboard (unnamedplus), the default LazyVim behavior

-- ==visual== --
opt.linebreak = true -- wrap on word boundaries
opt.colorcolumn = { "81", "89", "121" } -- vertical marker at columns 81, 89, 121

-- ==misc. QOL== --
cmd([[set cindent cinkeys-=0#]]) -- indenting with > and < also indents comments

-- don't auto comment new lines (e.g. via o/O)
-- credit brainfucksec/neovim-lua
cmd([[au BufEnter * set fo-=c fo-=r fo-=o]])
