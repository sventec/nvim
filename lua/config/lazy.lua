local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  -- bootstrap lazy.nvim
  -- stylua: ignore
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end
vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

require("lazy").setup({
  spec = {
    -- add LazyVim and import its plugins
    { "LazyVim/LazyVim", import = "lazyvim.plugins" },

    --- -- misc extras: util, ui, ... --
    { import = "lazyvim.plugins.extras.util.project" }, -- detect and switch projects
    { import = "lazyvim.plugins.extras.util.mini-hipatterns" }, -- highlight color codes
    { import = "lazyvim.plugins.extras.ui.treesitter-context" }, -- show scope context at top of screen
    { import = "lazyvim.plugins.extras.ui.edgy" }, -- predefined window/UI positions
    { import = "lazyvim.plugins.extras.editor.outline" }, -- code outline window (symbols-outline replacement)
    -- set vscode = true in plugin spec to load when embedded in vscode
    { import = "lazyvim.plugins.extras.vscode" }, -- load stripped set of plugins in vscode embedded nvim
    { import = "lazyvim.plugins.extras.editor.dial" }, -- increment/decrement/toggle numbers, dates, booleans, etc.
    { import = "lazyvim.plugins.extras.util.octo" }, -- <leader>g GitHub issue/PR management
    { import = "lazyvim.plugins.extras.editor.refactoring" }, -- <leader>r for smart refactoring options

    --- -- python extras (debug/test, LSP, etc.) --
    { import = "lazyvim.plugins.extras.lang.python" },

    --- -- additional (not python) languages --
    { import = "lazyvim.plugins.extras.lang.json" }, -- json treesitter, SchemaStore, ...
    { import = "lazyvim.plugins.extras.lang.toml" }, -- taplo (LSP), formatting
    { import = "lazyvim.plugins.extras.lang.yaml" }, -- yamlls, schemas, ...
    { import = "lazyvim.plugins.extras.lang.markdown" }, -- md live preview, syntax
    -- { import = "lazyvim.plugins.extras.lang.ansible" },
    -- { import = "lazyvim.plugins.extras.lang.docker" },
    { import = "lazyvim.plugins.extras.lang.go" },
    -- { import = "lazyvim.plugins.extras.lang.rust" },
    -- { import = "lazyvim.plugins.extras.lang.terraform" },

    --- -- other editing --
    -- use prettier extra to autoconfigure all supported filetypes with conform.nvim
    { import = "lazyvim.plugins.extras.formatting.prettier" },
    { import = "lazyvim.plugins.extras.dap.core" },
    -- motions for adding/editing/removing surrounding chars (like brackets) with `gs`
    { import = "lazyvim.plugins.extras.coding.mini-surround" },
    -- use <leader>cn to generate docstrings for a function, class, etc.
    -- further configuration in lua/plugins/syntax.lua
    { import = "lazyvim.plugins.extras.coding.neogen" },

    --- -- rest of custom plugin configuration --
    { import = "plugins" },
  },
  defaults = {
    -- By default, only LazyVim plugins will be lazy-loaded. Your custom plugins will load during startup.
    -- If you know what you're doing, you can set this to `true` to have all your custom plugins lazy-loaded by default.
    lazy = false,
    -- It's recommended to leave version=false for now, since a lot the plugin that support versioning,
    -- have outdated releases, which may break your Neovim install.
    version = false, -- always use the latest git commit
    -- version = "*", -- try installing the latest stable version for plugins that support semver
  },
  install = {
    colorscheme = {
      vim.g.lazyvim_colorscheme and vim.g.lazyvim_colorscheme or "catppuccin",
      "everforest",
      "tokyonight",
      "habamax",
    },
  }, -- use colors when installing missing plugin during startup
  checker = { enabled = false }, -- automatically check for plugin updates
  performance = {
    rtp = {
      -- disable some rtp plugins
      disabled_plugins = {
        "gzip",
        -- "matchit",
        -- "matchparen",
        -- "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})
