-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
local opt = vim.opt
local cmd = vim.cmd

-- If installing the neovim python integration in an isolated environment,
-- provide the path to that here:
-- vim.g.python3_host_prog = "~/.nvim-venv/bin/python3"

-- ==lazyvim== --
-- set lazyvim.plugins.extras.lang.python to use basedpyright instead of pyright
-- TODO: refactor all Python configs to separate plugin file/module
vim.g.lazyvim_python_lsp = "basedpyright" -- or "pyright"
vim.g.lazyvim_python_ruff = "ruff" -- or "ruff_lsp"

-- custom: define desired colorscheme as global variable
-- used to set colorscheme (duh),
--   conditionally configure some plugin integrations for e.g. catppuccin,
--   and to configure defaults where a colorscheme is required
vim.g.lazyvim_colorscheme = "catppuccin"

-- show/hide deprecation warnings (lazyvim)
vim.g.deprecation_warnings = true

-- follow main branch of blink.cmp - requires cargo to build
vim.g.lazyvim_blink_main = true
-- use blink.cmp over nvim-cmp for completion (LazyVim default as of v14.0.0)
vim.g.lazyvim_cmp = "blink.cmp"

-- use fzf-lua over Telescope.nvim for pickers (LazyVim default as of v14.0.0)
vim.g.lazyvim_picker = "fzf"


-- ==plugins== --
-- vim-tmux-navigator
-- If the tmux window is zoomed, keep it zoomed when moving from Vim to another pane
vim.g.tmux_navigator_preserve_zoom = 1

-- snacks.nvim
-- disable animations globally
vim.g.snacks_animate = false


-- ==behavior== --
opt.clipboard = "" -- do NOT use system clipboard (unnamedplus), the default LazyVim behavior

-- disable format on save (works w/ LSP, format functions, etc. in LazyVim)
vim.g.autoformat = false

-- folding
-- opt.foldenable = false -- disable folding entirely
-- opt.foldmethod = "marker" -- use {{{ / }}} to mark folds
-- opt.foldlevelstart = 99 -- start buffer with all folds open (can be overriden by modeline etc.)


-- ==visual== --
opt.linebreak = true -- wrap on word boundaries
opt.colorcolumn = { "81", "89", "121" } -- vertical marker at columns 81, 89, 121
-- opt.signcolumn = "yes:2" -- display git gutter & diagnostics in separate columns, always visible
