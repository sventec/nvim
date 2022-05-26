-- Options for Neovim, configuration excluding plugins

-- Local aliases for easier assignment
local cmd = vim.cmd -- execute vim commands
local exec = vim.api.nvim_exec -- execute vimscript
local fn = vim.fn -- call vim functions
local g = vim.g -- global variables
local opt = vim.opt -- vim options

-- disable tilde on nonexistet lines in buffer
-- cmd([[let &fcs='eob: ']])
opt.fillchars = { eob = " " }

-- g.python3_host_prog = "/usr/bin/python3"

-- load filetypes using filetype.nvim instead of built-in
g.did_load_filetypes = 0
g.do_filetype_lua = 1

-- base behavior
-- opt.mapleader = " "
opt.confirm = true -- show confirmation on e.g. quitting w/o saving
opt.title = true -- update window title with filename
opt.timeoutlen = 400 -- how long to wait for sequence
opt.updatetime = 250 -- faster completion (4000ms default)
opt.mouse = "a" -- enable mouse
opt.undofile = true -- persistent undo history across file loads

-- buffer between cursor and screen edge (scroll before cursor on edge)
opt.scrolloff = 8
opt.sidescrolloff = 8

opt.spelllang = "en"
-- opt.spell = true -- enable spell checking globally

-- indent and tabs
opt.smarttab = true -- smarter tab
opt.smartindent = true -- indent new lines
opt.autoindent = true -- auto indent
opt.expandtab = true -- expand tab to spaces
opt.shiftwidth = 2 -- number of spaces per indent
opt.tabstop = 2 -- one tab = 2 spaces
cmd([[set cindent cinkeys-=0#]]) -- indenting with > and < also indents comments

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
opt.laststatus = 3 -- global statusline (across windows)
opt.showmatch = true -- show matching parens
opt.colorcolumn = { "81", "89", "121" } -- vertical marker at columns 81, 89, 121
opt.splitright = true -- split vertically to the right
opt.splitbelow = true -- split horizontally to the bottom
opt.ignorecase = true -- ignore case in search
opt.smartcase = true -- ignore lowercase if whole pattern
opt.linebreak = true -- wrap on word boundaries
opt.cursorline = true -- highlight current line
-- opt.cmdheight = 1 -- set command line height
opt.cmdheight = 2 -- set command line height
opt.hlsearch = true -- highlight all search matches
opt.showtabline = 2 -- always show tabline
opt.numberwidth = 2 -- set number column width to 2 (4 default)
opt.signcolumn = "yes" -- always show sign column, so text doesn't shift

-- folding
opt.foldenable = false
vim.wo.foldmethod = "marker"
-- vim.wo.foldmethod = "expr"
-- opt.foldexpr = "nvim_treesitter#foldexpr()"
opt.foldlevel = 99

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

opt.shortmess:append("c")

vim.cmd("set whichwrap+=<,>,[,],h,l")
vim.cmd([[set iskeyword+=-]]) -- words (such as diw) can contain dashes

-- disable (likely) unused builtin vim plugins
local default_plugins = {
  "2html_plugin",
  "getscript",
  "getscriptPlugin",
  "gzip",
  "logipat",
  "netrw",
  "netrwPlugin",
  "netrwSettings",
  "netrwFileHandlers",
  "matchit",
  "tar",
  "tarPlugin",
  "rrhelper",
  "spellfile_plugin",
  "vimball",
  "vimballPlugin",
  "zip",
  "zipPlugin",
}

for _, plugin in pairs(default_plugins) do
  g["loaded_" .. plugin] = 1
end

vim.schedule(function()
  vim.opt.shadafile = vim.fn.stdpath("data") .. "/shada/main.shada"
  vim.cmd([[ silent! rsh ]])
end)
