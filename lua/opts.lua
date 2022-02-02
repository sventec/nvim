-- Options for Neovim, configuration excluding plugins

-- Local aliases for easier assignment
local cmd = vim.cmd -- execute vim commands
local exec = vim.api.nvim_exec -- execute vimscript
local fn = vim.fn -- call vim functions
local g = vim.g -- global variables
local opt = vim.opt -- vim options

-- disable tilde on nonexistet lines in buffer
cmd [[let &fcs='eob: ']]

vim.g.python3_host_prog = '/usr/bin/python3'

-- g.mapleader = " " -- set leader key -- set in keybinds.lua
opt.timeoutlen = 100 -- how long to wait for sequence
opt.updatetime = 300 -- faster completion (4000ms default)

-- buffer between cursor and screen edge
opt.scrolloff = 8
opt.sidescrolloff = 8

opt.mouse = "a" -- enable mouse

opt.spelllang = "en"
-- opt.spell = true -- enable spelling globally

-- indent and tabs
opt.smarttab = true -- smarter tab
opt.smartindent = true -- indent new lines
opt.autoindent = true -- auto indent
opt.expandtab = true -- expand tab to spaces
opt.shiftwidth = 2 -- number of spaces per indent
-- g.softtabstop = 2
opt.tabstop = 2 -- one tab = 2 spaces

-- 2 space indent for listed filetypes
cmd([[
  autocmd FileType xml,css,scss,lua,yaml setlocal shiftwidth=2 tabstop=2
]])

-- don't auto comment new lines
-- credit brainfucksec/neovim-lua
cmd([[au BufEnter * set fo-=c fo-=r fo-=o]])

-- visuals
-- number + relativenumber = hybrid line numbers
opt.number = true
opt.relativenumber = true
opt.showmatch = true -- show matching parens
opt.colorcolumn = { "81", "89", "121" } -- vertical marker at columns 81, 89, 121
opt.splitright = true -- split vertically to the right
opt.splitbelow = true -- split horizontally to the bottom
opt.ignorecase = true -- ignore case in search
opt.smartcase = true -- ignore lowercase if whole pattern
opt.linebreak = true -- wrap on word boundaries
opt.cursorline = true -- highlight current line
opt.cmdheight = 2 -- set command line height
opt.hlsearch = true -- highlight all search matches
opt.showtabline = 2 -- always show tabline
opt.numberwidth = 4 -- set number column width to 2 (4 default)
opt.signcolumn = "yes" -- always show sign column, so text doesn't shift

-- power consumption tweaks
opt.hidden = true -- use background buffers
opt.history = 1000 -- remember 1000 lines in history
opt.lazyredraw = true -- speed up scrolling
opt.synmaxcol = 240 -- max number of columns in syntax highlighting

-- autocompletion options
completeopt = { "menuone", "noselect" } -- mostly just for cmp, completion options

-- colorscheme
opt.termguicolors = true
g.background = "dark"

-- etc. vimscript configuration

vim.opt.shortmess:append("c")

vim.cmd("set whichwrap+=<,>,[,],h,l")
vim.cmd([[set iskeyword+=-]]) -- words (such as diw) can contain dashes

-- To use nvchad/nvim-base16 version of everforest, etc.
local status_ok, base16 = pcall(require, "base16")
if not status_ok then
	return
end
base16(base16.themes("everforest"), true)

-- cmd[[colorscheme ayu-mirage]]
-- cmd[[colorscheme catppuccin]]
-- cmd("colorscheme everforest")
g.everforest_enable_italic = 1
g.everforest_disable_italic_comment = 0

-- material colorscheme setup
g.material_style = "oceanic"

-- save require material colorscheme
local status_ok_material, material = pcall(require, "material")
if not status_ok_material then
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
